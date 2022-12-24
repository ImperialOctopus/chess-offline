import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router/router.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('"chess"', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: () => AutoRouter.of(context).push(const GameRoute()),
              child: const Text('new game'),
            ),
          ],
        ),
      ),
    );
  }
}
