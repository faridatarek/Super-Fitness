import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

import 'dart:ui';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAssets.editProfileBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: AppSize.s5, sigmaY: AppSize.s5),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
          const SafeArea(
            child: HomeViewBody(),
          ),
        ],
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecommendationCubit(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChangeNotifierProvider.value(
            value: getIt<UserProvider>(),
            child: const GreetingHeader(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Categories', style: AppTextStyles.font24W500White()),
          ),
          const CategoryList(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Recommendation Today',
                style: AppTextStyles.font24W500White()),
          ),
          const SizedBox(height: 8),
          const RecommendedWorkoutList(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final String fullName =
        '${user?.firstName ?? 'Guest'} ${user?.lastName ?? ''}'.trim();

    final String? photo = user?.photo;
    final bool hasNetworkImage =
        photo != null && photo.startsWith('http') && photo.isNotEmpty;
    final bool hasFileImage =
        photo != null && photo.isNotEmpty && !photo.startsWith('http');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi $fullName,',
                style: AppTextStyles.font16W500White(),
              ),
              Text(
                "Let's Start Your Day",
                style: AppTextStyles.font24W800White(),
              ),
            ],
          ),
          // Profile Image
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            backgroundImage: hasNetworkImage
                ? NetworkImage(photo)
                : hasFileImage
                    ? FileImage(File(photo)) as ImageProvider
                    : null,
            child: (photo == null || photo.isEmpty)
                ? const Icon(Icons.person,
                    size: 28, color: ColorManager.primary)
                : null,
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  final List<Map<String, String>> categories = const [
    {
      'title': 'Gym',
      'icon': 'assets/png/gym_figure.png',
      'routeName': AppRoutes.comingSoonScreen,
    },
    {
      'title': 'Yoga',
      'icon': 'assets/png/yoga_figure.png',
      'routeName': AppRoutes.comingSoonScreen,
    },
    {
      'title': 'Aerobics',
      'icon': 'assets/png/Aerobics_figure.png',
      'routeName': AppRoutes.comingSoonScreen,
    },
    {
      'title': 'Trainer',
      'icon': 'assets/png/triner_figure.png',
      'routeName': AppRoutes.StartchatView,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const horizontalPadding = 8.0 * 2; // left and right
    const separatorWidth = 16.0 * 3; // 3 separators * margin
    final itemWidth =
        (screenWidth - horizontalPadding - separatorWidth) / categories.length;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.darkGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height * 0.12,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return SizedBox(
              width: itemWidth,
              child: CategoryItem(
                routeName: category['routeName']!,
                title: category['title']!,
                iconPath: category['icon']!,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: 1,
                height: MediaQuery.of(context).size.height * 0.08,
                color: ColorManager.lightGrey.withOpacity(0.2),
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.routeName});
  final String title;
  final String iconPath;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, fit: BoxFit.cover, width: 60, height: 60),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.font16W500White(),
          ),
        ],
      ),
    );
  }
}

class Workout {
  final String title;
  final String imagePath;

  Workout({required this.title, required this.imagePath});
}

class RecommendationCubit extends Cubit<List<Workout>> {
  RecommendationCubit() : super([]) {
    _generateDailyRecommendations();
  }

  final List<Workout> allWorkouts = [
    Workout(title: "Jogging", imagePath: "assets/images/jogging.jpeg"),
    Workout(title: "Push-Up", imagePath: "assets/images/push_ups.jpeg"),
    Workout(
        title: "Squat",
        imagePath: "assets/images/Blog_Resistance_Bands_Squat1.jpg"),
    Workout(title: "Plank", imagePath: "assets/images/details-plank.jpg"),
    Workout(title: "Crunch", imagePath: "assets/images/crunches.jpeg"),
  ];

  void _generateDailyRecommendations() {
    final today = DateTime.now().day;
    final random = Random(today);

    final shuffled = List<Workout>.from(allWorkouts)..shuffle(random);
    emit(shuffled.take(3).toList());
  }
}

class RecommendedWorkoutList extends StatelessWidget {
  const RecommendedWorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationCubit, List<Workout>>(
      builder: (context, workouts) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: workouts.map((w) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(w.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6)
                      ],
                    ),
                  ),
                  child: Text(w.title,
                      style: AppTextStyles.font16W500White(),
                      textAlign: TextAlign.center),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
