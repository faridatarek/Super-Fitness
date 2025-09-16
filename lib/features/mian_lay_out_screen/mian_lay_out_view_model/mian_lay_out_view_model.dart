import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness/features/edit_profile/presentation/views/profile_view.dart';
import 'package:super_fitness/features/home/chatBot/presentation/view/startChat_view.dart';
import 'package:super_fitness/features/home/presentation/view/coming_soon_screen.dart';
import 'package:super_fitness/features/home/presentation/view/home_view.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';
import '../../../../../utils/assets_manager.dart';

class MainLayoutViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  String _currentLanguage;

  static const String _languageKey = 'selected_language';

  MainLayoutViewModel() : _currentLanguage = _getDeviceLocale() {
    _loadLanguage();
  }

  int get selectedIndex => _selectedIndex;
  String get currentLanguage => _currentLanguage;

  List<TabItem> _getTabs() {
    return [
      TabItem(
        icon: SVGAssets.homeTab,
        label: Text(
          StringsManager.explore.tr(),
          style: AppTextStyles.font12W300Primary(),
        ),
        screen: const HomeView(),
      ),
      TabItem(
        icon: SVGAssets.gymTab,
        label: Text(
          StringsManager.workouts.tr(),
          style: AppTextStyles.font12W300Primary(),
        ),
        screen: const ComingSoonScreen(),
      ),
      TabItem(
        icon: SVGAssets.profileTab,
        label: Text(
          StringsManager.profile.tr(),
          style: AppTextStyles.font12W300Primary(),
        ),
        screen: const ProfileView(),
      ),
      TabItem(
        icon: SVGAssets.chatTab,
        label: Text(
          StringsManager.chat.tr(),
          style: AppTextStyles.font12W300Primary(),
        ),
        screen: StartchatView(),
      ),
    ];
  }

  List<TabItem> get tabs => _getTabs();

  void onItemTapped(int index) {
    if (index != _selectedIndex) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void setLanguage(String language) async {
    if (language != _currentLanguage) {
      _currentLanguage = language;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, language);
    }
  }

  Widget get currentScreen => tabs[_selectedIndex].screen;

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_languageKey);

    if (savedLanguage != null) {
      _currentLanguage = savedLanguage;
      notifyListeners();
    }
  }

  static String _getDeviceLocale() {
    final deviceLocale = PlatformDispatcher.instance.locale;
    return deviceLocale.languageCode;
  }
}

class TabItem {
  final String icon;
  final Text label;
  final Widget screen;

  TabItem({
    required this.icon,
    required this.label,
    required this.screen,
  });
}
