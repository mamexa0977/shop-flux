import 'package:ecom_frontend/data/datasources/remote/auth_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories_impl/auth_repository_impl.dart';
import '../core/network/dio_client.dart';
import '../core/storage/secure_storage.dart';
import 'pending_auth_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final authApi = AuthApi(dio);
  return AuthRepositoryImpl(authApi, secureStorage);
});

final authStateProvider = StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  return AuthStateNotifier(ref.read(authRepositoryProvider), ref);
});

class AuthStateNotifier extends StateNotifier<User?> {
  final AuthRepository _repository;
  final Ref _ref;

  AuthStateNotifier(this._repository, this._ref) : super(null) {
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      final user = await _repository.getCurrentUser();
      state = user;
    } catch (e) {
      state = null;
    }
  }

  Future<void> login(String phone, String password) async {
    try {
      final user = await _repository.login(phone, password);
      state = user;
      // If phone is not verified, store credentials for auto-login after verification
      if (user.isPhoneVerified == false) {
        _ref.read(pendingAuthProvider.notifier).state = PendingAuth(phone: phone, password: password);
      }
    } catch (e) {
      // If login fails because phone not verified (custom exception), you could catch specific error
      // For now, we'll assume backend returns user with isPhoneVerified=false in successful response
      rethrow;
    }
  }

  Future<void> register(Map<String, dynamic> data, bool isSeller) async {
    if (isSeller) {
      await _repository.registerSeller(
        name: data['name'],
        phone: data['phone'],
        password: data['password'],
        businessName: data['businessName'],
        businessRegNumber: data['businessRegNumber'],
        businessAddress: data['businessAddress'],
        businessPhone: data['businessPhone'],
        bankName: data['bankName'],
        bankAccountName: data['bankAccountName'],
        bankAccountNumber: data['bankAccountNumber'],
        mobileMoneyProvider: data['mobileMoneyProvider'],
        mobileMoneyNumber: data['mobileMoneyNumber'],
      );
    } else {
      await _repository.register(
        name: data['name'],
        phone: data['phone'],
        password: data['password'],
      );
    }
    // After registration, store credentials for auto-login after verification
    _ref.read(pendingAuthProvider.notifier).state = PendingAuth(
      phone: data['phone'],
      password: data['password'],
    );
    // Do NOT set state – user is not logged in yet
  }

  Future<void> logout() async {
    await _repository.logout();
    state = null;
  }

  void setUser(User user) {
    state = user;
  }
}