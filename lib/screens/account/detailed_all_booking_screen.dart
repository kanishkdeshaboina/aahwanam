import 'package:aahwanam/screens/dashboard/e_invitation_screen.dart';
import 'package:aahwanam/services/services_screen.dart';
import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';

class DetailedAllBookingScreen extends StatefulWidget {
  final Map<String, dynamic> package;

  const DetailedAllBookingScreen({required this.package, super.key});

  @override
  State<DetailedAllBookingScreen> createState() =>
      _DetailedAllBookingScreenState();
}

class _DetailedAllBookingScreenState extends State<DetailedAllBookingScreen> {
  bool _showEventDetails = false;
  bool _showBillDetails = false;
  bool _showStatusDetails = false;

  @override
  Widget build(BuildContext context) {
    final package = widget.package;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Bookings",
          style: TextFontStyle.textFontStyle(
            ResponsiveUtils.getResponsiveFontSize(context, 18),
            const Color(0xFF575959),
            FontWeight.w500,
          ),
        ),
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          ResponsiveUtils.getResponsiveWidth(context, 18),
          0,
          ResponsiveUtils.getResponsiveWidth(context, 16),
          ResponsiveUtils.getResponsiveHeight(context, 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Package Card
            Card(
              elevation: 4,
              color: const Color(0xFFFFEFDF),
              child: Padding(
                padding: ResponsiveUtils.getResponsivePadding(context, all: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT SIDE: Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        package['imagePath'],
                        fit: BoxFit.cover,
                        width:
                        ResponsiveUtils.getResponsiveWidth(context, 80),
                        height:
                        ResponsiveUtils.getResponsiveHeight(context, 85),
                      ),
                    ),

                    SizedBox(
                        width: ResponsiveUtils.getResponsiveWidth(context, 6)),
                    // RIGHT SIDE: Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package['title'],
                              style: TextFontStyle.textFontStyle(
                                ResponsiveUtils.getResponsiveFontSize(
                                    context, 12),
                                const Color(0xFF575959),
                                FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                                height: ResponsiveUtils.getResponsiveHeight(
                                    context, 4)),
                            Text(
                              package['description'],
                              style: TextFontStyle.textFontStyle(
                                ResponsiveUtils.getResponsiveFontSize(
                                    context, 12),
                                const Color(0xFF757575),
                                FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                                height: ResponsiveUtils.getResponsiveHeight(
                                    context, 10)),
                            Text(
                              "Price: ₹${package['price']}",
                              style: TextFontStyle.textFontStyle(
                                ResponsiveUtils.getResponsiveFontSize(
                                    context, 13),
                                const Color(0xFF1E535B),
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 10)),

            // Accordion: Event Details
            _buildAccordion(
              title: "Event Details",
              expanded: _showEventDetails,
              onToggle: () =>
                  setState(() => _showEventDetails = !_showEventDetails),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Date & Time in a Row
                  Row(
                    children: [
                      // Event Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Event Date",
                              style: TextFontStyle.textFontStyle(
                                ResponsiveUtils.getResponsiveFontSize(
                                    context, 14),
                                const Color(0xFF575959),
                                FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                                height: ResponsiveUtils.getResponsiveHeight(
                                    context, 6)),
                            _buildInputBox("22, Feb 2025"),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: ResponsiveUtils.getResponsiveWidth(
                              context, 16)),
                      // Event Time
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Event Time",
                              style: TextFontStyle.textFontStyle(
                                ResponsiveUtils.getResponsiveFontSize(
                                    context, 14),
                                const Color(0xFF575959),
                                FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                                height: ResponsiveUtils.getResponsiveHeight(
                                    context, 6)),
                            _buildInputBox("11:15 PM"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                      height:
                      ResponsiveUtils.getResponsiveHeight(context, 14)),

                  // Event Address
                  Text(
                    "Event Address",
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 14),
                      const Color(0xFF575959),
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                      height:
                      ResponsiveUtils.getResponsiveHeight(context, 6)),
                  _buildInputBoxWithTitle(
                    "Financial District, Hyderabad",
                    "Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,",
                  ),

                  SizedBox(
                      height:
                      ResponsiveUtils.getResponsiveHeight(context, 10)),
                ],
              ),
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 6)),

