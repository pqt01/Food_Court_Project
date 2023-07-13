import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    // final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    // const int tabsCount = 3;
    final Color a = colorScheme.surface;
    return Scaffold(
      backgroundColor: a,
    );
  }
}
