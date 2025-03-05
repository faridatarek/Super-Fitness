import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/forget_password/data/models/requests/create_newpass_request.dart';
import 'package:super_fitness/features/forget_password/domain/data_intent/data_intent.dart';
import 'package:super_fitness/features/forget_password/domain/usecases/create_new_pass_use_case.dart';

import '../../../../../core/common/result.dart';
import '../../../../base/base_states.dart';
import '../../../data/models/responses/Create_new_pass_respones.dart';

@injectable
class CreateNewPassWordViewModel extends BaseCubit  {
  final CreateNewPasswordUseCase _createNewPasswordUseCase;

  final TextEditingController passWordController = TextEditingController();
  final TextEditingController emailController =
  TextEditingController(text: DataIntent.getUserMail() ?? '');
  static CreateNewPassWordViewModel get(BuildContext context) => BlocProvider.of<CreateNewPassWordViewModel>(context);

  CreateNewPassWordViewModel(this._createNewPasswordUseCase);


   Future<void> createNewPassWord(CreateNewPassWordRequest request) async {
     emit(LoadingState());

     final result = await _createNewPasswordUseCase.createNewPass(request);

     if (result is Success<CreateNewPassResponse?>) {
       emit(SuccessState('${result.data?.message}\n"Password reset successful!'));
       DataIntent.setUserMail(request.email);
     } else if (result is Fail<CreateNewPassResponse ?>) {
       emit(ErrorState(result.data?.error ?? ''));
     }
   }

  @override
  void start() {
  }



}
