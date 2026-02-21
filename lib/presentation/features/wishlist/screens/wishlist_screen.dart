import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/auth_state_provider.dart';
import '../../../common_widgets/guest_prompt_view.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);

    if (user == null) {
      return const GuestPromptView(title: 'Wishlist', icon: Icons.favorite);
    }

    return const Center(child: Text('Wishlist Screen Content'));
  }
}
