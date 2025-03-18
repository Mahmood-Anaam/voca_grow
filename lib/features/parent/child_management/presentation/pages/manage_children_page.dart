// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../core/router/routes.dart';
// import '../../../../../core/utils/assets.dart';
// import '../../../../../core/utils/size_config.dart';
// import '../../../../Auth/data/repositories/auth_repository.dart';
// import '../../bloc/child_bloc.dart';

// class ManageChildrenPage extends StatelessWidget {
//   const ManageChildrenPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user =
//         RepositoryProvider.of<AuthRepository>(
//           context,
//           listen: false,
//         ).getCurrentUser();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manage Children'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               context.pushNamed(AppRoute.childinfo.name, extra: null);
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<ChildBloc, ChildState>(
//         builder: (context, state) {
//           if (state is ChildLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ChildLoaded) {
//             final children = state.children;
//             return ListView.builder(
//               padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
//               itemCount: children.length,
//               itemBuilder: (context, index) {
//                 final child = children[index];
//                 return Card(
//                   elevation: 4,
//                   margin: EdgeInsets.only(bottom: SizeConfig.defaultSize! * 2),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: AssetImage(Assets.imagesHappyMic),
//                     ),
//                     title: Text(child.name),
//                     subtitle: Text(
//                       'Age: ${child.age}, Gender: ${child.gender}',
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () {
//                             context.read<ChildBloc>().add(
//                               DeleteChildEvent(child.id, user!.uid),
//                             );
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             context.read<ChildBloc>().add(
//                               DeleteChildEvent(child.id, user!.uid),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is ChildError) {
//             return Center(child: Text(state.message));
//           }
//           return const Center(child: Text('No children found'));
//         },
//       ),
//     );
//   }
// }
