import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/utils/strings_manager.dart';

import 'login_validator_types_enum.dart';

@injectable
class LoginValidator {
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  void attachListeners(VoidCallback onFieldsChanged) {
    _emailController.addListener(onFieldsChanged);
    _passwordController.addListener(onFieldsChanged);

  }

  void disposeFields() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  String? Function(String?) validate(LoginValidatorTypesEnum type) {
    switch (type) {
      case LoginValidatorTypesEnum.email:
        return _validateEmail();
      case LoginValidatorTypesEnum.password:
        return _validatePassword();
      default:
        return (String? value) {
          return null;
        };
    }
  }

  String? Function(String?) _validateEmail() {
    return (String? value) {
      if (value != null && (value.isEmpty || !value.contains("@"))) {
        return StringsManager.issueEmptyEamil;
      }
      return null;
    };
  }

  String? Function(String?) _validatePassword() {
    return (String? value) {
      final RegExp passwordRegExp = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
      if (value == null || value.isEmpty) {
        return StringsManager.issueEmptyPassword;
      } else if (!passwordRegExp.hasMatch(value)) {
        return StringsManager.issuePasswordPattern;
      }
      return null;
    };
  }

}