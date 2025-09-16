import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

import 'dart:ui';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.editProfileBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Blur Effect
            Positioned.fill(
              child: BackdropFilter(
                filter:
                    ImageFilter.blur(sigmaX: AppSize.s5, sigmaY: AppSize.s5),
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ),
            // Content
            const SafeArea(
              child: HomeViewBody(),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => RecommendationCubit(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChangeNotifierProvider.value(
              value: getIt<UserProvider>(),
              child: const GreetingHeader(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(StringsManager.categories.tr(),
                  style: AppTextStyles.font24W500White()),
            ),
            SizedBox(height: screenHeight * 0.01),
            CategoryList(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(StringsManager.recommendation.tr(),
                  style: AppTextStyles.font24W500White()),
            ),
            SizedBox(height: screenHeight * 0.01),
            const RecommendedWorkoutList(),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(StringsManager.recommendationForYou.tr(),
                  style: AppTextStyles.font24W500White()),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: SvgPicture.asset('assets/svg/dish-plate-svgrepo-com.svg',
                  width: screenWidth * 0.1, height: screenHeight * 0.1),
            ),
            SizedBox(height: screenHeight * 0.01),
            Center(
              child: Text(
                StringsManager.mealPlans.tr(),
                style:
                    AppTextStyles.font24W500White(color: ColorManager.primary),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final user = context.watch<UserProvider>().user;
    final String fullName =
        '${user?.firstName ?? 'Guest'} ${user?.lastName ?? ''}'.trim();

    final String? photo = user?.photo;
    final bool hasNetworkImage =
        photo != null && photo.startsWith('http') && photo.isNotEmpty;
    final bool hasFileImage =
        photo != null && photo.isNotEmpty && !photo.startsWith('http');

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${StringsManager.hi.tr()} $fullName,',
                  style: AppTextStyles.font16W500White(),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  StringsManager.letsStartYourDay.tr(),
                  style: AppTextStyles.font24W800White(),
                ),
              ],
            ),
          ),
          // Profile Image
          CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundColor: Colors.grey[300],
            backgroundImage: hasNetworkImage
                ? NetworkImage(photo)
                : hasFileImage
                    ? FileImage(File(photo)) as ImageProvider
                    : null,
            child: (photo == null || photo.isEmpty)
                ? Icon(Icons.person,
                    size: screenWidth * 0.07, color: ColorManager.primary)
                : null,
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  final List<Map<String, String>> categories = [
    {
      'title': StringsManager.gym.tr(),
      'icon': 'assets/png/gym_figure.png',
      'routeName': AppRoutes.comingSoonScreen,
    },
    {
      'title': StringsManager.yoga.tr(),
      'icon': 'assets/png/yoga_figure.png',
      'routeName': AppRoutes.comingSoonScreen,
    },
    {
      'title': StringsManager.aerobics.tr(),
      'icon': 'assets/png/Aerobics_figure.png',
      'routeName': AppRoutes.comingSoonScreen,
    },
    {
      'title': StringsManager.trainer.tr(),
      'icon': 'assets/png/triner_figure.png',
      'routeName': AppRoutes.StartchatView,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const horizontalPadding = 8.0 * 2;
    const separatorWidth = 16.0 * 3;
    final itemWidth =
        (screenWidth - horizontalPadding - separatorWidth) / categories.length;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.darkGrey,
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        height: screenHeight * 0.14,
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
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
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Container(
                width: 1,
                height: screenHeight * 0.08,
                color: ColorManager.lightGrey.withOpacity(0.2),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.routeName,
  });

  final String title;
  final String iconPath;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath,
              fit: BoxFit.cover,
              width: screenWidth * 0.15,
              height: screenWidth * 0.15),
          SizedBox(height: screenWidth * 0.02),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: AppTextStyles.font16W500White(),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class Workout {
  final String title;
  final String imagePath;
  final String gifPath;
  final String videoUrl;
  final String tutorial;

  Workout({
    required this.title,
    required this.imagePath,
    required this.gifPath,
    required this.videoUrl,
    this.tutorial = '',
  });
}

class RecommendationCubit extends Cubit<List<Workout>> {
  RecommendationCubit() : super([]) {
    _generateDailyRecommendations();
  }
  final List<Workout> allWorkouts = [
    Workout(
        title: "Jogging",
        imagePath: "assets/images/jogging.jpeg",
        gifPath: "assets/images/tutorials/ezgif-86539e826dedd6.gif",
        videoUrl: "https://www.youtube.com/shorts/A5uZobDo80Q",
        tutorial:
            "Start by standing upright with your feet hip-width apart. Keep your chest lifted, shoulders back, and arms relaxed by your sides. Begin jogging slowly, landing softly on the balls of your feet. Your knees should lift slightly and your arms should swing naturally in opposition to your legs. Maintain a tall posture and keep your gaze forward. Breathe rhythmically and increase pace gradually as you warm up."),
    Workout(
        title: "Push-Up",
        imagePath: "assets/images/push_ups.jpeg",
        gifPath: "assets/images/tutorials/anim-push-ups.gif",
        videoUrl: "https://youtube.com/shorts/GHJgsTIW_bQ?si=787FbrT8OuGd9-pc",
        tutorial:
            "Begin in a high plank position with your hands placed slightly wider than shoulder-width apart and your body forming a straight line from head to heels. Engage your core and glutes. Lower your body by bending your elbows to about 90 degrees, keeping them close to your body. Your chest should almost touch the floor. Push through your palms to return to the starting position. Keep your neck neutral and avoid arching your back."),
    Workout(
        title: "Squat",
        imagePath: "assets/images/Blog_Resistance_Bands_Squat1.jpg",
        gifPath: "assets/images/tutorials/squat.gif",
        videoUrl: "https://www.youtube.com/shorts/Bjfefk24UXM",
        tutorial:
            "Stand with your feet shoulder-width apart and toes slightly turned out. Engage your core and keep your chest up. Push your hips back and bend your knees to lower into a squat as if sitting on a chair. Go down until your thighs are parallel to the floor. Keep your knees aligned with your toes. Push through your heels to stand back up. Avoid leaning forward or letting your knees cave inward."),
    Workout(
        title: "Plank",
        imagePath: "assets/images/details-plank.jpg",
        gifPath:
            "assets/images/tutorials/weighted-front-plank-removebg-preview.png",
        videoUrl: "https://www.youtube.com/shorts/N7gBsBHnjcw",
        tutorial:
            "Start in a forearm plank position with your elbows directly under your shoulders and your body in a straight line from head to heels. Engage your core, glutes, and thighs. Avoid letting your hips sag or pike up. Keep your neck neutral and gaze slightly forward. Breathe steadily and hold the position for as long as you can maintain proper form."),
    Workout(
        title: "Crunch",
        imagePath: "assets/images/crunches.jpeg",
        gifPath: "assets/images/tutorials/Crunch.gif",
        videoUrl:
            "https://example.com/crunch_video.mp4", // Replace with the actual video URL
        tutorial:
            "Lie flat on your back with your knees bent and feet flat on the floor. Place your hands lightly behind your head without pulling your neck. Engage your core and lift your upper back off the floor using your abdominal muscles. Keep your lower back in contact with the ground. Pause at the top, then slowly lower back down. Avoid using momentum or straining your neck."),
    Workout(
        title: "Lunges",
        imagePath: "assets/images/8-around-the-clock-lunge.jpg",
        gifPath: "assets/images/tutorials/bodyweight-forward-lunge.gif",
        videoUrl: "https://www.youtube.com/shorts/05Hf8gM_KmM",
        tutorial:
            "Stand upright with your feet hip-width apart. Take a big step forward with your right leg and lower your hips until both knees are bent at 90 degrees. The back knee should hover just above the floor, and the front knee should not pass your toes. Push through your front heel to return to the starting position. Repeat on the other leg. Keep your upper body upright and your core tight throughout the movement."),
    Workout(
        title: "High Knees",
        imagePath: "assets/images/How-to-do-High-Knees.jpg",
        gifPath: "assets/images/tutorials/High-Knee-Run.gif",
        videoUrl: "https://www.youtube.com/shorts/LJMrXG_vPQ8",
        tutorial:
            "Stand tall with your feet hip-width apart. Begin by jogging in place while driving your knees up toward your chest as high as possible. Pump your arms rapidly in rhythm with your legs. Stay light on your feet and land softly with each step. Keep your chest lifted and core engaged. Increase your speed to raise your heart rate."),
    // Workout(
    //     title: "Jumping Jacks",
    //     imagePath: "assets/images/OIP.jpg",
    //     gifPath: "assets/images/tutorials/jumping_jacks.gif",
    //     videoUrl: "https://example.com/jumping_jacks_video.mp4",
    //     tutorial:
    //         "Start standing upright with your arms at your sides. Jump up and simultaneously spread your legs out to the sides while raising your arms overhead. Quickly reverse the motion to return to the starting position. Continue the movement at a steady pace. Keep your core engaged and knees slightly bent to absorb impact."),
    Workout(
        title: "Bicycle Crunches",
        imagePath: "assets/images/body-weight-brutality.jpg",
        gifPath: "assets/images/tutorials/bicycle_crunch.gif",
        videoUrl: "https://www.youtube.com/shorts/bhCHYOlmcLI",
        tutorial:
            "Lie on your back with your hands behind your head and legs lifted. Bring your right elbow toward your left knee while extending the right leg out straight. Switch sides by bringing your left elbow toward your right knee while extending the left leg. Continue alternating in a pedaling motion. Keep your lower back on the floor and avoid pulling your head forward."),
    Workout(
        title: "Leg Raises",
        imagePath: "assets/images/leg_rases.jpg",
        gifPath: "assets/images/tutorials/supine-leg-raises.gif",
        videoUrl:
            "https://www.youtube.com/watch?v=G7LdiX_jba4&ab_channel=DEMIC",
        tutorial:
            "Lie on your back with your legs straight and arms by your sides. Keeping your legs together, lift them slowly until they form a 90-degree angle with your torso. Slowly lower them back down without letting them touch the floor. Engage your core throughout the movement and avoid arching your lower back."),
    Workout(
        title: "Tricep Dips",
        imagePath: "assets/images/IMG_0606.jpg",
        gifPath: "assets/images/tutorials/Triceps-Dips-on-Floor.gif",
        videoUrl: "https://www.youtube.com/shorts/4ua3MzaU0QU",
        tutorial:
            "Sit on the floor with your knees bent and hands behind you, fingers pointing toward your body. Lift your hips off the ground and bend your elbows to lower your body until your arms form 90-degree angles. Push through your palms to return to the top. Keep your elbows pointing backward and core engaged throughout the movement."),
    Workout(
        title: "Wall Sit",
        imagePath: "assets/images/walls-sits.jpg",
        gifPath: "assets/images/tutorials/goblet-wall-sit-muscles.gif",
        videoUrl: "https://www.youtube.com/shorts/mDdLC-yKudY",
        tutorial:
            "Stand with your back against a wall and slide down until your thighs are parallel to the floor. Your knees should be directly above your ankles, and your back should be flat against the wall. Hold the position for as long as you can while keeping your core tight and breathing steadily."),
    Workout(
        title: "Bridge",
        imagePath: "assets/images/R.jpeg",
        gifPath: "assets/images/tutorials/glutes_bridge.gif",
        videoUrl:
            "https://www.youtube.com/watch?v=SKOMwg1JLrU&ab_channel=NationalAcademyofSportsMedicine%28NASM%29",
        tutorial:
            "Lie on your back with your knees bent and feet flat on the floor, hip-width apart. Place your arms at your sides. Engage your glutes and lift your hips toward the ceiling until your body forms a straight line from shoulders to knees. Pause at the top, then slowly lower your hips back down. Avoid overarching your back and keep your core engaged throughout the exercise."),
  ];

  void _generateDailyRecommendations() {
    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);

    final shuffled = List<Workout>.from(allWorkouts)..shuffle(random);
    emit(shuffled.take(3).toList());
  }
}

