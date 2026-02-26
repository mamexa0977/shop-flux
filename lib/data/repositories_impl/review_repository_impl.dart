import '../models/review.dart';
import '../datasources/remote/review_api.dart';
import '../repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewApi _api;

  ReviewRepositoryImpl(this._api);

  @override
  Future<List<Review>> getProductReviews(int productId) async {
    await Future.delayed(const Duration(seconds: 5));

    final response = await _api.getProductReviews(productId);
    final data = response['data'];
    if (data is Map && data.containsKey('reviews')) {
      return (data['reviews'] as List).map((e) => Review.fromJson(e)).toList();
    }
    return [];
  }
}