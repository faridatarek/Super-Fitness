import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/home/chatBot/presentation/view/message_widget.dart';
import 'package:super_fitness/features/home/chatBot/presentation/viewModel/chatBot_viewModel.dart';
import 'package:super_fitness/features/home/presentation/view/homeScreen.dart';
import 'package:super_fitness/features/mian_lay_out_screen/mian_lay_out_view/mian_lay_out_screen.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatCubit chatCubit = getIt<ChatCubit>();
  @override
  void initState() {
    super.initState();
    Gemini.init(apiKey: "AIzaSyAz8RYZjn37oQDVfCbs6SDIcRyW9KV_eIg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              '${PNGAssets.chatBackground}',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(),
          ),
          SafeArea(
            child: CustomAppBar(
              title: StringsManager.smartCoach.tr(),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const MainLayOutScreen()),
                    (route) => false);
              },
              // actions: [
              //   IconButton(
              //     onPressed: () {},
              //     icon: SvgPicture.asset(
              //       SVGAssets.optionsIcon,
              //       width: 25.w,
              //       height: 25.h,
              //     ),
              //   ),
              // ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70.h),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, BaseState>(
                    bloc: chatCubit,
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: chatCubit.messages.length,
                        itemBuilder: (context, index) {
                          return Message(
                            file: chatCubit.messages[index]["file"],
                            sender: chatCubit.messages[index]["sender"],
                            hasImage: chatCubit.messages[index]["hasImage"],
                            text: chatCubit.messages[index]["text"],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<ChatCubit, BaseState>(
                      bloc: chatCubit,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (chatCubit.file != null)
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(chatCubit.file!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            Row(
                              children: [
                                Expanded(
                                  child: BlocBuilder<ChatCubit, BaseState>(
                                    bloc: chatCubit,
                                    builder: (context, state) {
                                      return SizedBox(
                                        height: 60.h,
                                        child: TextField(
                                          maxLines: 1,
                                          controller: chatCubit.controller,
                                          style: const TextStyle(
                                              color: ColorManager.white),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.h,
                                                    horizontal: 15.w),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                  color: ColorManager.white,
                                                  width: 1.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                  color: ColorManager.white,
                                                  width: 2),
                                            ),
                                            hintText: StringsManager
                                                .typeYourMessage
                                                .tr(),
                                            hintStyle: const TextStyle(
                                                color: ColorManager.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: chatCubit.controller,
                                  builder: (context, value, child) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.send,
                                        color: value.text.isNotEmpty
                                            ? ColorManager.primary
                                            : Colors.grey,
                                        size: 30,
                                      ),
                                      onPressed: value.text.isNotEmpty
                                          ? () {
                                              chatCubit.sendMessage();
                                            }
                                          : null,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: ColorManager.primary,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    chatCubit.getImage();
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
