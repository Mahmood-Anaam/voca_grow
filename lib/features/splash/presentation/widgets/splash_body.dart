import 'package:flutter/material.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/size_config.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesSplash),
          alignment: Alignment.center,
          repeat: ImageRepeat.repeat,
        ),
      ),
    );
  }
}
