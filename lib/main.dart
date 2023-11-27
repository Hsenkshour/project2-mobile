import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/car_provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Car Helper App',
        theme: AppTheme.getTheme(),
        home: HomeScreen(),
      ),
    );
  }
}
