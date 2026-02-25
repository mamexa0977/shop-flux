// import 'package:flutter/material.dart';
// import '../../../../core/constants/api_endpoints.dart';
// import '../../../../data/models/review.dart';

// class ReviewItem extends StatelessWidget {
//   final Review review;
//   const ReviewItem({super.key, required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundImage: review.user?.profileImage != null
//                       ? NetworkImage('${ApiEndpoints.baseUrl}/uploads/profiles/${review.user!.profileImage}')
//                       : null,
//                   child: review.user?.profileImage == null ? const Icon(Icons.person, size: 16) : null,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(child: Text(review.user?.name ?? 'Anonymous')),
//                 const SizedBox(width: 8),
//                 Row(
//                   children: List.generate(5, (i) => Icon(
//                     i < review.rating ? Icons.star : Icons.star_border,
//                     size: 16,
//                     color: Colors.amber,
//                   )),
//                 ),
//               ],
//             ),
//             if (review.comment != null) ...[
//               const SizedBox(height: 4),
//               Text(review.comment!),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/review.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                backgroundImage:
                    review.user?.profileImage != null
                        ? NetworkImage(
                          '${ApiEndpoints.baseUrl}/uploads/profiles/${review.user!.profileImage}',
                        )
                        : null,
                child:
                    review.user?.profileImage == null
                        ? Icon(Icons.person, color: Colors.grey.shade500)
                        : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user?.name ?? 'Anonymous',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < review.rating ? Icons.star : Icons.star_border,
                          size: 14,
                          color: Colors.amber,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              // Optional: Add a date here if your model supports it
              Text(
                review.createdAt != null
                    ? '${review.createdAt!.toLocal()}'.split(
                      ' ',
                    )[0] // Just show date
                    : 'Just now',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          ),
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.comment!,
              style: TextStyle(color: Colors.grey.shade800, height: 1.4),
            ),
          ],
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade200),
        ],
      ),
    );
  }
}
