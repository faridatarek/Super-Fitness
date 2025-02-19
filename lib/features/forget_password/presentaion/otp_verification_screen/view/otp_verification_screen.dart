import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_builder.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import 'package:super_fitness/features/forget_password/presentaion/otp_verification_screen/view/otp_verification_body.dart';
import 'package:super_fitness/features/forget_password/presentaion/otp_verification_screen/view_model/reset_code_view_model.dart';

import '../view_model/states.dart';


class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetIt.I<OtpVerifyViewModel>()..start(),
        child: BlocConsumer<OtpVerifyViewModel,BaseState>(
            builder: (context, state) {

              return baseBuilder(context, state, OtpVerificationBody(viewModel: OtpVerifyViewModel.get(context)));
            },
            listener: (context, state) {
              if (state is CorrectOtpState) {
                Navigator.pushNamed(context,AppRoutes.createNewPasswordScreen);
              }
              return baseListener(context, state);
            },
           ));
  }
}
