import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/child_bloc.dart';
import '../../data/models/child_model.dart';
import 'child_form_fields/text_input_widget.dart';
import 'child_form_fields/gender_dropdown_widget.dart';
import 'child_form_fields/date_picker_widget.dart';
import 'child_form_fields/activities_selection_widget.dart';

class ChildFormWidget extends StatefulWidget {
  final ChildModel? existingChild;

  const ChildFormWidget({super.key, this.existingChild});

  @override
  State<ChildFormWidget> createState() => _ChildFormWidgetState();
}

class _ChildFormWidgetState extends State<ChildFormWidget> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  Gender? _selectedGender;
  DateTime? _selectedBirthDate;
  List<Activity> _selectedActivities = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final child = widget.existingChild;
    _nameController = TextEditingController(text: child?.name ?? '');
    _emailController = TextEditingController(text: child?.email ?? '');
    _passwordController = TextEditingController(text: child?.password ?? '');
    _selectedGender = child?.gender;
    _selectedBirthDate = child?.birthDate;
    _selectedActivities = child?.availableActivities ?? [];
  }

  bool _validateChildData() {
    return _nameController.text.isNotEmpty &&
        _selectedGender != null &&
        _selectedBirthDate != null &&
        _selectedActivities.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _saveChild() {
    if (_validateChildData()) {
      final childModel = ChildModel(
        id:
            widget.existingChild?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        gender: _selectedGender!,
        birthDate: _selectedBirthDate!,
        availableActivities: _selectedActivities,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (widget.existingChild == null) {
        context.read<ChildBloc>().add(AddChild(childModel));
      } else {
        context.read<ChildBloc>().add(UpdateChild(childModel));
      }

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.existingChild == null ? 'Add New Child' : 'Edit Child',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextInputWidget(
              controller: _nameController,
              label: 'Child Name',
              icon: Icons.person,
            ),
            const SizedBox(height: 15),
            GenderDropdownWidget(
              value: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            const SizedBox(height: 15),
            DatePickerWidget(
              date: _selectedBirthDate,
              onDateChanged:
                  (date) => setState(() => _selectedBirthDate = date),
            ),
            const SizedBox(height: 15),
            ActivitiesSelectionWidget(
              selectedActivities: _selectedActivities,
              onActivityToggle: (activity, isSelected) {
                setState(() {
                  if (isSelected) {
                    _selectedActivities.add(activity);
                  } else {
                    _selectedActivities.remove(activity);
                  }
                });
              },
            ),
            const SizedBox(height: 15),
            TextInputWidget(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            TextInputWidget(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChild,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.existingChild == null ? 'Add Child' : 'Update Child',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
