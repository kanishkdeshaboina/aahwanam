import 'package:aahwanam/models/service_details.dart';
import 'package:aahwanam/widgets/custom_gallery_section_widget.dart';
import 'package:aahwanam/widgets/custom_service_overview_tab.dart';
import 'package:aahwanam/widgets/custom_service_review_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/gallery_section.dart';
import '../screens/dashboard/photograph_book_service_screen.dart';
import 'custom_date_time_bottom_sheet.dart';
import 'custom_text_field.dart';

class CustomValetServiceCard extends StatelessWidget {
  final String heading;
  final String packagePrice;
  final String description;
  final String subHeading;
  final String subHeadingDetails;
  final String eventTitle;
  final String address;
  final String addressDescription;
  final List<GallerySection> mediaSections;
  final List<String> reviewPhotoUrls; // add this
  final int totalRatings;
  final int totalReviews;
  final double averageRating;
  final String? label1;
  final String? label2;
  final String? initialValue1;
  final String? initialValue2;
  final String? imagePath;
  final String? price;
  final int? count;

  CustomValetServiceCard({
    Key? key,
    required this.description,
    required this.address,
    required this.addressDescription,
    required this.heading,
    required this.packagePrice,
    required this.subHeading,
    required this.subHeadingDetails,
    required this.eventTitle,
    required this.reviewPhotoUrls,
    required this.mediaSections, // ✅ required new param
    required this.totalRatings,
    required this.totalReviews,
    required this.averageRating,
    this.label1,
    this.label2,
    this.initialValue1,
    this.initialValue2,
    this.imagePath,
    this.price,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Fixed invalid return
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        toolbarHeight: 56,
        titleSpacing: 0,
        leadingWidth: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 24, color: Color(0xFF1E535B)),
              onPressed: () => Navigator.pop(context),
              padding: const EdgeInsets.only(left: 8),
              splashRadius: 20,
              constraints: const BoxConstraints(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(height: 40, child: _buildSearchBar()),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) => CustomDateTimeBottomSheet(
                        onConfirm: (DateTime fullDateTime) {
                          print("Selected DateTime: $fullDateTime");
                        },
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(Icons.calendar_today,
                          size: 20, color: Color(0xFF004d40)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(Icons.access_time,
                            size: 10, color: Color(0xFF004d40)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset('assets/images/cart.png', width: 24, height: 24),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // Buttons Row

          // Tabs
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Padding(
                padding: const EdgeInsets.only(left:2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      labelColor: const Color(0xFF575959),
                      unselectedLabelColor: const Color(0xFF757575),
                      dividerHeight: 0,
                      indicatorColor: const Color(0xFF575959),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.centerLeft, // optional, aligns text to left
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5), // ✅ only this tab text
                              child: Text(
                                "All Details",
                                style: TextFontStyle.textFontStyle(
                                  16,
                                  const Color(0xFF1E535B),
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            child: Text(
                              "Gallery",
                              style: TextFontStyle.textFontStyle(
                                16,
                                const Color(0xFF1E535B),
                                FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            child: Text(
                              "Reviews",
                              style: TextFontStyle.textFontStyle(
                                16,
                                const Color(0xFF1E535B),
                                FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: ServiceOverviewTab(
                                heading: heading,
                                packagePrice: packagePrice,
                                description: description,
                                subHeading: subHeading,
                                subHeadingDetails: subHeadingDetails,
                                eventTitle: eventTitle,
                                address: address,
                                addressDescription: addressDescription,
                                onChangeAddress: () =>
                                    _showChangeAddress(context),
                                label1: label1,
                                label2: label2,
                                initialValue1: initialValue1,
                                initialValue2: initialValue2,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: mediaSections.map((section) {
                                return GallerySectionWidget(
                                  title: section.title,
                                  mediaPaths: section.mediaPaths,
                                  isVideo: section.isVideo,
                                  isGrid: section.useGrid,
                                );
                              }).toList(),
                            ),
                          ),
                          SingleChildScrollView(
                            child: ReviewsTab(
                              reviewPhotoUrls: reviewPhotoUrls,
                              totalRatings: totalRatings,
                              totalReviews: totalReviews,
                              averageRating: averageRating,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48, // Equal height for both buttons
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1E535B)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        // Add to cart logic
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextFontStyle.textFontStyle(
                          12,
                          const Color(0xFF1E535B),
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Space between buttons
                Expanded(
                  child: SizedBox(
                    height: 48, // Equal height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E535B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotographBookServiceScreen(
                              imagePath: imagePath,
                              price: price,
                              count: count,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Book Service",
                        style: TextFontStyle.textFontStyle(
                          12,
                          Colors.white,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showChangeAddress(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // important for full control
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height *
            0.5, // 👈 fixed height (60% of screen)
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          // 👈 scrolling inside content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF575959),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showAddNewAddress(context);
                  },
                  icon: Icon(Icons.add, color: Color(0xFF1E535B)),
                  label: Text(
                    'Add New Address',
                    style: TextStyle(color: Color(0xFF1E535B)),
                  ),
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    side: BorderSide(color: Color(0xFF1E535B)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Your saved address',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF575959),
                ),
              ),
              SizedBox(height: 16),

              /// Address Tiles
              _addressTile(
                title: 'Financial District',
                subtitle:
                'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              SizedBox(height: 12),
              _addressTile(
                title: 'Madhapur',
                subtitle:
                'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              SizedBox(height: 12),
              _addressTile(
                title: 'Hitech City',
                subtitle:
                'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              // SizedBox(height: 12),
              // _addressTile(
              //   title: 'Gachibowli',
              //   subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

Widget _addressTile({required String title, required String subtitle}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFF7F1), // light background
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF575959),
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: Size(45, 30),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            side: BorderSide(color: Color(0xFF1E535B)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            'Edit',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF1E535B),
            ),
          ),
        ),
      ],
    ),
  );
}

void _showAddNewAddress(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF575959),
                  ),
                ),
                SizedBox(height: 16),
                _buildTextField(
                  hintText: 'Enter your Flat / House no / Building name ',
                  label: 'Flat / House no / Building name *',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Floor (Optional)',
                  label: 'Floor',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Enter your area / sector / locality',
                  label: 'Area / Sector / Locality *',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Enter landmark',
                  label: 'Landmark',
                ),
                SizedBox(height: 24),
                Text(
                  'Enter your details for seamless experience',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 16),
                _buildTextField(
                  hintText: 'Enter your name',
                  label: 'Name *',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Enter your mobile number',
                  label: 'Phone Number',
                  keyboardType: TextInputType.number,
                  isNumberField: true, // 👈 NEW for phone field
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close Add New Address
                      Future.delayed(Duration(milliseconds: 20), () {
                        Navigator.pop(context); // Close Change Address
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E535B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14), // 👈 Padding
                      minimumSize: Size(0, 0), // 👈 Not forcing full width
                    ),
                    child: Text(
                      'Save Address',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildSearchBar() {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Search here...',
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: const Color(0xFFF8F8F8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

/// Common textfield builder
Widget _buildTextField({
  required String hintText,
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool isNumberField = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF575959),
        ),
      ),
      SizedBox(height: 6),
      TextField(
        keyboardType: keyboardType,
        inputFormatters: isNumberField
            ? [FilteringTextInputFormatter.digitsOnly] // 👈 Allow only numbers
            : null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFF757575), // 👈 Set hint text color
            fontSize: 14, fontWeight: FontWeight.w300,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    ],
  );
}
