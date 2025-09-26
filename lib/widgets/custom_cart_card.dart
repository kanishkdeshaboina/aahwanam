import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomCartCard extends StatefulWidget  {
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const CustomCartCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });
  @override
  State<CustomCartCard> createState() => _CustomCartCardState();
}

class _CustomCartCardState extends State<CustomCartCard> {
  int quantity = 1; // Start from 1

  void _incrementQuantity() {
    setState(() {
      quantity += 1;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Image + Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imageUrl,
                  height: 93,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Texts and Quantity Row
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( widget.title,
                      style: TextFontStyle.textFontStyle(12, const Color(0xFF575959), FontWeight.w500),),
                    const SizedBox(height: 4),
                    Text( widget.description, style: TextFontStyle.textFontStyle(12, const Color(0xFF757575), FontWeight.w300),),
                    const SizedBox(height: 4),
                    Text('₹${ widget.price}',
                      style: TextFontStyle.textFontStyle(12, const Color(0xFF1E535B), FontWeight.w600),),
                  ],
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF1E535B), // 👈 background white
                  border: Border.all(color: const Color(0xFF1E535B)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _decrementQuantity,
                      child: const Icon(Icons.remove, size: 16, color: Colors.white,),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: _incrementQuantity,
                      child: const Icon(Icons.add, size: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bottom: Full-width Event Details button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                side: const BorderSide(color: Colors.black12),
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                widget.onTap?.call();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Event Details',
                    style: TextFontStyle.textFontStyle(12, Color(0xFF575959), FontWeight.w500),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