class RecommendedWorkoutList extends StatelessWidget {
  const RecommendedWorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<RecommendationCubit, List<Workout>>(
      builder: (context, workouts) {
        return SizedBox(
          height: screenHeight * 0.18,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final w = workouts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WorkoutDetailScreen(workout: w),
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.15,
                  margin: EdgeInsets.only(right: screenWidth * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    image: DecorationImage(
                      image: AssetImage(w.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6)
                        ],
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(screenWidth * 0.05),
                          bottomRight: Radius.circular(screenWidth * 0.05),
                        ),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.01),
                      child: Text(
                        w.title,
                        style: AppTextStyles.font16W500White(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class WorkoutDetailScreen extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  Future<void> _launchYouTube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
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
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                    title: workout.title,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                if (workout.tutorial.isNotEmpty)
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: ColorManager.darkGrey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Text(
                      workout.tutorial,
                      style: AppTextStyles.font16W500White(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Text(
                    'Animated Tutorial',
                    style: AppTextStyles.font18W400White(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    child: Image.asset(
                      workout.gifPath,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: screenHeight * 0.3,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                  child: ElevatedButton.icon(
                    onPressed: () => _launchYouTube(workout.videoUrl),
                    icon: Icon(Icons.play_circle, size: screenWidth * 0.06),
                    label: Text(
                      "Watch on YouTube",
                      style: AppTextStyles.font16W500White(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.04,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
