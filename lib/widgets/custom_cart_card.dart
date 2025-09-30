import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

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
      margin: ResponsiveUtils.getResponsivePadding(
        context,
        horizontal: 8,
        vertical: 3,
      ),
      padding: ResponsiveUtils.getResponsivePadding(context, all: 12),
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
                  height: ResponsiveUtils.getResponsiveHeight(context, 93),
                  width: ResponsiveUtils.getResponsiveWidth(context, 75),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 12)),

              // Texts and Quantity Row
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextFontStyle.textFontStyle(
                          ResponsiveUtils.getResponsiveFontSize(context, 12),
                          const Color(0xFF575959),
                          FontWeight.w500
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 4)),
                    Text(
                      widget.description,
                      style: TextFontStyle.textFontStyle(
                          ResponsiveUtils.getResponsiveFontSize(context, 12),
                          const Color(0xFF757575),
                          FontWeight.w300
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 4)),
                    Text(
                      '₹${widget.price}',
                      style: TextFontStyle.textFontStyle(
                          ResponsiveUtils.getResponsiveFontSize(context, 12),
                          const Color(0xFF1E535B),
                          FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: ResponsiveUtils.getResponsivePadding(
                  context,
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E535B),
                  border: Border.all(color: const Color(0xFF1E535B)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _decrementQuantity,
                      child: Icon(
                          Icons.remove,
                          size: ResponsiveUtils.getResponsiveFontSize(context, 16),
                          color: Colors.white
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 4)),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 4)),
                    GestureDetector(
                      onTap: _incrementQuantity,
                      child: Icon(
                          Icons.add,
                          size: ResponsiveUtils.getResponsiveFontSize(context, 16),
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 12)),

          // Bottom: Full-width Event Details button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                side: const BorderSide(color: Colors.black12),
                padding: ResponsiveUtils.getResponsivePadding(
                  context,
                  vertical: 10,
                  horizontal: 16,
                ),
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
                  Text(
                    'Event Details',
                    style: TextFontStyle.textFontStyle(
                        ResponsiveUtils.getResponsiveFontSize(context, 12),
                        const Color(0xFF575959),
                        FontWeight.w500
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: ResponsiveUtils.getResponsiveFontSize(context, 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}