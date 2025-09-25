import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';

class ReviewList extends StatelessWidget {
  final List<dynamic> reviews;
  final List<String> galleryImages;

  const ReviewList({super.key, required this.reviews, required this.galleryImages});

  Widget _buildRatingRow(int stars, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(stars.toString(), style: TextFontStyle.textFontStyle( 14, Colors.black87)),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 6),
          SizedBox(
            width: 68,
            child: LinearProgressIndicator(
              value: count / 100,
              color: Colors.teal,
              backgroundColor: Colors.grey.shade300,
              minHeight: 3,
            ),
          ),
          const SizedBox(width: 8),
          Text(count.toString(), style: TextFontStyle.textFontStyle( 14, Colors.black87)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Rating Summary Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT SIDE (takes available space)
                  Expanded(
                    flex: 2, // give more space for ratings
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rating & Reviews",
                          style: TextFontStyle.textFontStyle(
                            16,
                            const Color(0xFF575959),
                            FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _buildRatingRow(5, 80),
                        _buildRatingRow(4, 60),
                        _buildRatingRow(3, 30),
                        _buildRatingRow(2, 20),
                        _buildRatingRow(1, 10),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12), // spacing between columns

                  // RIGHT SIDE (summary box)
                  Expanded(
                    flex: 2, // give less space for summary
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              side: const BorderSide(color: Color(0xFF1E535B), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Rate Service",
                              style: TextFontStyle.textFontStyle(
                                14,
                                const Color(0xFF1E535B),
                                FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Very Good",
                            style: TextFontStyle.textFontStyle(
                              16,
                              const Color(0xFF575959),
                              FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              Icon(Icons.star_half, color: Colors.amber, size: 18),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "200 ratings and 160 reviews",
                            textAlign: TextAlign.center, // prevent overflow
                            style: TextFontStyle.textFontStyle(14, Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20),

            // ✅ Photo Gallery
            Text("Photos",  style: TextFontStyle.textFontStyle( 18, Color(0xFF575959),FontWeight.w500)
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: galleryImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(galleryImages[index],
                          width: 80, height: 80, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // So it scrolls with the parent
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star_half, color: Colors.amber, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            review['rating'].toString(),
                            style: TextFontStyle.textFontStyle( 18, Color(0xFF575959),FontWeight.w500),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            review['comment'],
                            style:
                            TextFontStyle.textFontStyle( 15, Color(0xFF575959),FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                          review['description'],
                          style:
                          TextFontStyle.textFontStyle( 13, Color(0xFF575959),FontWeight.w400)
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(review['image']),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            // ✅ Reviews Section
          ],
        ),
      ),
    );
  }
}