import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/providers/user_provider.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/utils/text_style.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    final String? imageUrl = user?.photo;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : const AssetImage('assets/images/avatar_placeholder.png')
                      as ImageProvider,
            ),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54.withOpacity(0.5),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          '${user?.firstName ?? 'Guest'} ${user?.lastName ?? ''}',
          style: AppTextStyles.font20W800White(),
        ),
      ],
    );
  }
}
