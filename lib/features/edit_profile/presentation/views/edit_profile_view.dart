// import 'package:flutter/material.dart';
// import 'package:super_fitness/core/widgets/custom_appbar.dart';
// import 'package:super_fitness/core/widgets/custom_textfield.dart';
// import 'package:super_fitness/features/edit_profile/presentation/widgets/profile_header.dart';
// import 'package:super_fitness/utils/assets_manager.dart';

// class EditProfileView extends StatelessWidget {
//   const EditProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//         backGroundImage: ImageAssets.forgetPassBackground,
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 30),
//               CustomAppBar(title: 'Edit Profile'),

//               const SizedBox(height: 20),
//               const Center(child: ProfileHeader()),
//               SizedBox(height: 40), // Added ProfileHeader here
//               CustomTextField(
//                 hint: 'first name',
//                 controller: TextEditingController(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//               SizedBox(height: 16),
//               CustomTextField(
//                 hint: 'last name',
//                 controller: TextEditingController(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//               SizedBox(height: 16),
//               CustomTextField(
//                 hint: 'email',
//                 controller: TextEditingController(),
//                 prefixIcon: Icon(Icons.email),
//               ),

//               const Spacer(),
//             ],
//           ),
//         ));
//   }
// }
