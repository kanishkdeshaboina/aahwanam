import 'package:flutter/material.dart';
import 'package:aahwanam/widgets/custom_text_field.dart';
import '../../widgets/custom_buildDecor_horizontalList.dart';

class ThemesScreen extends StatelessWidget {
  final List<Map<String, String>> birthdayItems;

  const ThemesScreen({super.key, required this.birthdayItems});

  List<List<Map<String, String>>> splitList(List<Map<String, String>> list, int chunkSize) {
    List<List<Map<String, String>>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize),
      );
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Title
          Padding(
            padding: EdgeInsets.only(left: 29, top: 0, bottom: 10),
            child: Text(
              "Birthday Decoration",
              style: TextFontStyle.textFontStyle(
                12,
                const Color(0xFF575959),
                FontWeight.w600,
              ),

            ),
          ),

          // First Horizontal List
          ...splitList(birthdayItems, 4)
              .map(
                (chunk) => Padding(
              padding: const EdgeInsets.only(top: 0), // No extra gap
              child: CustomBuildDecorHorizontalList.build(title: "", items: chunk),
            ),
          )
              .toList(),

          // Second Title
          Padding(
            padding: EdgeInsets.only(left: 29, top: 5, bottom: 10), // Reduced gap
            child: Text(
              "Birthday Decoration for Kids",
              style: TextFontStyle.textFontStyle(
                12,
                const Color(0xFF575959),
                FontWeight.w600,
              ),

            ),
          ),

          // Second Horizontal List
          ...splitList(birthdayItems, 4)
              .map(
                (chunk) => Padding(
              padding: const EdgeInsets.only(top: 0), // No extra gap
              child: CustomBuildDecorHorizontalList.build(title: "", items: chunk),
            ),
          )
              .toList(),
        ],
      ),
    );
  }
}
