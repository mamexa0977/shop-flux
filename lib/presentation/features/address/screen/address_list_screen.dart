// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../data/models/address.dart';
// import '../../../../providers/auth_state_provider.dart';
// import '../../../common_widgets/guest_prompt_view.dart';
// import '../../../../providers/address_providers.dart';
// import '../widget/address_form_screen.dart';

// class AddressListScreen extends ConsumerWidget {
//   final bool isSelectMode;
//   final Function(Address)? onSelected;
//   const AddressListScreen({super.key, this.isSelectMode = false, this.onSelected});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(authStateProvider);
//     if (user == null) {
//       return const Scaffold(
//         body: GuestPromptView(title: 'Addresses', icon: Icons.location_on),
//       );
//     }

//     final addressesAsync = ref.watch(addressesProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Addresses'),
//         actions: [
//           if (!isSelectMode)
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const AddressFormScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: addressesAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, stack) => Center(child: Text('Error: $err')),
//         data: (addresses) {
//           if (addresses.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.location_off, size: 80, color: Colors.grey),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'No addresses saved yet',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const AddressFormScreen()),
//                       );
//                     },
//                     child: const Text('Add New Address'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: addresses.length,
//             itemBuilder: (context, index) {
//               final address = addresses[index];
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               '${address.addressLine1}${address.addressLine2 != null ? ', ${address.addressLine2}' : ''}',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           if (address.isDefault)
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.green.shade50,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(color: Colors.green.shade200),
//                               ),
//                               child: Text(
//                                 'DEFAULT',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.green.shade800,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '${address.city}, ${address.state ?? ''} ${address.postalCode}',
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                       Text(address.country),
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           if (!address.isDefault)
//                             TextButton.icon(
//                               onPressed: () async {
//                                 await ref.read(addressActionProvider.notifier).setDefaultAddress(address.id);
//                               },
//                               icon: const Icon(Icons.star_border, size: 18),
//                               label: const Text('Set as default'),
//                             ),
//                           IconButton(
//                             icon: const Icon(Icons.edit, size: 20),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => AddressFormScreen(address: address),
//                                 ),
//                               );
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete, size: 20, color: Colors.red),
//                             onPressed: () async {
//                               final confirm = await showDialog<bool>(
//                                 context: context,
//                                 builder: (ctx) => AlertDialog(
//                                   title: const Text('Delete Address'),
//                                   content: const Text('Are you sure you want to delete this address?'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(ctx, false),
//                                       child: const Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(ctx, true),
//                                       style: TextButton.styleFrom(foregroundColor: Colors.red),
//                                       child: const Text('Delete'),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                               if (confirm == true) {
//                                 await ref.read(addressActionProvider.notifier).deleteAddress(address.id);
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/countries.dart';
import '../../../../data/models/address.dart';
import '../../../../providers/auth_state_provider.dart';
import '../../../common_widgets/guest_prompt_view.dart';
import '../../../../providers/address_providers.dart';
import '../widget/address_form_screen.dart';

class AddressListScreen extends ConsumerWidget {
  final bool isSelectMode;
  final Function(Address)? onSelected;

  const AddressListScreen({
    super.key,
    this.isSelectMode = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    if (user == null) {
      return const Scaffold(
        body: GuestPromptView(title: 'Addresses', icon: Icons.location_on),
      );
    }

    final addressesAsync = ref.watch(addressesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
        actions: [
          if (!isSelectMode)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddressFormScreen()),
                );
              },
            ),
        ],
      ),
      body: addressesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (addresses) {
          if (addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No addresses saved yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddressFormScreen()),
                      );
                    },
                    child: const Text('Add New Address'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return _buildAddressCard(context, ref, address);
            },
          );
        },
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, WidgetRef ref, Address address) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: isSelectMode ? () => onSelected?.call(address) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${address.addressLine1}${address.addressLine2 != null ? ', ${address.addressLine2}' : ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (address.isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Text(
                        'DEFAULT',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${address.city}, ${address.state ?? ''} ${address.postalCode}',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(getCountryName(address.country)),
              const SizedBox(height: 12),
              if (!isSelectMode) _buildActionButtons(context, ref, address),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, Address address) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!address.isDefault)
          TextButton.icon(
            onPressed: () async {
              await ref.read(addressActionProvider.notifier).setDefaultAddress(address.id);
            },
            icon: const Icon(Icons.star_border, size: 18),
            label: const Text('Set as default'),
          ),
        IconButton(
          icon: const Icon(Icons.edit, size: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddressFormScreen(address: address),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Delete Address'),
                content: const Text('Are you sure you want to delete this address?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              await ref.read(addressActionProvider.notifier).deleteAddress(address.id);
            }
          },
        ),
      ],
    );
  }
}