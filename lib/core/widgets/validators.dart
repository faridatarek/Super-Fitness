import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness/utils/strings_manager.dart';

class AppValidators {
  AppValidators._();

  static String? validateEmail(String? val) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (val == null) {
      return StringsManager.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return StringsManager.validationsFieldRequired.tr();
    } else if (emailRegex.hasMatch(val) == false) {
      return StringsManager.validationsValidEmail.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
    if (val == null) {
      return StringsManager.validationsFieldRequired.tr();
    } else if (val.isEmpty) {
      return StringsManager.validationsFieldRequired.tr();
    } else if (val.length < 8 || !passwordRegex.hasMatch(val)) {
      return StringsManager.validationsPasswordSpecifications.tr();
    } else {
      return null;
    }
  }



}