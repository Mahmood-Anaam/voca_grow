import 'package:flutter/material.dart';
import '../widgets/home_body.dart';

class HomePsge extends StatelessWidget {
  const HomePsge({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(onPressed: () async {}, icon: const Icon(Icons.logout)),
          ],
        ),
        body: HomeBody(),
      ),
    );
  }
}
