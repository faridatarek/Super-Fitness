import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

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
        return (String? value) => null;
    }
  }

  String? Function(String?) _validateEmail() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '"email" is required';
      }
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return '"email" must be a valid email';
      }
      return null;
    };
  }

  String? Function(String?) _validatePassword() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '"password" is required';
      }

      final errors = <String>[];

      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        errors.add("must contain at least 1 uppercase letter");
      }
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        errors.add("must contain at least 1 lowercase letter");
      }
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        errors.add("must contain at least 1 number");
      }
      if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(value)) {
        errors.add("must contain at least 1 special character");
      }
      if (value.length < 8) {
        errors.add("must be at least 8 characters long");
      }

      if (errors.isNotEmpty) {
        return 'password is invalid:\n- ${errors.join("\n- ")}';
      }

      return null; // valid
    };
  }
}
