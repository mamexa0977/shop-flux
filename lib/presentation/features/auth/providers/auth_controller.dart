import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../providers/auth_state_provider.dart';

// 1. The State Class
class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({this.isLoading = false, this.error});
}

// 2. The Provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    ref.read(authRepositoryProvider),
    ref.read(authStateProvider.notifier),
  );
});

// 3. The Controller
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final AuthStateNotifier _globalAuthNotifier;

  AuthController(this._repository, this._globalAuthNotifier) : super(AuthState());

  // --- Login ---
  Future<bool> login(String phone, String password) async {
    state = AuthState(isLoading: true);
    try {
      await _globalAuthNotifier.login(phone, password);
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    }
  }

  // --- Register ---
Future<bool> register(Map<String, dynamic> data, bool isSeller) async {
  state = AuthState(isLoading: true);
  try {
    await _globalAuthNotifier.register(data, isSeller);
    state = AuthState(isLoading: false);
    return true;
  } catch (e) {
    // If the error mentions SMS failure, still consider registration successful
    // because the user was created in the backend.
    // final errorMsg = e.toString().toLowerCase();

    state = AuthState(isLoading: false, error: e.toString());
    return false;
  }
}

  // --- Verify OTP ---
  Future<bool> verifyOtp(String phone, String otp) async {
    state = AuthState(isLoading: true);
    try {
      await _repository.verifyOtp(phone: phone, otp: otp);
      // If verify is for login, we might need to refresh user, 
      // but usually the next step handles it.
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    }
  }

  // --- Forgot Password ---
  Future<bool> forgotPassword(String phone) async {
    state = AuthState(isLoading: true);
    try {
      await _repository.forgotPassword(phone);
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    }
  }

  // --- Reset Password ---
  Future<bool> resetPassword(String phone, String otp, String newPassword) async {
    state = AuthState(isLoading: true);
    try {
      await _repository.resetPassword(phone: phone, otp: otp, newPassword: newPassword);
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    }
  }

  // --- Change Password ---
  Future<bool> changePassword(String currentPassword, String newPassword) async {
    state = AuthState(isLoading: true);
    try {
      await _repository.changePassword(currentPassword: currentPassword, newPassword: newPassword);
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    }
  }

  // --- Update Profile ---
  Future<bool> updateProfile({String? name, String? phone}) async {
    state = AuthState(isLoading: true);
    try {
      final updatedUser = await _repository.updateProfile(name: name, phone: phone);
      _globalAuthNotifier.setUser(updatedUser); // Update global state
      state = AuthState(isLoading: false);
      return true;
    } catch (e) {
      state = AuthState(isLoading: false, error: e.toString());
      return false;
    }
  }

  // --- Upload Image ---
Future<bool> uploadProfileImage(FormData formData) async {
  state = AuthState(isLoading: true);
  try {
    await _repository.uploadProfileImage(formData);
    // Do NOT reload user – we want to stay on register screen without triggering redirects
    state = AuthState(isLoading: false);
    return true;
  } catch (e) {
    state = AuthState(isLoading: false, error: e.toString());
    return false;
  }
}

  void clearError() {
    if (state.error != null) {
      state = AuthState(isLoading: state.isLoading, error: null);
    }
  }
}