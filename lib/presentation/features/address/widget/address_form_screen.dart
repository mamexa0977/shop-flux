// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../data/models/address.dart';
// import '../../../../providers/address_providers.dart';

// class AddressFormScreen extends ConsumerStatefulWidget {
//   final Address? address; // if provided, we are editing
//   const AddressFormScreen({super.key, this.address});

//   @override
//   ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
// }

// class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _line1Ctrl;
//   late final TextEditingController _line2Ctrl;
//   late final TextEditingController _cityCtrl;
//   late final TextEditingController _stateCtrl;
//   late final TextEditingController _postalCtrl;
//   late final TextEditingController _countryCtrl;
//   bool _isDefault = false;

//   @override
//   void initState() {
//     super.initState();
//     final a = widget.address;
//     _line1Ctrl = TextEditingController(text: a?.addressLine1 ?? '');
//     _line2Ctrl = TextEditingController(text: a?.addressLine2 ?? '');
//     _cityCtrl = TextEditingController(text: a?.city ?? '');
//     _stateCtrl = TextEditingController(text: a?.state ?? '');
//     _postalCtrl = TextEditingController(text: a?.postalCode ?? '');
//     _countryCtrl = TextEditingController(text: a?.country ?? '');
//     _isDefault = a?.isDefault ?? false;
//   }

//   @override
//   void dispose() {
//     _line1Ctrl.dispose();
//     _line2Ctrl.dispose();
//     _cityCtrl.dispose();
//     _stateCtrl.dispose();
//     _postalCtrl.dispose();
//     _countryCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;

//     final actionNotifier = ref.read(addressActionProvider.notifier);
//     final isEditing = widget.address != null;

//     final Future<void> mutation;
//     if (isEditing) {
//       mutation = actionNotifier.updateAddress(
//         id: widget.address!.id,
//         addressLine1: _line1Ctrl.text,
//         addressLine2: _line2Ctrl.text.isEmpty ? null : _line2Ctrl.text,
//         city: _cityCtrl.text,
//         state: _stateCtrl.text.isEmpty ? null : _stateCtrl.text,
//         postalCode: _postalCtrl.text,
//         country: _countryCtrl.text,
//         isDefault: _isDefault,
//       );
//     } else {
//       mutation = actionNotifier.addAddress(
//         addressLine1: _line1Ctrl.text,
//         addressLine2: _line2Ctrl.text.isEmpty ? null : _line2Ctrl.text,
//         city: _cityCtrl.text,
//         state: _stateCtrl.text.isEmpty ? null : _stateCtrl.text,
//         postalCode: _postalCtrl.text,
//         country: _countryCtrl.text,
//         isDefault: _isDefault,
//       );
//     }

