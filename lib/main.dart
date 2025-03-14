import 'package:flutter/material.dart';
import 'core/router/router.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/size_config.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VocaGrowApp());
}

class VocaGrowApp extends StatelessWidget {
  const VocaGrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Voca Grow App',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
