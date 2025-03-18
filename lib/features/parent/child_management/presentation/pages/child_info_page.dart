// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../core/utils/assets.dart';
// import '../../../../../core/utils/size_config.dart';
// import '../../../../../core/widgets/space_widget.dart';
// import '../../../../Auth/data/repositories/auth_repository.dart';
// import '../../bloc/child_bloc.dart';
// import '../../data/models/child_model.dart';

// class ChildInfoPage extends StatelessWidget {
//   final Child? child;

//   const ChildInfoPage({super.key, this.child});

//   @override
//   Widget build(BuildContext context) {
//     final user =
//         RepositoryProvider.of<AuthRepository>(
//           context,
//           listen: false,
//         ).getCurrentUser();

//     final formKey = GlobalKey<FormState>();
//     final nameController = TextEditingController(text: child?.name ?? '');
//     final ageController = TextEditingController(
//       text: child?.age.toString() ?? '',
//     );
//     String? gender = child?.gender;

//     return Scaffold(
//       appBar: AppBar(title: Text(child == null ? 'Add Child' : 'Edit Child')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: SizeConfig.defaultSize! * 6,
//                 backgroundImage: AssetImage(Assets.imagesHappyMic),
//               ),
//               const VerticalSpace(3),
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   prefixIcon: Icon(Icons.person),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the child\'s name';
//                   }
//                   return null;
//                 },
//               ),
//               const VerticalSpace(2),
//               TextFormField(
//                 controller: ageController,
//                 decoration: const InputDecoration(
//                   labelText: 'Age',
//                   prefixIcon: Icon(Icons.cake),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the child\'s age';
//                   }
//                   if (int.tryParse(value) == null) {
//                     return 'Please enter a valid age';
//                   }
//                   return null;
//                 },
//               ),
//               const VerticalSpace(2),
//               DropdownButtonFormField<String>(
//                 value: gender,
//                 decoration: const InputDecoration(
//                   labelText: 'Gender',
//                   prefixIcon: Icon(Icons.people),
//                 ),
//                 items:
//                     ['Male', 'Female'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                 onChanged: (value) {
//                   gender = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select the child\'s gender';
//                   }
//                   return null;
//                 },
//               ),
//               const VerticalSpace(4),
//               ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     final newChild = Child(
//                       id: child?.id ?? DateTime.now().toString(),
//                       name: nameController.text,
//                       age: int.parse(ageController.text),
//                       gender: gender!,
//                     );
//                     if (child == null) {
//                       context.read<ChildBloc>().add(
//                         AddChildEvent(newChild, user!.uid),
//                       );
//                     } else {
//                       context.read<ChildBloc>().add(
//                         UpdateChildEvent(newChild, user!.uid),
//                       );
//                     }
//                     context.pop();
//                   }
//                 },
//                 child: Text(child == null ? 'Add Child' : 'Update Child'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
