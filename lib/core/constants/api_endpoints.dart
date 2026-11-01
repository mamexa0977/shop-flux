class ApiEndpoints {
  static const String baseUrl =
      'http://10.76.46.36:5000/api'; // for emulator, change for real device

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
  static const String productDetails = '/products'; // append id

  // Reviews
  static const String productReviews = '/reviews/product';

  // Cart
  static const String cart = '/cart';
  //wishlist
  static const String wishlist = '/wishlist';

  static const String addresses = '/users/addresses';

  static const String orders = '/orders';
  static const String calculateShipping = '/shipping/calculate';

  static const String search = '/search';

  static const String sellerDashboard = '/seller/dashboard';

  static const String sellerProducts = '/seller/products';
  static const String sellerVariants = '/seller/variants';

  static const String sellerOrders = '/seller/orders';
  static const String sellerOrderItems = '/seller/orders/items';
  static const String sellerReturns = '/seller/returns';
  static const String sellerInventory = '/seller/inventory';
  static const String sellerBulkStock = '/seller/inventory/bulk-update';
  // static const String sellerOrders = '/seller/orders';

  // Seller Wallet
  static const String sellerWallet = '/seller/wallet';
  static const String sellerWithdraw = '/seller/wallet/withdraw';
  static const String sellerWithdrawals = '/seller/wallet/withdrawals';

  // Seller Promotions
  static const String sellerDiscounts = '/seller/discounts';
  static const String sellerFlashSales = '/seller/flash-sales';
  static const String sellerFlashSaleSubmissions =
      '/seller/flash-sales/my/submissions';

  // Seller Settings
  static const String sellerStoreSettings = '/seller/settings/store';
  static const String sellerShippingSettings = '/seller/settings/shipping';
}
