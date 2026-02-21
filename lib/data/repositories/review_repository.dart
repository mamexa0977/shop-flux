import '../models/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getProductReviews(int productId);
}