import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/base/base_states.dart';

@injectable
class ChatCubit extends BaseCubit {
  final TextEditingController controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? file;
  List<Map<String, dynamic>> messages = [];

  ChatCubit() : super();

  Future<void> getImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      file = File(photo.path);
      emit(ChatImagePicked(file!));
    }
  }

  void sendMessage() async {
    final userProvider = getIt<UserProvider>();

    if (userProvider.user == null) {
      debugPrint("⏳ User data is not ready yet. Waiting...");
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return userProvider.user == null;
      });
    }

    debugPrint("✅ User data loaded: ${userProvider.user?.firstName}");
    final userInfo = _getUserInfo(userProvider);
    final String userMessage = controller.text;
    final String fullMessage = "$userInfo\n\nUser Question: $userMessage";

    // Add user message
    messages.add({
      "text": userMessage,
      "file": file,
      "sender": true,
      "hasImage": file != null,
    });
    emit(ChatMessageAdded(messages.last));

    // Emit loading while waiting for Gemini
    emit(ChatLoading());

    Gemini gemini = Gemini.instance;
    if (file != null) {
      gemini.textAndImage(
        text: fullMessage,
        images: [file!.readAsBytesSync()],
      ).then((value) {
        messages.add({
          "text": value?.output ?? "⚠ No response",
          "file": null,
          "sender": false,
          "hasImage": false,
        });
        emit(ChatMessageAdded(messages.last));
      });
    } else {
      gemini.text(fullMessage).then((value) {
        messages.add({
          "text": value?.output ?? "⚠ No response",
          "file": null,
          "sender": false,
          "hasImage": false,
        });
        emit(ChatMessageAdded(messages.last));
      });
    }

    controller.clear();
    file = null;
  }

  String _getUserInfo(userProvider) {
    final userGoal = userProvider.user?.goal ?? "No specific goal.";
    final userAge = userProvider.user?.age ?? "Unspecified.";
    final userWeight = userProvider.user?.weight ?? "Unspecified.";
    final userHeight = userProvider.user?.height ?? "Unspecified.";
    final userName = userProvider.user?.firstName ?? "Unspecified.";
    final userGender = userProvider.user?.gender ?? "Unspecified.";
    final activityLevel = userProvider.user?.activityLevel ?? "Unspecified.";

    return "You are a smart assistant specializing in fitness and nutrition app (super fitness app). Use the following information about the user you are interacting with:\n"
        "- 🎯 Goal: $userGoal\n"
        "- 🏋 Age: $userAge years\n"
        "- ⚖ Weight: $userWeight kg\n"
        "- 📏 Height: $userHeight cm\n"
        "- 🏷 Name: $userName\n"
        "- ⚥ Gender: $userGender\n"
        "- 🔥 Activity Level: $activityLevel\n"
        "Please use this information to understand the user and provide personalized responses. Do not send their information back to them; keep it for reference when needed. Note: Keep your answers specific and concise.";
  }

  @override
  void start() {}
}

// ---------------- States ----------------
sealed class ChatState extends BaseState {}

class ChatInitial extends ChatState {}

class ChatImagePicked extends ChatState {
  final File file;
  ChatImagePicked(this.file);
}

class ChatMessageAdded extends ChatState {
  final Map<String, dynamic> message;
  ChatMessageAdded(this.message);
}

class ChatLoading extends ChatState {}
