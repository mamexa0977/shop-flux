import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/review_api.dart';
import '../data/repositories/review_repository.dart';
import '../data/repositories_impl/review_repository_impl.dart';
import '../core/network/dio_client.dart';
import '../data/models/review.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final api = ReviewApi(dio);
  return ReviewRepositoryImpl(api);
});

final productReviewsProvider = FutureProvider.family<List<Review>, int>((ref, productId) async {
  final repo = ref.read(reviewRepositoryProvider);
  return repo.getProductReviews(productId);
});