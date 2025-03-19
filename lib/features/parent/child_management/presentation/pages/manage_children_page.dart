import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/size_config.dart';
import '../../bloc/child_bloc.dart';
import '../widgets/child_empty_state_widget.dart';
import '../widgets/child_list_item_widget.dart';

class ManageChildrenPage extends StatelessWidget {
  const ManageChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 14,
          title: Text('Manage Children', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: Theme.of(
            context,
          ).iconTheme.copyWith(color: Color.fromRGBO(208, 236, 227, 1)),

          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.pushNamed(AppRoute.childinfo.name),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesBottomPolygon),
              alignment: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: BlocBuilder<ChildBloc, ChildState>(
                builder: (context, state) {
                  if (state is ChildLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ChildrenLoaded) {
                    return state.children.isEmpty
                        ? ChildEmptyStateWidget(
                          onAddChild:
                              () => context.pushNamed(AppRoute.childinfo.name),
                        )
                        : ListView.builder(
                          padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                          itemCount: state.children.length,
                          itemBuilder: (context, index) {
                            final child = state.children[index];
                            return ChildListItemWidget(
                              child: child,
                              onEdit:
                                  () => context.pushNamed(
                                    AppRoute.childinfo.name,
                                    extra: child,
                                  ),
                              onDelete:
                                  () => context.read<ChildBloc>().add(
                                    DeleteChild(child.id),
                                  ),
                            );
                          },
                        );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<ChildBloc, ChildState>(
          builder: (context, state) {
            if (state is ChildrenLoaded && state.children.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () => context.pushNamed(AppRoute.childinfo.name),
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.add),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
