import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../../../common_widgets/error_view.dart';
import '../providers/auth_controller.dart'; // NEW IMPORT
import '../../../../providers/pending_auth_provider.dart';

class PhoneVerificationScreen extends ConsumerStatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  ConsumerState<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends ConsumerState<PhoneVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  String? _phone;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParams = GoRouterState.of(context).uri.queryParameters;
      setState(() {
        _phone = queryParams['phone'];
      });
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use the AuthController
    final authState = ref.watch(authControllerProvider);
    final pendingAuth = ref.read(pendingAuthProvider); // Use read for data we just need once

    return Scaffold(
      appBar: AppBar(title: const Text('Verify Phone')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter Verification Code',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text('We have sent a 6-digit code to $_phone'),
                const SizedBox(height: 30),
                CustomTextField(
                  label: 'OTP Code',
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  validator: (v) => Validators.required(v, 'OTP'),
                ),
                const SizedBox(height: 32),
                
                // UPDATED BUTTON
                CustomButton(
                  text: 'Verify',
                  isLoading: authState.isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _phone != null) {
                       final controller = ref.read(authControllerProvider.notifier);
                       controller.clearError();

                       // 1. Verify OTP
                       final success = await controller.verifyOtp(
                          _phone!,
                          _otpController.text,
                       );

                       if (success) {
                         // 2. Auto Login if we have pending credentials
                         if (pendingAuth != null) {
                            await controller.login(pendingAuth.phone, pendingAuth.password);
                            // Clear pending auth
                            ref.read(pendingAuthProvider.notifier).state = null;
                         }

                         if (mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Phone verified successfully!')),
                           );
                           // Go home (Router redirect will handle it, but explicit is fine)
                           context.go('/home');
                         }
                       }
                    }
                  },
                ),

                if (authState.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ErrorView(error: authState.error!),
                  ),
                TextButton(
                  onPressed: () {
                    // Resend logic
                  },
                  child: const Text('Resend Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}