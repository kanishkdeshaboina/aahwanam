import 'package:aahwanam/screens/account/RateServiceScreen.dart';
import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/custom_text_field.dart';

class DetailedDeliveredmyPackagesScreen extends StatefulWidget {
  final Map<String, dynamic> package;

  const DetailedDeliveredmyPackagesScreen({
    super.key,
    required this.package,
  });

  @override
  State<DetailedDeliveredmyPackagesScreen> createState() =>
      _DetailedDeliveredmyPackagesScreenState();
}

class _DetailedDeliveredmyPackagesScreenState
    extends State<DetailedDeliveredmyPackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "My Packages",
          style: TextFontStyle.textFontStyle(
            ResponsiveUtils.getResponsiveFontSize(context, 16),
            const Color(0xFF575959),
            FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(
              left: ResponsiveUtils.getResponsiveWidth(context, 12)),
          icon: Icon(
            Icons.arrow_back_ios,
            size: ResponsiveUtils.getResponsiveFontSize(context, 18),
            color: const Color(0xFF575959),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              size: ResponsiveUtils.getResponsiveFontSize(context, 20),
            ),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getResponsiveWidth(context, 16)),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Birthday Party Package",
                style: TextFontStyle.textFontStyle(
                  ResponsiveUtils.getResponsiveFontSize(context, 14),
                  const Color(0xFF575959),
                  FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 20)),
            ..._buildPackageItems(),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 10)),

            // Bill Details Divider
            _buildSectionDivider("Bill Details"),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 10)),
            _buildBillRow(
              "Package Charges",
              "₹ 32,000",
              showInfo: true,
              infoDetails:
              "Total package price including all services selected. Taxes included.",
            ),
            _buildBillRow(
              "Platform Fee",
              "₹ 100",
              showInfo: true,
              infoDetails:
              "This fee covers platform usage, service handling, and support charges.",
            ),
            _buildBillRow(
              "Transport Fee",
              "FREE",
              showInfo: true,
              infoDetails:
              "Delivery and transport are free for this package.",
            ),
            _buildBillRow("Paid", "₹ 32,100", bold: true),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 20)),

            // Rate Service Divider
            _buildSectionDivider("Rate Service"),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 20)),
            _buildRatingRow(),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 30)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPackageItems() {
    final services = [
      {
        "title": "Decoration",
        "price": "₹ 8,000",
        "image": "assets/images/cartdecoration.png"
      },
      {
        "title": "Makeup",
        "price": "₹ 8,000",
        "image": "assets/images/cartdecoration2.png"
      },
      {
        "title": "Bartender",
        "price": "₹ 8,000",
        "image": "assets/images/cartbortender.png"
      },
      {
        "title": "Royal valet Service",
        "price": "₹ 8,000",
        "image": "assets/images/RoyalvaletService.png"
      },
    ];

    return services.map((service) {
      return Container(
        margin: EdgeInsets.only(
            bottom: ResponsiveUtils.getResponsiveHeight(context, 12)),
        padding: ResponsiveUtils.getResponsivePadding(context, all: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF2E4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                service["image"]!,
                width: ResponsiveUtils.getResponsiveWidth(context, 67),
                height: ResponsiveUtils.getResponsiveHeight(context, 52),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service["title"]!,
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 12),
                      const Color(0XFF575959),
                      FontWeight.w500,
                    ),
                  ),
                  Text(
                    service["price"]!,
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 12),
                      const Color(0XFF1E535B),
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Delivered on–23–03–25",
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 11),
                      const Color(0XFF757575),
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildBillRow(String label, String value,
      {bool showInfo = false, bool bold = false, String? infoDetails}) {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: ResponsiveUtils.getResponsiveHeight(context, 4)),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  label,
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 12),
                    const Color(0XFF575959),
                    bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (showInfo) ...[
                  SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 4)),
                  GestureDetector(
                    onTap: () => _showInfoBottomSheet(label, value, infoDetails),
                    child: Icon(
                      Icons.info_outline,
                      size: ResponsiveUtils.getResponsiveFontSize(context, 16),
                      color: const Color(0xFF575959),
                    ),
                  ),
                ]
              ],
            ),
          ),
          Text(
            value,
            style: TextFontStyle.textFontStyle(
              ResponsiveUtils.getResponsiveFontSize(context, 12),
              const Color(0XFF575959),
              bold ? FontWeight.bold : FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }

  void _showInfoBottomSheet(String label, String value, String? infoDetails) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "$label • $value",
                      style: TextFontStyle.textFontStyle(
                        ResponsiveUtils.getResponsiveFontSize(context, 14),
                        const Color(0xFF575959),
                        FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                infoDetails ?? "No details available",
                style: TextFontStyle.textFontStyle(
                  ResponsiveUtils.getResponsiveFontSize(context, 12),
                  const Color(0xFF575959),
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRatingRow() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RateServiceScreen()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
              (index) => Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getResponsiveWidth(context, 16)),
            child: Icon(
              index < 4 ? Icons.star : Icons.star_border,
              color: Colors.orange,
              size: ResponsiveUtils.getResponsiveFontSize(context, 28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionDivider(String title) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 8)),
        Text(
          title,
          style: TextFontStyle.textFontStyle(
            ResponsiveUtils.getResponsiveFontSize(context, 14),
            const Color(0XFF575959),
            FontWeight.w500,
          ),
        ),
        SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 8)),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
