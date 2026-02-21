import 'package:flutter/material.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/review.dart';
 

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: review.user?.profileImage != null
                      ? NetworkImage('${ApiEndpoints.baseUrl}/uploads/profiles/${review.user!.profileImage}')
                      : null,
                  child: review.user?.profileImage == null ? const Icon(Icons.person, size: 16) : null,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(review.user?.name ?? 'Anonymous')),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(5, (i) => Icon(
                    i < review.rating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.amber,
                  )),
                ),
              ],
            ),
            if (review.comment != null) ...[
              const SizedBox(height: 4),
              Text(review.comment!),
            ],
          ],
        ),
      ),
    );
  }
}