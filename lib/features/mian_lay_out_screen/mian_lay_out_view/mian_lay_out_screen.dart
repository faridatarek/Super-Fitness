import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/color_manager.dart';
import '../../../../../utils/values_manager.dart';
import '../mian_lay_out_view_model/mian_lay_out_view_model.dart';

class MainLayOutScreen extends StatelessWidget {
  const MainLayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainLayoutViewModel(),
      child: Builder(
        builder: (context) {
          final locale = context.locale;
          return _MainLayoutBody(
            key: ValueKey(locale.toString()),
          );
        },
      ),
    );
  }
}

class _MainLayoutBody extends StatelessWidget {
  const _MainLayoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainLayoutViewModel>();

    return WillPopScope(
      onWillPop: () async {
        if (viewModel.selectedIndex != 0) {
          viewModel.onItemTapped(0);
          return false;
        }
        SystemNavigator.pop();

        return true;
      },
      child: Scaffold(
        extendBody: true,
        body: viewModel.currentScreen,
        bottomNavigationBar: _MainBottomNavigationBar(),
      ),
    );
  }
}

class _MainBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainLayoutViewModel>();
    final selectedIndex = viewModel.selectedIndex;
    final tabs = viewModel.tabs;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.darkGrey,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => viewModel.onItemTapped(index),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: isSelected
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.05),
                        )
                      : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        tabs[index].icon,
                        colorFilter: ColorFilter.mode(
                          isSelected ? ColorManager.primary : Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: AppSize.s28,
                      ),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            tabs[index].label.data!,
                            style: const TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
