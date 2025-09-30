import 'package:aahwanam/widgets/booking_bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account_bloc.dart';
import '../../blocs/account/account_state.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/package_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  double _getScalingFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / 390;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AccountLoaded) {
          final scalingFactor = _getScalingFactor(context);
          ResponsiveUtils.isTablet(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                "Cart",
                style: TextFontStyle.textFontStyle(
                  ResponsiveUtils.getResponsiveFontSize(context, 18),
                  const Color(0xFF575959),
                  FontWeight.w500,
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                padding: ResponsiveUtils.getResponsivePadding(context, horizontal: 12),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: ResponsiveUtils.getResponsiveFontSize(context, 18),
                  color: const Color(0xFF575959),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Padding(
                  padding: ResponsiveUtils.getResponsivePadding(context, horizontal: 14,vertical: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.share_outlined,
                      size: ResponsiveUtils.getResponsiveFontSize(context, 24),
                      color: const Color(0xFF1E535B),
                    ),
                    onPressed: () {
                      // Implement share functionality
                    },
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: ResponsiveUtils.getResponsivePadding(context, horizontal: 18, vertical: 0),
                child: ListView.builder(
                  itemCount: state.addToCart.length,
                  itemBuilder: (context, index) {
                    final booking = state.addToCart[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: ResponsiveUtils.getResponsiveHeight(context, 12),
                      ),
                      child: PackageCard(
                        title: booking['title'],
                        description: booking['description'],
                        price: booking['price'],
                        imagePath: booking['imagePath'],
                        rating: booking['rating'],
                        imageType: PackageImageType.cart,
                        primaryButtonText: "Book Now",
                        onPrimaryButtonPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return BookingBottomSheet(
                                booking: booking,
                              );
                            },
                          );
                        },
                        secondaryButtonText: "Move to Wishlist",
                        onSecondaryButtonPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${booking['title']} moved to Wishlist",
                                style: TextFontStyle.textFontStyle(
                                  ResponsiveUtils.getResponsiveFontSize(context, 14),
                                  Colors.white,
                                  FontWeight.normal,
                                ),
                              ),
                              backgroundColor: Colors.black87,
                            ),
                          );
                        },
                        scalingFactor: scalingFactor, // Pass scaling factor
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text("Something went wrong")),
        );
      },
    );
  }
}