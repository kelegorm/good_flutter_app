import 'package:flutter/material.dart';
import 'package:good_example/ui/design_system/app_spacing.dart';

class BootstrapScreen extends StatelessWidget {
  const BootstrapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: AppSpacing.lg),
            Text('Preparing application...'),
          ],
        ),
      ),
    );
  }
}
