import 'package:flutter/material.dart';

class ChildEmptyStateWidget extends StatelessWidget {
  final VoidCallback onAddChild;

  const ChildEmptyStateWidget({super.key, required this.onAddChild});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.child_care,
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 20),
          const Text('No children added yet', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onAddChild,
            child: const Text('Add First Child'),
          ),
        ],
      ),
    );
  }
}
