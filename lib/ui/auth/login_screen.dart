import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_example/ui/auth/bloc/login_bloc.dart';
import 'package:good_example/ui/common/context_extensions.dart';
import 'package:good_example/ui/design_system/app_spacing.dart';
import 'package:good_example/ui/design_system/components/app_body_text.dart';
import 'package:good_example/ui/design_system/components/app_headline.dart';
import 'package:good_example/ui/design_system/components/app_primary_button.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => context.get<LoginBloc>(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: _buildContent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, LoginState state) {
    switch (state) {
      case LoginInitial():
        return _buildInitial(context);
      case LoginInProgress():
        return _buildInProgress(context);
      case LoginSuccess():
        return _buildSuccess();
      case LoginFailure():
        return _buildFailure(context, state.message);
    }
  }

  Widget _buildInitial(BuildContext context) {
    return _buildForm(
      button: AppPrimaryButton(
        onPressed: () => _onSignInPressed(context),
        child: const Text('Sign in'),
      ),
    );
  }

  Widget _buildInProgress(BuildContext context) {
    return _buildForm(
      button: AppPrimaryButton(
        onPressed: null,
        child: SizedBox.square(
          dimension: AppSpacing.lg,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return _buildForm(
      button: const AppPrimaryButton(
        onPressed: null,
        child: Text('Sign in'),
      ),
    );
  }

  Widget _buildFailure(BuildContext context, String message) {
    return _buildForm(
      message: message,
      button: AppPrimaryButton(
        onPressed: () => _onSignInPressed(context),
        child: const Text('Try again'),
      ),
    );
  }

  Widget _buildForm({required Widget button, String? message}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppHeadline(
          'Sign in to continue',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        AppBodyText(
          message ?? 'Bootstrap is complete, locale can already be initialized here later.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        button,
      ],
    );
  }

  void _onSignInPressed(BuildContext context) {
    // TODO: replace with actual form field values when login form is added
    context.read<LoginBloc>().add(const LoginSignInRequested(
      username: 'demo',
      password: 'demo',
    ));
  }
}
