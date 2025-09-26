import 'package:aahwanam/blocs/account/account_bloc.dart';
import 'package:aahwanam/blocs/account/account_event.dart';
import 'package:aahwanam/blocs/account/account_state.dart';
import 'package:aahwanam/screens/account/booking_screen.dart';
import 'package:aahwanam/screens/dashboard/e_invitation_screen.dart';
import 'package:aahwanam/services/services_screen.dart';
import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/package_card.dart';

class DetailedAllBookingScreen extends StatefulWidget {
  final Map<String, dynamic> package;

  const DetailedAllBookingScreen({required this.package, Key? key})
      : super(key: key);

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
        title:  Text("Bookings",
          style: TextFontStyle.textFontStyle(
            18,                         // Font size
            Color(0xFF575959),          // Text color
            FontWeight.w500,            // Font weight
          ),
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(top: 2, left: 12),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Color(0xFF575959),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 0, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Package Card
            Card(
              elevation: 4,
              color: const Color(0xFFFFEFDF),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  // <-- this is key: use Row, not Column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // LEFT SIDE: Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            package['imagePath'],
                            fit: BoxFit.cover,
                            width: 80,
                            height: 90,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 10),
                    // RIGHT SIDE: Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package['title'],
                              style:TextFontStyle.textFontStyle(12,Color(0xFF575959), FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              package['description'],
                              style:TextFontStyle.textFontStyle(13,Color(0xFF757575), FontWeight.w400),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Price: ₹${package['price']}",
                              style:TextFontStyle.textFontStyle(13,Color(0xFF1E535B), FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

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
                            Text("Event Date",
                              style:TextFontStyle.textFontStyle(14,Color(0xFF575959), FontWeight.w500),
                            ),
                            const SizedBox(height: 6),
                            _buildInputBox("22, Feb 2025"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Event Time
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Event Time",
                              style:TextFontStyle.textFontStyle(14,Color(0xFF575959), FontWeight.w500),
                            ),
                            const SizedBox(height: 6),
                            _buildInputBox("11:15 PM"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Event Address
                  Text("Event Address",
                    style:TextFontStyle.textFontStyle(14,Color(0xFF575959), FontWeight.w500),

                  ),
                  const SizedBox(height: 6),
                  _buildInputBoxWithTitle("Financial District, Hyderabad",
                      "Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,"),

                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 10),

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
            SizedBox(height: 10),
            // Accordion: Booking Status
            _buildAccordion(
              title: "Booking Status",
              expanded: _showStatusDetails,
              onToggle: () =>
                  setState(() => _showStatusDetails = !_showStatusDetails),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), // customize as needed
                child: Column(
                  children: [
                    _buildStatusStep("Booking Confirmed", "22, Feb", true),
                    _buildStatusStep("Artist Assigned", "Today", true),
                    _buildStatusStep("Delivery", "25, Feb", false, isLast: true),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Text("Artist assigned for you",
              style:TextFontStyle.textFontStyle(16,Color(0xFF575959), FontWeight.w500),
            ),

            SizedBox(height: 10),

            // Artist Card
            Card(
              color: const Color(0xFFF8F8F8),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(33), // Set border radius here
              ),
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/profile_pic.png'),
                  ),
                ),
                title: Text("Janey Cooper",
                  style:TextFontStyle.textFontStyle(12,Color(0xFF575959), FontWeight.w500),),
                subtitle: Text("Support Team",
                  style:TextFontStyle.textFontStyle(10,Color(0xFF575959), FontWeight.w300),),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCircleIcon(Icons.call),
                    const SizedBox(width: 8),
                    _buildCircleIcon(Icons.chat),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EInvitationScreen()),
                  );
                  // TODO: Add send invitation logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black26),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:  Text("Send Invitation",
                  style: TextFontStyle.textFontStyle(14, Color(0xFF1E535B), FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServicesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E535B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Other Services",
                  style: TextFontStyle.textFontStyle(14, Color(0xFFFFFFFF), FontWeight.w500),
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
            title: Text(title,
              style:TextFontStyle.textFontStyle(16,Color(0xFF575959), FontWeight.w500),
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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: child),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Color(0xFF1E535B), // Background color
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 18), // White icon
        onPressed: () {},
        padding: EdgeInsets.zero, // Remove extra padding
        constraints: BoxConstraints(), // Remove IconButton constraints
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
      valueColor = const Color(0xFF1E535B); // Dark teal
      valueWeight = FontWeight.bold;
    } else if (isFree) {
      valueColor = Colors.green;
      valueWeight = FontWeight.w600;
    } else if (isPaidValue) {
      valueColor = Color(0xFF1E535B);
      valueWeight = FontWeight.w600;
    } else {
      valueColor = Colors.grey;
      valueWeight = FontWeight.w500;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: valueWeight, color: valueColor, fontSize: 14, fontFamily: 'Poppins')),
          Text(value,
              style: TextStyle(
                  fontWeight: valueWeight, color: valueColor, fontSize: 14, fontFamily: 'Poppins')),
        ],
      ),
    );
  }

  Widget _buildInputBoxWithTitle(String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:TextFontStyle.textFontStyle(14,Colors.black87, FontWeight.w300),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style:TextFontStyle.textFontStyle(13,Colors.grey, FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(value,
        style:TextFontStyle.textFontStyle(14,Color(0xFF575959), FontWeight.w500),

      ),
    );
  }

  Widget _buildStatusStep(String title, String date, bool completed,
      {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and line
          Column(
            children: [
              // Status circle
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed ? Color(0xFF1E535B) : Colors.white,
                  border: Border.all(
                    color: completed ? Color(0xFF1E535B) : Colors.grey,
                    width: 2,
                  ),
                ),
              ),

              // Connector line
              if (!isLast)
                Container(
                  width: 2,
                  height: 38,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
          const SizedBox(width: 12),

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
                    style:TextFontStyle.textFontStyle(14,Color(0xFF575959), FontWeight.w500),
                  ),
                ),
                // Date aligned right
                Text(
                  date,
                  style:TextFontStyle.textFontStyle(12,Color(0xFF757575), FontWeight.w400),
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
