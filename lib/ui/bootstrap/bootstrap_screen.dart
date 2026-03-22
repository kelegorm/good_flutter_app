import 'package:flutter/material.dart';
import 'package:good_example/ui/design_system/app_spacing.dart';
import 'package:good_example/ui/design_system/components/app_body_text.dart';

class BootstrapScreen extends StatelessWidget {
  final String? errorMessage;

  const BootstrapScreen({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: errorMessage != null ? _buildError() : _buildLoading(),
      ),
    );
  }

  Widget _buildLoading() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: AppSpacing.lg),
        AppBodyText('Preparing application...'),
      ],
    );
  }

  Widget _buildError() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBodyText(errorMessage!, textAlign: TextAlign.center),
      ],
    );
  }
}
