import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../address/screen/address_list_screen.dart';


class AddressSelectionScreen extends ConsumerWidget {
  const AddressSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AddressListScreen(
      isSelectMode: true,
      onSelected: (address) {
        Navigator.pop(context, address);
      },
    );
  }
}