//     // Show loading overlay or just wait; we'll listen to the action state
//     await mutation;
//     if (mounted) {
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Watch the action state to show loading indicator on button
//     final actionState = ref.watch(addressActionProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.address == null ? 'Add Address' : 'Edit Address'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _line1Ctrl,
//                 decoration: const InputDecoration(
//                   labelText: 'Address Line 1 *',
//                 ),
//                 validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _line2Ctrl,
//                 decoration: const InputDecoration(
//                   labelText: 'Address Line 2 (optional)',
//                 ),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: _cityCtrl,
//                 decoration: const InputDecoration(labelText: 'City *'),
//                 validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: _stateCtrl,
//                 decoration: const InputDecoration(
//                   labelText: 'State / Province (optional)',
//                 ),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: _postalCtrl,
//                 decoration: const InputDecoration(labelText: 'Postal Code *'),
//                 validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: _countryCtrl,
//                 decoration: const InputDecoration(labelText: 'Country *'),
//                 validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 8),
//               CheckboxListTile(
//                 title: const Text('Set as default address'),
//                 value: _isDefault,
//                 onChanged: (val) => setState(() => _isDefault = val ?? false),
//                 controlAffinity: ListTileControlAffinity.leading,
//                 contentPadding: EdgeInsets.zero,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: actionState.isLoading ? null : _submit,
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                   backgroundColor: const Color(
//                     0xFF015733,
//                   ), // same green as cart
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child:
//                     actionState.isLoading
//                         ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                         : const Text(
//                           'Save Address',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/address.dart';
import '../../../../providers/address_providers.dart';
// Import your countries file here
import '../../../../core/utils/countries.dart';

class AddressFormScreen extends ConsumerStatefulWidget {
  final Address? address;
  const AddressFormScreen({super.key, this.address});

  @override
  ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _line1Ctrl;
  late final TextEditingController _line2Ctrl;
  late final TextEditingController _cityCtrl;
  late final TextEditingController _stateCtrl;
  late final TextEditingController _postalCtrl;

  // 1. Replace controller with a String variable
  String? _selectedCountryCode;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _line1Ctrl = TextEditingController(text: a?.addressLine1 ?? '');
    _line2Ctrl = TextEditingController(text: a?.addressLine2 ?? '');
    _cityCtrl = TextEditingController(text: a?.city ?? '');
    _stateCtrl = TextEditingController(text: a?.state ?? '');
    _postalCtrl = TextEditingController(text: a?.postalCode ?? '');

    // 2. Initialize the country code from the address (if editing)
    _selectedCountryCode = a?.country;
    _isDefault = a?.isDefault ?? false;
  }

  @override
  void dispose() {
    _line1Ctrl.dispose();
    _line2Ctrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _postalCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final actionNotifier = ref.read(addressActionProvider.notifier);
    final isEditing = widget.address != null;

    final Future<void> mutation;
    if (isEditing) {
      mutation = actionNotifier.updateAddress(
        id: widget.address!.id,
        addressLine1: _line1Ctrl.text,
        addressLine2: _line2Ctrl.text.isEmpty ? null : _line2Ctrl.text,
        city: _cityCtrl.text,
        state: _stateCtrl.text.isEmpty ? null : _stateCtrl.text,
        postalCode: _postalCtrl.text,
        // 3. Use the variable instead of controller.text
        country: _selectedCountryCode!,
        isDefault: _isDefault,
      );
    } else {
      mutation = actionNotifier.addAddress(
        addressLine1: _line1Ctrl.text,
        addressLine2: _line2Ctrl.text.isEmpty ? null : _line2Ctrl.text,
        city: _cityCtrl.text,
        state: _stateCtrl.text.isEmpty ? null : _stateCtrl.text,
        postalCode: _postalCtrl.text,
        // 3. Use the variable instead of controller.text
        country: _selectedCountryCode!,
        isDefault: _isDefault,
      );
    }

    await mutation;
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(addressActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address == null ? 'Add Address' : 'Edit Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _line1Ctrl,
                decoration: const InputDecoration(
                  labelText: 'Address Line 1 *',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _line2Ctrl,
                decoration: const InputDecoration(
                  labelText: 'Address Line 2 (optional)',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cityCtrl,
                decoration: const InputDecoration(labelText: 'City *'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _stateCtrl,
                decoration: const InputDecoration(
                  labelText: 'State / Province (optional)',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _postalCtrl,
                decoration: const InputDecoration(labelText: 'Postal Code *'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),

              // 4. The Dropdown replacement
              DropdownButtonFormField<String>(
                value: _selectedCountryCode,
                items:
                    countries.map((country) {
                      return DropdownMenuItem(
                        value: country.code,
                        child: Text(country.name),
                      );
                    }).toList(),
                onChanged:
                    (value) => setState(() => _selectedCountryCode = value),
                decoration: const InputDecoration(
                  labelText: 'Country *',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value == null ? 'Please select a country' : null,
              ),

              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Set as default address'),
                value: _isDefault,
                onChanged: (val) => setState(() => _isDefault = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: actionState.isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF015733),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    actionState.isLoading
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text(
                          'Save Address',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
