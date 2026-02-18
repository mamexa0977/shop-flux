import 'dart:io';
import 'package:ecom_frontend/core/constants/api_endpoints.dart';
import 'package:ecom_frontend/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/validators.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../../../common_widgets/error_view.dart';
import '../providers/auth_controller.dart'; // NEW IMPORT

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    // Get current user data to fill fields
    final user = ref.read(authStateProvider);
    if (user != null) {
      _nameController.text = user.name;
      _phoneController.text = user.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Watch controller for loading state (when saving)
    final authState = ref.watch(authControllerProvider);
    // 2. Watch user for displaying current image
    final user = ref.watch(authStateProvider);

    if (user == null) return const Scaffold(body: Center(child: Text("User not found")));

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _selectedImage != null
                        ? FileImage(File(_selectedImage!.path))
                        : (user.profileImage != null
                            ? NetworkImage('${ApiEndpoints.baseUrl}uploads/profiles/${user.profileImage}')
                            : null),
                    child: _selectedImage == null && user.profileImage == null
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
              const SizedBox(height: 32),
              CustomButton(
                text: 'Save Changes',
                isLoading: authState.isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(authControllerProvider.notifier).clearError();
                    
                    // 1. Update text info
                    await ref.read(authControllerProvider.notifier).updateProfile(
                      name: _nameController.text,
                      phone: _phoneController.text,
                    );
                    
                    // 2. Update image if selected
                    if (_selectedImage != null) {
                      final formData = FormData.fromMap({
                        'profileImage': await MultipartFile.fromFile(_selectedImage!.path),
                      });
                      await ref.read(authControllerProvider.notifier).uploadProfileImage(formData);
                    }

                    if (mounted) context.pop();
                  }
                },
              ),
              if (authState.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ErrorView(error: authState.error!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _selectedImage = image);
    }
  }
}