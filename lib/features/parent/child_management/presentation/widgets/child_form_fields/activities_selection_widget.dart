import 'package:flutter/material.dart';
import '../../../../../../core/widgets/space_widget.dart';
import '../../../data/models/child_model.dart';

class ActivitiesSelectionWidget extends StatelessWidget {
  final List<Activity> selectedActivities;
  final void Function(Activity, bool) onActivityToggle;

  const ActivitiesSelectionWidget({
    super.key,
    required this.selectedActivities,
    required this.onActivityToggle,
  });

  String _getActivityName(Activity activity) {
    switch (activity) {
      case Activity.speechTherapy:
        return 'Speech Therapy';
      case Activity.reading:
        return 'Reading';
      case Activity.singing:
        return 'Singing';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Activities',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const VerticalSpace(1),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              Activity.values.map((activity) {
                final isSelected = selectedActivities.contains(activity);
                return ChoiceChip(
                  label: Text(_getActivityName(activity)),
                  selected: isSelected,
                  onSelected:
                      (selected) => onActivityToggle(activity, selected),
                  selectedColor: Theme.of(
                    context,
                  ).primaryColor.withValues(alpha: 0.2),
                );
              }).toList(),
        ),
      ],
    );
  }
}
