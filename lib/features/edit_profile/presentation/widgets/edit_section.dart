import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/selection_buttom.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/edit_profile/presentation/viewmodels/edit_profile_viewmodel.dart';
import 'package:super_fitness/features/edit_profile/presentation/widgets/edit_component.dart';
import 'package:super_fitness/utils/text_style.dart';

class EditSection extends StatelessWidget {
  final String title;
  final String value;
  final EditType type;
  final Function(String) onValueUpdated;

  const EditSection({
    super.key,
    required this.value,
    required this.title,
    required this.type,
    required this.onValueUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditComponent(
              type: type,
              currentValue: value,
            ),
          ),
        );

        if (result != null && result != value) {
          onValueUpdated(result);
          if (context.mounted) {
            context.read<EditProfileViewModel>().emit(ContentState());
          }
        }
      },
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                title,
                style: AppTextStyles.font16W500White(),
              ),
            ),
          ),
          SelectionButton(
            text: value,
            isSelected: false,
            onTap: () {},
            showRadio: false,
          ),
        ],
      ),
    );
  }
}