            // Accordion: Bill Details
            _buildAccordion(
              title: "Bill Details",
              expanded: _showBillDetails,
              onToggle: () =>
                  setState(() => _showBillDetails = !_showBillDetails),
              child: Column(
                children: [
                  _buildInfoRow("Makeup Charges", "₹ 8,000"),
                  _buildInfoRow("Hairstyle Charges", "₹ 2,000"),
                  _buildInfoRow("Platform Fee", "100"),
                  _buildInfoRow("Transport Fee", "FREE", isFree: true),
                  _buildInfoRow("Paid", "₹ 10,100",
                      isPaid: true, isPaidValue: true),
                ],
              ),
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 10)),

            // Accordion: Booking Status
            _buildAccordion(
              title: "Booking Status",
              expanded: _showStatusDetails,
              onToggle: () =>
                  setState(() => _showStatusDetails = !_showStatusDetails),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getResponsiveWidth(context, 8),
                  vertical: ResponsiveUtils.getResponsiveHeight(context, 8),
                ),
                child: Column(
                  children: [
                    _buildStatusStep("Booking Confirmed", "22, Feb", true),
                    _buildStatusStep("Artist Assigned", "Today", true),
                    _buildStatusStep("Delivery", "25, Feb", false,
                        isLast: true),
                  ],
                ),
              ),
            ),

            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 20)),
            Text(
              "Artist assigned for you",
              style: TextFontStyle.textFontStyle(
                ResponsiveUtils.getResponsiveFontSize(context, 16),
                const Color(0xFF575959),
                FontWeight.w500,
              ),
            ),

            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 10)),

            // Artist Card
            Card(
              color: const Color(0xFFF8F8F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33),
              ),
              child: ListTile(
                leading: SizedBox(
                  width: ResponsiveUtils.getResponsiveWidth(context, 50),
                  height: ResponsiveUtils.getResponsiveHeight(context, 50),
                  child: const CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/profile_pic.png'),
                  ),
                ),
                title: Text(
                  "Janey Cooper",
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 12),
                    const Color(0xFF575959),
                    FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "Support Team",
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 10),
                    const Color(0xFF575959),
                    FontWeight.w300,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCircleIcon(Icons.call),
                    SizedBox(
                        width:
                        ResponsiveUtils.getResponsiveWidth(context, 8)),
                    _buildCircleIcon(Icons.chat),
                  ],
                ),
              ),
            ),

            SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 10)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getResponsiveWidth(context, 20),
          vertical: ResponsiveUtils.getResponsiveHeight(context, 24),
        ),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EInvitationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    vertical:
                    ResponsiveUtils.getResponsiveHeight(context, 12),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(
                      color: Color(0xFF1E535B),
                      width: 1.2,
                    ),
                  ),
                ),
                child: Text(
                  "Send Invitation",
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 13),
                    const Color(0xFF1E535B),
                    FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 12)),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServicesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E535B),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical:
                    ResponsiveUtils.getResponsiveHeight(context, 12),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Other Services",
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 13),
                    const Color(0xFFFFFFFF),
                    FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordion({
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Card(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextFontStyle.textFontStyle(
                ResponsiveUtils.getResponsiveFontSize(context, 16),
                const Color(0xFF575959),
                FontWeight.w500,
              ),
            ),
            trailing: IconButton(
              icon: Icon(expanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: onToggle,
            ),
          ),
          if (expanded)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getResponsiveWidth(context, 16),
                vertical: ResponsiveUtils.getResponsiveHeight(context, 8),
              ),
              child: child,
            ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      width: ResponsiveUtils.getResponsiveWidth(context, 36),
      height: ResponsiveUtils.getResponsiveHeight(context, 36),
      decoration: const BoxDecoration(
        color: Color(0xFF1E535B),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: ResponsiveUtils.getResponsiveFontSize(context, 18),
        ),
        onPressed: () {},
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildInfoRow(
      String label,
      String value, {
        bool isPaid = false,
        bool isFree = false,
        bool isPaidValue = false,
      }) {
    Color valueColor;
    FontWeight valueWeight;

    if (isPaid) {
      valueColor = const Color(0xFF1E535B);
      valueWeight = FontWeight.bold;
    } else if (isFree) {
      valueColor = Colors.green;
      valueWeight = FontWeight.w600;
    } else if (isPaidValue) {
      valueColor = const Color(0xFF1E535B);
      valueWeight = FontWeight.w600;
    } else {
      valueColor = Colors.grey;
      valueWeight = FontWeight.w500;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.getResponsiveHeight(context, 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextFontStyle.textFontStyle(
              ResponsiveUtils.getResponsiveFontSize(context, 14),
              valueColor,
              valueWeight,
            ),
          ),
          Text(
            value,
            style: TextFontStyle.textFontStyle(
              ResponsiveUtils.getResponsiveFontSize(context, 14),
              valueColor,
              valueWeight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBoxWithTitle(String title, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getResponsiveWidth(context, 12),
        vertical: ResponsiveUtils.getResponsiveHeight(context, 12),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextFontStyle.textFontStyle(
              ResponsiveUtils.getResponsiveFontSize(context, 14),
              Colors.black87,
              FontWeight.w300,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 4)),
          Text(
            description,
            style: TextFontStyle.textFontStyle(
              ResponsiveUtils.getResponsiveFontSize(context, 13),
              Colors.grey,
              FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox(String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getResponsiveWidth(context, 12),
        vertical: ResponsiveUtils.getResponsiveHeight(context, 14),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: TextFontStyle.textFontStyle(
          ResponsiveUtils.getResponsiveFontSize(context, 14),
          const Color(0xFF575959),
          FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatusStep(
      String title,
      String date,
      bool completed, {
        bool isLast = false,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.getResponsiveHeight(context, 0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and line
          Column(
            children: [
              // Status circle
              Container(
                width: ResponsiveUtils.getResponsiveWidth(context, 20),
                height: ResponsiveUtils.getResponsiveHeight(context, 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  completed ? const Color(0xFF1E535B) : Colors.white,
                  border: Border.all(
                    color:
                    completed ? const Color(0xFF1E535B) : Colors.grey,
                    width: 2,
                  ),
                ),
              ),

              // Connector line
              if (!isLast)
                Container(
                  width: 2,
                  height: ResponsiveUtils.getResponsiveHeight(context, 38),
                  color: Colors.grey.shade400,
                ),
            ],
          ),
          SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 12)),

          // Title and date aligned in one row
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title text
                Expanded(
                  child: Text(
                    title,
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 14),
                      const Color(0xFF575959),
                      FontWeight.w500,
                    ),
                  ),
                ),
                // Date aligned right
                Text(
                  date,
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 12),
                    const Color(0xFF757575),
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
