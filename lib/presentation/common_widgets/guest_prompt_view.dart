// lib/presentation/common_widgets/guest_prompt_view.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_button.dart';

class GuestPromptView extends StatelessWidget {
  final String title;
  final IconData icon;

  const GuestPromptView({
    super.key, 
    required this.title, 
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Login to view your $title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You need an account to access this feature.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Go to Login',
              onPressed: () => context.push('/login'),
            ),
          ],
        ),
      ),
    );
  }
}