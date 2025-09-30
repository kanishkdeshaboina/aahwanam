import 'package:aahwanam/services/proceedpay.dart';
import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';

class DetailedPackageCartScreen extends StatefulWidget {
  const DetailedPackageCartScreen({super.key});

  @override
  State<DetailedPackageCartScreen> createState() =>
      _DetailedPackageCartScreenState();
}

class _DetailedPackageCartScreenState extends State<DetailedPackageCartScreen> {
  final List<Map<String, dynamic>> services = [
    {
      "title": "Decoration",
      "price": "₹ 8,000",
      "image": "assets/images/cartdecoration.png",
      "quantity": 1
    },
    {
      "title": "Decoration",
      "price": "₹ 8,000",
      "image": "assets/images/cartdecoration2.png",
      "quantity": 1
    },
    {
      "title": "Bartender",
      "price": "₹ 8,000",
      "image": "assets/images/cartbortender.png",
      "quantity": 1
    },
    {
      "title": "Royal valet Service",
      "price": "₹ 8,000",
      "image": "assets/images/RoyalvaletService.png",
      "quantity": 1
    },
  ];

  int platformFee = 100;

  int get total {
    int serviceTotal =
    services.fold<int>(0, (int sum, Map<String, dynamic> item) {
      int price = int.parse(item["price"].replaceAll(RegExp(r'[^0-9]'), ''));
      int quantity = item["quantity"] as int;
      return sum + (price * quantity);
    });
    return serviceTotal + platformFee;
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQty = (services[index]["quantity"] as int) + delta;
      if (newQty >= 1) {
        services[index]["quantity"] = newQty;
      }
    });
  }

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
            top: ResponsiveUtils.getResponsiveHeight(context, 2),
            left: ResponsiveUtils.getResponsiveWidth(context, 12),
          ),
          icon: Icon(
            Icons.arrow_back_ios,
            size: ResponsiveUtils.getResponsiveFontSize(context, 18),
            color: const Color(0xFF575959),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              size: ResponsiveUtils.getResponsiveFontSize(context, 20),
            ),
            onPressed: () {
              // Implement share functionality if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 8)),
          Text(
            "Birthday Party Package",
            style: TextFontStyle.textFontStyle(
                ResponsiveUtils.getResponsiveFontSize(context, 14),
                const Color(0XFF575959),
                FontWeight.w500
            ),
          ),
          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 8)),

          /// ✅ Services List + Bill Details in one scrollable widget
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getResponsiveWidth(context, 16)
              ),
              children: [
                ...services.asMap().entries.map((entry) {
                  int index = entry.key;
                  final service = entry.value;
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: ResponsiveUtils.getResponsiveHeight(context, 8)
                    ),
                    padding: ResponsiveUtils.getResponsivePadding(context, all: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            service["image"],
                            width: ResponsiveUtils.getResponsiveWidth(context, 67),
                            height: ResponsiveUtils.getResponsiveHeight(context, 46),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 12)),

                        /// Title + Price Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service["title"],
                                style: TextFontStyle.textFontStyle(
                                    ResponsiveUtils.getResponsiveFontSize(context, 12),
                                    const Color(0XFF575959),
                                    FontWeight.w500
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 2)),
                              Text(
                                service["price"],
                                style: TextFontStyle.textFontStyle(
                                    ResponsiveUtils.getResponsiveFontSize(context, 12),
                                    const Color(0xFF1E535B),
                                    FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Quantity Selector
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.getResponsiveWidth(context, 8),
                            vertical: ResponsiveUtils.getResponsiveHeight(context, 4),
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
                                onTap: () => _updateQuantity(index, -1),
                                child: Icon(
                                  Icons.remove,
                                  size: ResponsiveUtils.getResponsiveFontSize(context, 16),
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 4)),
                              Text(
                                (service["quantity"] as int).toString(),
                                style: TextFontStyle.textFontStyle(
                                    ResponsiveUtils.getResponsiveFontSize(context, 12),
                                    Colors.white,
                                    FontWeight.w500
                                ),
                              ),
                              SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 4)),
                              GestureDetector(
                                onTap: () => _updateQuantity(index, 1),
                                child: Icon(
                                  Icons.add,
                                  size: ResponsiveUtils.getResponsiveFontSize(context, 16),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 16)),

                /// ✅ Bill Details immediately after services
                Row(children:  [
                  Expanded(child: Divider(thickness: 1)),
                  SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 6)),
                  Text(
                    "Bill Details",
                    style: TextFontStyle.textFontStyle(
                        ResponsiveUtils.getResponsiveFontSize(context, 14),
                        const Color(0xFF575959),
                        FontWeight.w500
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 6)),
                  Expanded(child: Divider(thickness: 1)),
                ]),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 6)),
                _buildBillRow("Package Charges", "₹ ${total - platformFee}",
                    showInfo: true),
                _buildBillRow("Platform Fee", "₹ $platformFee"),
                _buildBillRow("Transport Fee", "FREE"),
                _buildBillRow("Total", "₹ $total", bold: true),
              ],
            ),
          ),

          /// ✅ Proceed Button fixed at bottom
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: ResponsiveUtils.getResponsiveHeight(context, 20)
              ),
              child: SizedBox(
                width: ResponsiveUtils.getResponsiveWidth(context, 189),
                height: ResponsiveUtils.getResponsiveHeight(context, 32),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E535B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentOptionsScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Proceed to pay",
                    style: TextFontStyle.textFontStyle(
                        ResponsiveUtils.getResponsiveFontSize(context, 14),
                        Colors.white,
                        FontWeight.w500
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String value,
      {bool showInfo = false, bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.getResponsiveHeight(context, 3)
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                    height: 2.0,
                    letterSpacing: 0,
                    color: const Color(0xFF757575),
                  ),
                ),
                if (showInfo) SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 4)),
                if (showInfo)
                  Icon(
                      Icons.info_outline,
                      size: ResponsiveUtils.getResponsiveFontSize(context, 14),
                      color: const Color(0xFF757575)
                  ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
              height: 2.0,
              letterSpacing: 0,
              color: bold
                  ? const Color(0xFF1E535B)
                  : const Color(0xFF575959),
            ),
          ),
        ],
      ),
    );
  }
}