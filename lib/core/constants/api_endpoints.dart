class ApiEndpoints {
  static const String baseUrl =
      'http://192.168.8.158:5000/api'; // for emulator, change for real device

  // Auth
  static const String register = '/auth/register';
  static const String registerSeller = '/auth/register-seller';
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String me = '/auth/me';

  static String getProfileImageUrl(String? fileName) {
    if (fileName == null) return '';
    // Remove '/api' from baseUrl and append the upload path
    final base = baseUrl.replaceFirst('/api', '');
    return '$base/uploads/profiles/$fileName';
  }
  // User
  static const String profile = '/users/profile';
  static const String changePassword = '/users/change-password';
  static const String profileImage = '/users/profile-image';

  // Products
   static const String products = '/products';
  static const String featuredProducts = '/products/featured';
  static const String newArrivals = '/products/new-arrivals';
  static const String bestSellers = '/products/best-sellers';
  static const String categories = '/products/categories';
  static const String productsByCategory = '/products/category'; // append slug
  static const String productDetails = '/products';              // append id

  // Reviews
  static const String productReviews = '/reviews/product';  

  // Cart
  static const String cart = '/cart'; 
  //wishlist
  static const String wishlist = '/wishlist';
}
