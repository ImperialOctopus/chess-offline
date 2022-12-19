import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router/router.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('chess', style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 64),
            IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () => AutoRouter.of(context).push(const GameRoute()),
                style: IconButton.styleFrom(
                  foregroundColor: colorScheme.onPrimary,
                  backgroundColor: colorScheme.primary,
                  disabledBackgroundColor:
                      colorScheme.onSurface.withOpacity(0.12),
                  hoverColor: colorScheme.onPrimary.withOpacity(0.08),
                  focusColor: colorScheme.onPrimary.withOpacity(0.12),
                  highlightColor: colorScheme.onPrimary.withOpacity(0.12),
                )),
          ],
        ),
      ),
    );
  }
}
