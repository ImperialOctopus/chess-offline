import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router/router.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('chess'),
          ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(const GameRoute());
              },
              child: const Text('start')),
        ],
      ),
    );
  }
}
