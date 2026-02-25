import 'package:flutter/material.dart';

class RoleSwitch extends StatelessWidget {
  final bool isSeller;
  final ValueChanged<bool> onChanged;

  const RoleSwitch({
    super.key,
    required this.isSeller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildChoice('Buyer', !isSeller, () => onChanged(false)),
          _buildChoice('Seller', isSeller, () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _buildChoice(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Color(0xFFFD730D) : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Color(0xFFFD730D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
