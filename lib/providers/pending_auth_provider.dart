import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingAuth {
  final String phone;
  final String password;
  PendingAuth({required this.phone, required this.password});
}

final pendingAuthProvider = StateProvider<PendingAuth?>((ref) => null);