import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/space_widget.dart';
import '../../bloc/child_bloc.dart';
import '../../data/models/child_model.dart';
import '../widgets/child_form_fields/activities_selection_widget.dart';
import '../widgets/child_form_fields/date_picker_widget.dart';
import '../widgets/child_form_fields/gender_dropdown_widget.dart';
import '../widgets/child_form_fields/text_input_widget.dart';

class ChildInfoPage extends StatefulWidget {
  final ChildModel? existingChild;

  const ChildInfoPage({super.key, this.existingChild});

  @override
  State<ChildInfoPage> createState() => _ChildInfoPageState();
}

class _ChildInfoPageState extends State<ChildInfoPage> {
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
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 14,
          title: Text(
            widget.existingChild == null ? 'Add New Child' : 'Edit Child',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: Theme.of(
            context,
          ).iconTheme.copyWith(color: Color.fromRGBO(208, 236, 227, 1)),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.imagesHappyMic,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                const VerticalSpace(3),
                TextInputWidget(
                  controller: _nameController,
                  label: 'Child Name',
                  icon: Icons.person,
                ),
            
                const VerticalSpace(2),
            
                GenderDropdownWidget(
                  value: _selectedGender,
                  onChanged: (value) => setState(() => _selectedGender = value),
                ),
            
                const VerticalSpace(2),
            
                DatePickerWidget(
                  date: _selectedBirthDate,
                  onDateChanged:
                      (date) => setState(() => _selectedBirthDate = date),
                ),
            
                const VerticalSpace(2),
            
                TextInputWidget(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
            
                const VerticalSpace(2),
            
                TextInputWidget(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
            
                const VerticalSpace(2),
            
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
            
                const VerticalSpace(4),
            
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
        ),
      ),
    );
  }
}
