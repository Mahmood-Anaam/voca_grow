import 'package:flutter/material.dart';
import '../../../../../core/utils/assets.dart';
import '../widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesBottomPolygon),
              alignment: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesTopPolygon),
                alignment: Alignment.topLeft,
              ),
            ),
            child: SafeArea(child: Center(child: HomeBody())),
          ),
        ),
      ),
    );
  }
}
