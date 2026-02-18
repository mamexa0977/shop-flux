import 'package:dio/dio.dart';
import '../models/user.dart';

abstract class AuthRepository {
  Future<User> register({required String name, required String phone, required String password});
  Future<User> registerSeller({
    required String name,
    required String phone,
    required String password,
    required String businessName,
    String? businessRegNumber,
    String? businessAddress,
    String? businessPhone,
    String? bankName,
    String? bankAccountName,
    String? bankAccountNumber,
    String? mobileMoneyProvider,
    String? mobileMoneyNumber,
  });
  Future<User> login(String phone, String password);
  Future<void> forgotPassword(String phone);
  Future<void> resetPassword({required String phone, required String otp, required String newPassword});
  Future<void> verifyOtp({required String phone, required String otp});
  Future<User> getCurrentUser();
  Future<User> updateProfile({String? name, String? phone});
  Future<void> changePassword({required String currentPassword, required String newPassword});
  Future<String> uploadProfileImage(FormData formData);
  Future<void> logout();
}