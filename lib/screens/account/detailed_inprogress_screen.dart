import 'package:aahwanam/blocs/account/account_event.dart';
import 'package:aahwanam/blocs/account/account_state.dart';
import 'package:aahwanam/blocs/account/account_bloc.dart';
import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/responsive_utils.dart';

class DetailedInprogressScreen extends StatelessWidget {
  const DetailedInprogressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(LoadAccountInfo()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Avoid default back button
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getResponsiveWidth(context, 12)
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                        Icons.chevron_left,
                        size: ResponsiveUtils.getResponsiveFontSize(context, 32),
                        color: Colors.black
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      height: ResponsiveUtils.getResponsiveHeight(context, 40),
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.getResponsiveWidth(context, 10)
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search here...',
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 10)),
                  GestureDetector(
                    onTap: () => print("Time icon pressed"),
                    child: Image.asset(
                        'assets/images/timer.png',
                        width: ResponsiveUtils.getResponsiveWidth(context, 24),
                        height: ResponsiveUtils.getResponsiveHeight(context, 24)
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 10)),
                  GestureDetector(
                    onTap: () => print("Cart icon pressed"),
                    child: Image.asset(
                        'assets/images/cart.png',
                        width: ResponsiveUtils.getResponsiveWidth(context, 24),
                        height: ResponsiveUtils.getResponsiveHeight(context, 24)
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 10)),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: ResponsiveUtils.getResponsiveFontSize(context, 24),
                    ),
                    onPressed: () => print("Favorite pressed"),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              final details = state.serviceDetails;
              return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomServiceCard(
                    name: details.name,
                    imagePath: details.imagePath,
                    price: details.price,
                    rating: details.rating,
                    heading: details.heading,
                    packagePrice: details.packagePrice,
                    description: details.description,
                    subHeading: details.subHeading,
                    subHeadingDetails: details.subHeadingDetails,
                    eventTitle: details.eventTitle,
                    address: details.address,
                    addressDescription: details.addressDescription,
                    mediaSections: details.mediaSections,
                    reviewPhotoUrls: details.reviewPhotoUrls,
                    totalRatings: details.totalRatings,
                    totalReviews: details.totalReviews,
                    averageRating: details.averageRating,
                  ));
            } else if (state is AccountError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Select a booking"));
          },
        ),
      ),
    );
  }
}

// If CustomServiceCard is not available, here's an alternative implementation:
class CustomServiceCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final dynamic price;
  final double rating;
  final String heading;
  final String packagePrice;
  final String description;
  final String subHeading;
  final String subHeadingDetails;
  final String eventTitle;
  final String address;
  final String addressDescription;
  final List<dynamic> mediaSections;
  final List<dynamic> reviewPhotoUrls;
  final int totalRatings;
  final int totalReviews;
  final double averageRating;

  const CustomServiceCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.heading,
    required this.packagePrice,
    required this.description,
    required this.subHeading,
    required this.subHeadingDetails,
    required this.eventTitle,
    required this.address,
    required this.addressDescription,
    required this.mediaSections,
    required this.reviewPhotoUrls,
    required this.totalRatings,
    required this.totalReviews,
    required this.averageRating,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveUtils.getResponsiveWidth(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ResponsiveUtils.getResponsiveWidth(context, 16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        width: ResponsiveUtils.getResponsiveWidth(context, 80),
                        height: ResponsiveUtils.getResponsiveHeight(context, 80),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextFontStyle.textFontStyle(
                              ResponsiveUtils.getResponsiveFontSize(context, 16),
                              const Color(0xFF575959),
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 4)),
                          Text(
                            heading,
                            style: TextFontStyle.textFontStyle(
                              ResponsiveUtils.getResponsiveFontSize(context, 14),
                              const Color(0xFF757575),
                              FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 4)),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: ResponsiveUtils.getResponsiveFontSize(context, 16),
                              ),
                              SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 4)),
                              Text(
                                rating.toString(),
                                style: TextFontStyle.textFontStyle(
                                  ResponsiveUtils.getResponsiveFontSize(context, 14),
                                  const Color(0xFF575959),
                                  FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 8)),
                              Text(
                                '($totalReviews reviews)',
                                style: TextFontStyle.textFontStyle(
                                  ResponsiveUtils.getResponsiveFontSize(context, 12),
                                  const Color(0xFF757575),
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                Text(
                  description,
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 14),
                    const Color(0xFF575959),
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 16)),

          // Package Details
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ResponsiveUtils.getResponsiveWidth(context, 16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Package Details',
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 18),
                    const Color(0xFF575959),
                    FontWeight.w600,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                _buildDetailRow('Package', packagePrice),
                _buildDetailRow('Event', eventTitle),
                _buildDetailRow('Address', address),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 8)),
                Text(
                  addressDescription,
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 12),
                    const Color(0xFF757575),
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 16)),

          // Progress Status
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ResponsiveUtils.getResponsiveWidth(context, 16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Progress',
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 18),
                    const Color(0xFF575959),
                    FontWeight.w600,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 16)),
                _buildProgressStep('Booking Confirmed', '22 Feb 2024', true),
                _buildProgressStep('Service Started', '23 Feb 2024', true),
                _buildProgressStep('In Progress', 'Current', true, isCurrent: true),
                _buildProgressStep('Completion', '25 Feb 2024', false),
                _buildProgressStep('Delivery', '26 Feb 2024', false),
              ],
            ),
          ),

          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 16)),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Contact support action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black26),
                    padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.getResponsiveHeight(context, 14)
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Contact Support",
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 14),
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
                    // Track service action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E535B),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.getResponsiveHeight(context, 14)
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Track Service",
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 14),
                      Colors.white,
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 20)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Builder(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.getResponsiveHeight(context, 6)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 14),
                    const Color(0xFF757575),
                    FontWeight.w400,
                  ),
                ),
                Text(
                  value,
                  style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 14),
                    const Color(0xFF575959),
                    FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildProgressStep(String title, String date, bool completed, {bool isCurrent = false}) {
    return Builder(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.getResponsiveHeight(context, 8)
            ),
            child: Row(
              children: [
                Container(
                  width: ResponsiveUtils.getResponsiveWidth(context, 24),
                  height: ResponsiveUtils.getResponsiveHeight(context, 24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent ? const Color(0xFF1E535B) :
                    completed ? Colors.green : Colors.grey[300],
                    border: isCurrent ? Border.all(color: const Color(0xFF1E535B), width: 2) : null,
                  ),
                  child: completed && !isCurrent
                      ? Icon(
                    Icons.check,
                    size: ResponsiveUtils.getResponsiveFontSize(context, 14),
                    color: Colors.white,
                  )
                      : isCurrent
                      ? Icon(
                    Icons.access_time,
                    size: ResponsiveUtils.getResponsiveFontSize(context, 14),
                    color: Colors.white,
                  )
                      : null,
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextFontStyle.textFontStyle(
                          ResponsiveUtils.getResponsiveFontSize(context, 14),
                          isCurrent ? const Color(0xFF1E535B) :
                          completed ? const Color(0xFF575959) : const Color(0xFF757575),
                          isCurrent ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 2)),
                      Text(
                        date,
                        style: TextFontStyle.textFontStyle(
                          ResponsiveUtils.getResponsiveFontSize(context, 12),
                          const Color(0xFF757575),
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}