import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onTextChanged);
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // to refresh clear button visibility
  }

  void _clearText() {
    _controller.clear();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine suffix icon(s)
    List<Widget> suffixIcons = [];

    // Clear button (X) – only show when field is not empty and enabled
    if (_controller.text.isNotEmpty && widget.enabled) {
      suffixIcons.add(
        IconButton(
          icon: const Icon(Icons.clear, size: 20),
          onPressed: _clearText,
          constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
          padding: EdgeInsets.zero,
          splashRadius: 20,
        ),
      );
    }

    // Visibility toggle for password fields
    if (widget.obscureText) {
      suffixIcons.add(
        IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggleVisibility,
          constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
          padding: EdgeInsets.zero,
          splashRadius: 20,
        ),
      );
    }

    return TextFormField(
      controller: _controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      decoration: InputDecoration(
        filled: true,
        // 2. Set the color to white
        fillColor: Colors.white,

        labelText: widget.label,
        hintText: widget.hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 185, 185, 185),
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon:
            suffixIcons.isNotEmpty
                ? Row(mainAxisSize: MainAxisSize.min, children: suffixIcons)
                : null,
        suffixIconConstraints: const BoxConstraints(
          minHeight: 30,
          minWidth: 30,
        ),
      ),
    );
  }
}
