import 'package:flutter/material.dart';
import '../../../data/models/child_model.dart';

class GenderDropdownWidget extends StatelessWidget {
  final Gender? value;
  final void Function(Gender?) onChanged;

  const GenderDropdownWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: const Icon(Icons.wc),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      value: value,
      items:
          Gender.values
              .map(
                (gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender == Gender.male ? 'Boy' : 'Girl'),
                ),
              )
              .toList(),
      onChanged: onChanged,
    );
  }
}
