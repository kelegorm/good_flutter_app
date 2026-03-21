import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_example/ui/common/context_extensions.dart';
import 'package:good_example/ui/design_system/app_spacing.dart';
import 'package:good_example/ui/design_system/components/app_headline.dart';
import 'package:good_example/ui/design_system/components/app_secondary_button.dart';
import 'package:good_example/ui/home/bloc/home_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => context.get<HomeBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Main app screen')),
        body: Center(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: _buildContent,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    switch (state) {
      case HomeInitial():
        return _buildInitial(context);
      case HomeSignOutInProgress():
        return _buildSigningOut(context);
      case HomeSignedOut():
        return _buildSignedOut();
    }
  }

  Widget _buildInitial(BuildContext context) {
    return _buildBody(
      button: AppSecondaryButton(
        onPressed: () => _onSignOutPressed(context),
        child: const Text('Sign out'),
      ),
    );
  }

  Widget _buildSigningOut(BuildContext context) {
    return _buildBody(
      button: AppSecondaryButton(
        onPressed: null,
        child: SizedBox.square(
          dimension: AppSpacing.lg,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildSignedOut() {
    return _buildBody(
      button: const AppSecondaryButton(
        onPressed: null,
        child: Text('Sign out'),
      ),
    );
  }

  Widget _buildBody({required Widget button}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppHeadline('Authorized area'),
        const SizedBox(height: AppSpacing.lg),
        button,
      ],
    );
  }

  void _onSignOutPressed(BuildContext context) {
    context.read<HomeBloc>().add(const HomeSignOutRequested());
  }
}
