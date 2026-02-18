import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../../../common_widgets/error_view.dart';
import '../providers/auth_controller.dart'; // NEW IMPORT

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParams = GoRouterState.of(context).uri.queryParameters;
      if (queryParams.containsKey('phone')) {
        _phoneController.text = queryParams['phone']!;
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enter OTP',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text('We have sent a 6‑digit code to your phone'),
                  const SizedBox(height: 30),
                  CustomTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: Validators.phone,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'OTP Code',
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    validator: (v) => Validators.required(v, 'OTP'),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'New Password',
                    controller: _newPasswordController,
                    obscureText: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Confirm New Password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator:
                        (v) => Validators.confirmPassword(
                          v,
                          _newPasswordController.text,
                        ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Reset Password',
                    isLoading: authState.isLoading,
                    onPressed: _submit,
                  ),
                  if (authState.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ErrorView(error: authState.error!),
                    ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Back to Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).clearError();
      
      final success = await ref.read(authControllerProvider.notifier).resetPassword(
        _phoneController.text,
        _otpController.text,
        _newPasswordController.text,
      );
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset successful. Please login.'),
          ),
        );
        context.go('/login');
      }
    }
  }
}