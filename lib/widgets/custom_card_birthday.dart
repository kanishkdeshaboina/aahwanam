import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../services/decoration/decoration_theme.dart';

class CustomCardBirthdayWidgets {
  static Widget buildSection(
      BuildContext context, {
        required String title,
        required List<Map<String, String>> data,
        required VoidCallback onViewAll,
        required bool showViewAll,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive font sizes
    final titleFontSize = screenWidth < 350
        ? 12.0
        : screenWidth < 400
        ? 15.0
        : 16.0;
    final viewAllFontSize = screenWidth < 350
        ? 10.0
        : screenWidth < 400
        ? 11.0
        : 12.0;

    // Adjust childAspectRatio for very small screens to avoid overflow
    final childAspectRatio = screenWidth < 350 ? 0.65 : 0.92;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextFontStyle.textFontStyle(
                    18,
                    const Color(0xFF575959),
                    FontWeight.w600,
                  ),

                ),
                if (showViewAll)
                  TextButton(
                    onPressed: onViewAll,
                    child: Text(
                      "View All",
                      style: TextFontStyle.textFontStyle(
                        12,
                        const Color(0xFF1E535B),
                        FontWeight.w600,
                      ),

                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth > 600 ? 3 : 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: data.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = data[index];
              return buildCard(context, item, screenWidth);
            },
          ),
        ],
      ),
    );
  }

  static Widget buildCard(
      BuildContext context, Map<String, String> item, double screenWidth) {
    // Small-device adjustments
    final imageHeight = screenWidth < 350 ? 90.0 : 120.0;
    final nameFontSize = screenWidth < 350
        ? 10.0
        : screenWidth < 400
        ? 12.0
        : 12.0;
    final priceFontSize = screenWidth < 350
        ? 10.0
        : screenWidth < 400
        ? 12.0
        : 10.0;
    final ratingFontSize = screenWidth < 350
        ? 8.0
        : screenWidth < 400
        ? 8.0
        : 10.0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DecorationTheme(decorator: item),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: const Color(0xFFFFEFDF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(6.0),
              ),
              child: item['image']!.startsWith('assets/')
                  ? Image.asset(
                item['image']!,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.network(
                item['image']!,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Text Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          item['name'] ?? '',
                          style: TextFontStyle.textFontStyle(
                            nameFontSize,
                            const Color(0xFF575959),
                            FontWeight.w500,
                          ),

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xFFEFAA37), size: 14),
                          const SizedBox(width: 2),
                          Text(
                            item['rating'] ?? "0.0",
                            style: TextFontStyle.textFontStyle(
                              ratingFontSize,
                              const Color(0xFF575959),
                              FontWeight.w400,
                            ),

                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    item['price'] ?? '',
                    style: TextFontStyle.textFontStyle(
                      priceFontSize,
                      const Color(0xFF1E535B),
                      FontWeight.w600,
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
