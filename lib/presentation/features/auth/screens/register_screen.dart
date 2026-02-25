import 'package:ecom_frontend/providers/pending_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_textfield.dart';

import '../../../common_widgets/error_view.dart';
import '../widgets/role_switch.dart';
import '../widgets/seller_fields.dart';
import '../providers/auth_controller.dart'; // NEW IMPORT
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSeller = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Seller controllers
  final _businessNameController = TextEditingController();
  final _businessRegNumberController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _businessPhoneController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankAccountNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _mobileMoneyProviderController = TextEditingController();
  final _mobileMoneyNumberController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  Map<String, TextEditingController> get _sellerControllers => {
    'businessName': _businessNameController,
    'businessRegNumber': _businessRegNumberController,
    'businessAddress': _businessAddressController,
    'businessPhone': _businessPhoneController,
    'bankName': _bankNameController,
    'bankAccountName': _bankAccountNameController,
    'bankAccountNumber': _bankAccountNumberController,
    'mobileMoneyProvider': _mobileMoneyProviderController,
    'mobileMoneyNumber': _mobileMoneyNumberController,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _sellerControllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WATCH THE NEW CONTROLLER
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Color(0xFFFFFAD3),

      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Color(0xFFFFFAD3),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  RoleSwitch(
                    isSeller: _isSeller,
                    onChanged: (v) => setState(() => _isSeller = v),
                  ),

                  const SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            _selectedImage != null
                                ? FileImage(File(_selectedImage!.path))
                                : null,
                        child:
                            _selectedImage == null
                                ? const Icon(Icons.camera_alt, size: 40)
                                : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Full Name',
                    controller: _nameController,
                    validator: (v) => Validators.required(v, 'Name'),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: Validators.phone,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Confirm Password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator:
                        (v) => Validators.confirmPassword(
                          v,
                          _passwordController.text,
                        ),
                  ),
                  const SizedBox(height: 16),
                  if (_isSeller) ...[
                    SellerFields(controllers: _sellerControllers),
                  ],
                  const SizedBox(height: 24),

                  // UPDATED BUTTON LOGIC
                  CustomButton(
                    text: 'Sign Up',
                    isLoading: authState.isLoading,
                    onPressed: _submit,
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('OR'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text('Sign up with Google'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: () => context.go('/login'),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // UPDATED ERROR VIEW
                  if (authState.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ErrorView(error: authState.error!),
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

      final data = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        if (_isSeller) ...{
          'businessName': _businessNameController.text,
          'businessRegNumber': _businessRegNumberController.text,
          'businessAddress': _businessAddressController.text,
          'businessPhone': _businessPhoneController.text,
          'bankName': _bankNameController.text,
          'bankAccountName': _bankAccountNameController.text,
          'bankAccountNumber': _bankAccountNumberController.text,
          'mobileMoneyProvider': _mobileMoneyProviderController.text,
          'mobileMoneyNumber': _mobileMoneyNumberController.text,
        },
      };

      // Call Register
      final success = await ref
          .read(authControllerProvider.notifier)
          .register(data, _isSeller);
      if (_selectedImage != null) {
        try {
          final formData = FormData.fromMap({
            'profileImage': await MultipartFile.fromFile(_selectedImage!.path),
          });
          await ref
              .read(authControllerProvider.notifier)
              .uploadProfileImage(formData);
        } catch (e) {
          // Optionally show a snackbar, but don't block verification
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Image upload failed: $e')));
        }
      }
      if (success && mounted) {
        // Store credentials for auto-login after verification
        // (We keep this simplified PendingAuth logic for now since you have the file)
        ref.read(pendingAuthProvider.notifier).state = PendingAuth(
          phone: _phoneController.text,
          password: _passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful. Please verify your phone.'),
          ),
        );
        context.push('/verify-phone?phone=${_phoneController.text}');
      }
    }
  }
}
