import 'package:flutter/material.dart';

class CheckoutStep extends StatelessWidget {
  final int number;
  final String title;
  final bool isComplete;
  final Widget child;

  const CheckoutStep({
    super.key,
    required this.number,
    required this.title,
    required this.isComplete,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isComplete ? Colors.green : Colors.grey.shade300,
                  ),
                  child: Center(
                    child: isComplete
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : Text(
                            '$number',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}