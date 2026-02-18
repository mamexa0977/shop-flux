import 'package:dio/dio.dart';
import '../../core/storage/secure_storage.dart';
import '../datasources/remote/auth_api.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._authApi, this._secureStorage);

  @override
  Future<User> register({required String name, required String phone, required String password}) async {
    final response = await _authApi.register({
      'name': name,
      'phone': phone,
      'password': password,
    });
    // No token saved – phone verification required
    await _saveToken(response['token']); 
    return User.fromJson(response['data']['user']);
  }

  @override
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
  }) async {
    final response = await _authApi.registerSeller({
      'name': name,
      'phone': phone,
      'password': password,
      'businessName': businessName,
      'businessRegNumber': businessRegNumber,
      'businessAddress': businessAddress,
      'businessPhone': businessPhone,
      'bankName': bankName,
      'bankAccountName': bankAccountName,
      'bankAccountNumber': bankAccountNumber,
      'mobileMoneyProvider': mobileMoneyProvider,
      'mobileMoneyNumber': mobileMoneyNumber,
    }); 
    await _saveToken(response['token']); 
    return User.fromJson(response['data']['user']);
  }

  @override
  Future<User> login(String phone, String password) async {
    final response = await _authApi.login(phone, password);
    await _saveToken(response['token']);
    return User.fromJson(response['data']['user']);
  }

  @override
  Future<void> forgotPassword(String phone) async {
    await _authApi.forgotPassword(phone);
  }

  @override
  Future<void> resetPassword({required String phone, required String otp, required String newPassword}) async {
    await _authApi.resetPassword(phone: phone, otp: otp, newPassword: newPassword);
  }

  @override
  Future<void> verifyOtp({required String phone, required String otp}) async {
    await _authApi.verifyOtp(phone: phone, otp: otp);
  }

  @override
  Future<User> getCurrentUser() async {
    final response = await _authApi.getMe();
    return User.fromJson(response['data']['user']);
  }

  @override
  Future<User> updateProfile({String? name, String? phone}) async {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    final response = await _authApi.updateProfile(data);
    return User.fromJson(response['data']['user']);
  }

  @override
  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    await _authApi.changePassword(currentPassword: currentPassword, newPassword: newPassword);
  }

  @override
  Future<String> uploadProfileImage(FormData formData) async {
    final response = await _authApi.uploadProfileImage(formData);
        print(
      'Upload Response#✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅#####################: ${response}',
    );
    return response['data']['profileImage'];
  }

  @override
  Future<void> logout() async {
    await _secureStorage.deleteAll();
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.write(StorageKeys.token, token);
  }
}