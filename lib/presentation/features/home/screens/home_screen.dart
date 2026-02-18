 
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Screen Content')); 
    // NO BottomNavBar wrapper here! The ShellRoute handles it.
  }

}