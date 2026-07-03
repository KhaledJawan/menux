import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/auth_repository.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await ref.read(authRepositoryProvider).resetPassword(
            email: _emailController.text,
            newPassword: _newPasswordController.text,
          );
      setState(() => _success = true);
    } on AuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (_) {
      setState(() => _errorMessage = 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: _success
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.check_circle_rounded, size: 56, color: theme.colorScheme.primary),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Password updated. You can now sign in.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppButton(label: 'Back to Sign In', onPressed: () => context.pop()),
                      ],
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Menux has no email service configured in this build, so reset your '
                            'password directly below.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          if (_errorMessage != null) ...[
                            Text(
                              _errorMessage!,
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                          ],
                          AppTextField(
                            controller: _emailController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                (value == null || !value.contains('@')) ? 'Enter a valid email' : null,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          AppTextField(
                            controller: _newPasswordController,
                            label: 'New password',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: (value) =>
                                (value == null || value.length < 4) ? 'At least 4 characters' : null,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppButton(label: 'Reset Password', isLoading: _isLoading, onPressed: _submit),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
