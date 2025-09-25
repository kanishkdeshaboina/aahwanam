import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

/// 🛒 Cart Image Widget
class CartImage extends StatelessWidget {
  final String imagePath;
  const CartImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.asset(
        imagePath,
        height: 144,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}

/// 📅 Booking Image Widget
class BookingImage extends StatelessWidget {

  final String imagePath;
  const BookingImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.asset(
        imagePath,
        height: 110,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}

/// ❤️ Wishlist Image Widget
class WishlistImage extends StatelessWidget {
  final String imagePath;
  const WishlistImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.asset(
        imagePath,
        height: 125,
        width: 85,
        fit: BoxFit.cover,
      ),
    );
  }
}

/// Enum to select which image widget to use
enum PackageImageType { cart, booking, wishlist }

class PackageCard extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String? details;
  final String imagePath;
  final double? rating;
  final bool showLikeIcon;

  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final bool isWishlist;
  final VoidCallback? onTap;

  final PackageImageType imageType;

  // NEW: Button size properties
  final double? primaryButtonWidth;
  final double? primaryButtonHeight;
  final double? secondaryButtonWidth;
  final double? secondaryButtonHeight;
  final double? scalingFactor;

  const PackageCard({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    this.details,
    required this.imagePath,
    this.rating,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.isWishlist = false,
    this.showLikeIcon = false,
    this.onTap,
    this.imageType = PackageImageType.cart,
    this.primaryButtonWidth,
    this.primaryButtonHeight,
    this.secondaryButtonWidth,
    this.secondaryButtonHeight,
    this.scalingFactor = 1.0, // Default scaling factor
  }) : super(key: key);

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool isLiked = true;

  double _getScaledValue(double value) {
    return value * (widget.scalingFactor ?? 1.0);
  }

  Widget _buildImage() {
    final scaledHeight = _getScaledValue(
        widget.imageType == PackageImageType.booking ? 110 : 125
    );
    final scaledWidth = _getScaledValue(
        widget.imageType == PackageImageType.wishlist ? 85 : 80
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(_getScaledValue(6)),
      child: Image.asset(
        widget.imagePath,
        height: scaledHeight,
        width: scaledWidth,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('hii');
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(_getScaledValue(6)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getScaledValue(6)),
        ),
        elevation: 0,
        color: const Color(0xFFFFEFDF),
        child: Padding(
          padding: EdgeInsets.all(_getScaledValue(12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image + like icon
              Stack(
                children: [
                  _buildImage(),
                  if (widget.showLikeIcon)
                    Positioned(
                      top: _getScaledValue(4),
                      right: _getScaledValue(4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(_getScaledValue(2)),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            size: _getScaledValue(16),
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(width: _getScaledValue(12)),

              // Text + Buttons Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextFontStyle.textFontStyle(
                                _getScaledValue(14),
                                const Color(0xFF575959),
                                FontWeight.w500
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        if (widget.rating != null)
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: _getScaledValue(16),
                                color: const Color(0xFFEFAA37),
                              ),
                              SizedBox(width: _getScaledValue(4)),
                              Text(
                                widget.rating.toString(),
                                style: TextFontStyle.textFontStyle(
                                    _getScaledValue(12),
                                    const Color(0xFF575959),
                                    FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: _getScaledValue(6)),

                    // Description
                    Text(
                      widget.description,
                      style: TextFontStyle.textFontStyle(
                          _getScaledValue(13),
                          const Color(0xFF757575),
                          FontWeight.w400
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: _getScaledValue(4)),

                    // Price
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          size: _getScaledValue(14),
                          color: const Color(0xFF1E535B),
                        ),
                        Text(
                          widget.price,
                          style: TextFontStyle.textFontStyle(
                              _getScaledValue(12),
                              const Color(0xFF1E535B),
                              FontWeight.w600
                          ),
                        ),
                      ],
                    ),

                    if (widget.details != null) ...[
                      SizedBox(height: _getScaledValue(6)),
                      Text(
                        widget.details!,
                        style: TextFontStyle.textFontStyle(
                            _getScaledValue(13),
                            const Color(0xFF575959),
                            FontWeight.w600
                        ),
                      ),
                    ],

                    // Buttons
                    if (widget.primaryButtonText != null ||
                        widget.secondaryButtonText != null) ...[
                      SizedBox(height: _getScaledValue(12)),
                      Row(
                        children: [
                          if (widget.secondaryButtonText != null)
                            SizedBox(
                              width: widget.secondaryButtonWidth ?? _getScaledValue(120),
                              height: widget.secondaryButtonHeight ?? _getScaledValue(29),
                              child: OutlinedButton(
                                onPressed: widget.onSecondaryButtonPressed,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFDFC),
                                  side: const BorderSide(
                                    color: Color(0xFF1E535B),
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(_getScaledValue(9)),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  widget.secondaryButtonText!,
                                  style: TextFontStyle.textFontStyle(
                                      _getScaledValue(12),
                                      const Color(0xFF1E535B),
                                      FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          if (widget.secondaryButtonText != null &&
                              widget.primaryButtonText != null)
                            SizedBox(width: _getScaledValue(8)),
                          if (widget.primaryButtonText != null)
                            SizedBox(
                              width: widget.primaryButtonWidth ?? _getScaledValue(90),
                              height: widget.primaryButtonHeight ?? _getScaledValue(29),
                              child: ElevatedButton(
                                onPressed: widget.onPrimaryButtonPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E535B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(_getScaledValue(9)),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  widget.primaryButtonText ?? "",
                                  style: TextFontStyle.textFontStyle(
                                      _getScaledValue(12),
                                      Colors.white,
                                      FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}