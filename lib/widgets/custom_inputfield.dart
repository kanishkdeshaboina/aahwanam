import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;

  const CustomInputField({
    required this.controller,
    required this.labelText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    print('hii');
    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextFontStyle.textFontStyle(
              labelText == 'Nakshatra Name*' || labelText == 'Birth Place*'  ? 11 :12,                      // font size
              Color(0xFF575959),       // color
              FontWeight.w500,         // weigh// optional if you're not using GoogleFonts
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 50,
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE4E4E4),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE4E4E4),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
