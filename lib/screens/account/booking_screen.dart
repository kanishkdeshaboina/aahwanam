import 'package:aahwanam/screens/account/detailed_all_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aahwanam/blocs/account/account_bloc.dart';
import 'package:aahwanam/blocs/account/account_state.dart';
import '../../services/decoration/decoration_theme.dart';
import '../../services/makeup_hair_service/MakeupDecor.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/package_card.dart';
import 'account_screen.dart';

class BookingScreen extends StatefulWidget {
  bool isAllBookingsSelected = true;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool isAllBookingsSelected = true;

  double _getScalingFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / 390;
  }

  String _extractDecoratorName(String fullTitle) {
    final parts = fullTitle.split('by');
    if (parts.length > 1) {
      return parts[1].trim();
    }
    return fullTitle;
  }

  @override
  Widget build(BuildContext context) {
    final scalingFactor = _getScalingFactor(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AccountLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text(
                "Bookings",
                style: TextStyle(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 19),
                  color: const Color(0xFF575959),
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: IconButton(
                padding: ResponsiveUtils.getResponsivePadding(context, horizontal: 22),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: ResponsiveUtils.getResponsiveFontSize(context, 18),
                  color: const Color(0xFF575959),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountScreen()),
                  );
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: ResponsiveUtils.getResponsivePadding(context, horizontal: 16, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Toggle buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isAllBookingsSelected = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: ResponsiveUtils.getResponsiveHeight(context, 11),
                                ),
                                backgroundColor: isAllBookingsSelected
                                    ? const Color(0xFF1E535B)
                                    : Colors.white,
                                foregroundColor: isAllBookingsSelected
                                    ? Colors.white
                                    : const Color(0xFF1E535B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveWidth(context, 12)),
                                  side: const BorderSide(
                                      color: Color(0xFF1E535B), width: 1),
                                ),
                              ),
                              child: Text(
                                "All Bookings",
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 13),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 8)),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isAllBookingsSelected = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: ResponsiveUtils.getResponsiveHeight(context, 11),
                                ),
                                foregroundColor: isAllBookingsSelected
                                    ? const Color(0xFF1E535B)
                                    : Colors.white,
                                backgroundColor: isAllBookingsSelected
                                    ? Colors.transparent
                                    : const Color(0xFF1E535B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveWidth(context, 12)),
                                  side: const BorderSide(
                                      color: Color(0xFF1E535B), width: 1),
                                ),
                              ),
                              child: Text(
                                "In Progress",
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 13),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 10)),

                      // Bookings List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: isAllBookingsSelected
                            ? state.bookings.length
                            : state.inProgressBookings.length,
                        itemBuilder: (context, index) {
                          final package = isAllBookingsSelected
                              ? state.bookings[index]
                              : state.inProgressBookings[index];

                          return Padding(
                            padding: EdgeInsets.only(bottom: ResponsiveUtils.getResponsiveHeight(context, 6)),
                            child: PackageCard(
                              title: package['title'],
                              description: package['description'],
                              price: package['price'],
                              details: package['details'],
                              imagePath: package['imagePath'],
                              rating: package['rating'],
                              imageType: PackageImageType.booking,
                              onTap: () {
                                if (isAllBookingsSelected) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailedAllBookingScreen(package: package),
                                    ),
                                  );
                                } else {
                                  final title = package['title']?.toLowerCase() ?? '';
                                  if (title.contains('dream decor')) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DecorationTheme(
                                          decorator: {
                                            'name': _extractDecoratorName(package['title'] ?? ''),
                                            'image': package['imagePath'] ?? '',
                                            'rating': '4.5',
                                            'price': package['price'] ?? '',
                                          },
                                        ),
                                      ),
                                    );
                                  } else if (title.contains('blush makeover')) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MakeUpTheme(
                                          makeupHair: {
                                            'name': _extractDecoratorName(package['title'] ?? ''),
                                            'image': package['imagePath'] ?? '',
                                            'rating': '4.2',
                                            'price': package['price'] ?? '',
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              scalingFactor: scalingFactor, // Pass scaling factor
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text("Something went wrong.")),
        );
      },
    );
  }
}