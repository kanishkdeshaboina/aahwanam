import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  final List<String> reviewPhotoUrls; // e.g. babyPhotoshootImages
  final int totalRatings;
  final int totalReviews;
  final double averageRating;

  const ReviewsTab({
    Key? key,
    required this.reviewPhotoUrls,
    required this.totalRatings,
    required this.totalReviews,
    required this.averageRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ratings Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Star Breakdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(5, (index) {
                  final rating = 5 - index;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Text("$rating"),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Color(0xFFEFAA37), size: 16),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: LinearProgressIndicator(
                            value: rating * 0.2, // Placeholder value
                            minHeight: 3,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E535B)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text("${rating * 20}", style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                }),
              ),

              // Right Summary
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E535B),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Color(0xFF1E535B), width: 1),
                      ),
                      padding: const EdgeInsets.all(9),
                      minimumSize: const Size(0, 0),
                    ),
                    child: const Text("Rate Service", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 8),
                  const Text("Very Good", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                          (i) => Icon(
                        i < averageRating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: const Color(0xFFEFAA37),
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$totalRatings ratings and $totalReviews reviews",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Review Photos
          if (reviewPhotoUrls.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Photos",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF575959)),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: reviewPhotoUrls.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(image, width: 70, height: 70, fit: BoxFit.cover),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 24),

          // One review item (can be a ListView if needed)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFEFAA37), size: 16),
                  Icon(Icons.star, color: Color(0xFFEFAA37), size: 16),
                  Icon(Icons.star, color: Color(0xFFEFAA37), size: 16),
                  Icon(Icons.star, color: Color(0xFFEFAA37), size: 16),
                  Icon(Icons.star_border, color: Color(0xFFEFAA37), size: 16),
                  SizedBox(width: 8),
                  Text("24", style: TextStyle(color: Color(0xFF575959), fontSize: 14, fontWeight: FontWeight.w600)),
                  SizedBox(width: 8),
                  Text("Very good service", style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF757575)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
