// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_tracker_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:budget_tracker_app/screens/base/home.dart';
import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:budget_tracker_app/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageService = LocalStorageService();
  await localStorageService.initializeHive();
  final sharedPrefs = await SharedPreferences.getInstance();
  return runApp(MyApp(
    sharedPreferences: sharedPrefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(
            create: (_) => ThemeService(sharedPreferences)),
        ChangeNotifierProvider<BudgetViewModel>(create: (_) => BudgetViewModel()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeService = Provider.of<ThemeService>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            colorScheme: ColorScheme.fromSeed(
              brightness:
                  themeService.darkTheme ? Brightness.dark : Brightness.light,
              seedColor: Colors.indigo,
            ),
          ),
          home: Home(),
        );
      }),
    );
  }
}
