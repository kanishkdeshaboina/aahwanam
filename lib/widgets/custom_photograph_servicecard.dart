import 'package:aahwanam/models/service_details.dart';
import 'package:aahwanam/widgets/custom_gallery_section_widget.dart';
import 'package:aahwanam/widgets/custom_service_overview_tab.dart';
import 'package:aahwanam/widgets/custom_service_review_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/gallery_section.dart';
import 'custom_text_field.dart';


class CustomServiceCard extends StatelessWidget {

  final String name;
  final String imagePath;
  final double price;
  final double rating;
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


  CustomServiceCard ({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.rating,
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

  }) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Section (non-scrollable)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFF4F4F4), width: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.zero,
                color: Color(0xFFF4F4F4),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath,
                          width: double.infinity,
                          height: 90,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: TextFontStyle.textFontStyle(14, const Color(0xFF575959), FontWeight.w500)),
                              SizedBox(height: 4),
                              Text( "${price}" ,
                                  style: TextFontStyle.textFontStyle(14, const Color(0xFF575959), FontWeight.w600)
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 4),
                              Text("${rating}"
                                  , style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            // TabBar
            PreferredSize(
              preferredSize: Size.fromHeight(50), // Adjust height as needed
              child: TabBar(
                labelColor: Color(0xFF575959),
                unselectedLabelColor: Color(0xFF757575),
                dividerHeight: 0,
                indicatorColor: Color(0xFF575959),
                tabs: [
                  Tab(child: Align(alignment: Alignment.center, child: Text("All Details", style: TextFontStyle.textFontStyle(12, const Color(0xFF575959), FontWeight.w500), // smaller text
                  ))),
                  Tab(child: Align(alignment: Alignment.center, child: Text("Gallery", style: TextFontStyle.textFontStyle(12, const Color(0xFF575959), FontWeight.w500), // smaller text
                  ))),
                  Tab(child: Align(alignment: Alignment.center, child: Text("Reviews", style: TextFontStyle.textFontStyle(12, const Color(0xFF575959), FontWeight.w500), // smaller text
                  ))),
                ],
              ),
            ),


            // Tab content (scrollable only inside tabs)
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: ServiceOverviewTab(
                      heading: heading,
                      packagePrice: packagePrice,
                      description: description,
                      subHeading: subHeading,
                      subHeadingDetails: subHeadingDetails,
                      eventTitle: eventTitle,
                      address: address,
                      addressDescription: addressDescription,
                      onChangeAddress: () => _showChangeAddress(context),
                      label1: label1,
                      label2: label2,
                      initialValue1: initialValue1,
                      initialValue2: initialValue2,
                    ),
                  ),


                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: mediaSections.map((section) {
                        return GallerySectionWidget(
                          title: section.title,
                          mediaPaths: section.mediaPaths,
                          isVideo: section.isVideo,
                          isGrid: section.useGrid, // Add this property if needed
                        );
                      }).toList(),
                    ),
                  ),


                  SingleChildScrollView(

                    child: ReviewsTab(
                      reviewPhotoUrls: reviewPhotoUrls ,
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
        height: MediaQuery.of(context).size.height * 0.5, // 👈 fixed height (60% of screen)
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(  // 👈 scrolling inside content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Address',
                style: TextFontStyle.textFontStyle(18, const Color(0xFF575959), FontWeight.w600), // smaller text


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
                    style: TextFontStyle.textFontStyle(12, const Color(0xFF1E535B), FontWeight.w500), // smaller text


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
                subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              SizedBox(height: 12),
              _addressTile(
                title: 'Madhapur',
                subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              SizedBox(height: 12),
              _addressTile(
                title: 'Hitech City',
                subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
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
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14), // 👈 Padding
                      minimumSize: Size(0, 0), // 👈 Not forcing full width
                    ),
                    child: Text(
                      'Save Address',
                      style: TextStyle(fontSize: 16,color: Colors.white),
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
class BulletPointList extends StatelessWidget {
  final List<String> points;

  const BulletPointList({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map(
            (point) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Icon(Icons.circle, size: 6, color: Colors.black),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
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
            fontSize: 14,fontWeight: FontWeight.w300,
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