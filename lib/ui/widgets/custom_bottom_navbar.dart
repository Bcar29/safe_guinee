import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int index;
  final Function(int index) onTap;
  const CustomBottomNavbar({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
          activeIcon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.navigation_outlined),
          label: "Navigation",
          activeIcon: Icon(Icons.navigation),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report_problem_outlined),
          label: "Signaler",
          activeIcon: Icon(Icons.report_problem),
        ),
      ],
    );
  }
}
