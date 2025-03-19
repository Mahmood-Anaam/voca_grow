import 'package:flutter/material.dart';
import '../../../../../core/utils/size_config.dart';
import '../../data/models/child_model.dart';

class ChildListItemWidget extends StatelessWidget {
  final ChildModel child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ChildListItemWidget({
    super.key,
    required this.child,
    required this.onEdit,
    required this.onDelete,
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
    return Card(
      margin: EdgeInsets.only(bottom: SizeConfig.defaultSize! * 2),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              child.gender == Gender.male ? Colors.blue : Colors.pink,
          child: Icon(
            child.gender == Gender.male
                ? Icons.boy_rounded
                : Icons.girl_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          child.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Age: ${DateTime.now().year - child.birthDate.year} years'),
            Text(
              'Activities: ${child.availableActivities.map(_getActivityName).join(", ")}',
            ),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                onEdit();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
