import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Colors.blue;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                controller.animateToPage(0,
                    duration: const Duration(microseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.home),
            ),
            const SizedBox(),
            IconButton(
              onPressed: () {
                controller.animateToPage(1,
                    duration: const Duration(microseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.bookmark),
            ),
          ],
        ),
      ),
    );
  }
}
