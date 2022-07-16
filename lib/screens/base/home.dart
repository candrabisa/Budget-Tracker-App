import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:budget_tracker_app/widget/add_budget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/theme_service.dart';
import '../home_screen.dart';
import '../profile_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  List<Widget> pages = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
        leading: IconButton(
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
          icon: Icon(themeService.darkTheme ? Icons.sunny : Icons.dark_mode),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddBudgetDialog(budgetToAdd: (budget) {
                      final budgetService =
                          Provider.of<BudgetViewModel>(context, listen: false);
                      budgetService.budget = budget;
                    });
                  });
            },
            icon: const Icon(Icons.attach_money),
          ),
        ],
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPageIndex,
          items: bottomNavItems,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          }),
    );
  }
}
