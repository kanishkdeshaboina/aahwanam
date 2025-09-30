import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account_bloc.dart';
import '../../blocs/account/account_state.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/custom_image_card_widget.dart';
import '../../widgets/package_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isAllSelected = true;

  double _getScalingFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / 390; // 390 is your design reference width
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
          final wishlistItems = state.wishlist;
          final conceptsTabImages = state.conceptsTabImages;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                "Wishlist",
                style: TextFontStyle.textFontStyle(
                  isTablet ? 22 : ResponsiveUtils.getResponsiveFontSize(context, 16),
                  const Color(0xFF575959),
                  FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                padding: ResponsiveUtils.getResponsivePadding(context, horizontal: 8),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: ResponsiveUtils.getResponsiveFontSize(context, 18),
                  color: const Color(0xFF575959),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Padding(
                  padding: ResponsiveUtils.getResponsivePadding(context, horizontal: 12),
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
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 30 : ResponsiveUtils.getResponsiveWidth(context, 16),
                vertical: isTablet ? 20 : ResponsiveUtils.getResponsiveHeight(context, 0),
              ),
              child: Column(
                children: [
                  // Toggle Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => isAllSelected = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAllSelected
                                ? const Color(0xFF1E535B)
                                : Colors.white,
                            foregroundColor: isAllSelected
                                ? Colors.white
                                : const Color(0xFF1E535B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveWidth(context, 12)),
                              side: const BorderSide(
                                color: Color(0xFF1E535B),
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: isTablet ? 16 : ResponsiveUtils.getResponsiveHeight(context, 10),
                            ),
                          ),
                          child: Text(
                            "Services",
                            style: TextFontStyle.textFontStyle(
                              isTablet ? 16 : ResponsiveUtils.getResponsiveFontSize(context, 14),
                              isAllSelected ? Colors.white : const Color(0xFF1E535B),
                              FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.getResponsiveWidth(context, 8)),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setState(() => isAllSelected = false),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isAllSelected
                                ? Colors.transparent
                                : const Color(0xFF1E535B),
                            foregroundColor: isAllSelected
                                ? const Color(0xFF1E535B)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveWidth(context, 12)),
                              side: const BorderSide(
                                color: Color(0xFF1E535B),
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: isTablet ? 16 : ResponsiveUtils.getResponsiveHeight(context, 10),
                            ),
                          ),
                          child: Text(
                            "Concepts",
                            style: TextFontStyle.textFontStyle(
                              isTablet ? 16 : ResponsiveUtils.getResponsiveFontSize(context, 14),
                              isAllSelected ? const Color(0xFF1E535B) : Colors.white,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 20 : ResponsiveUtils.getResponsiveHeight(context, 12)),

                  // Cards List
                  Expanded(
                    child: isAllSelected
                        ? (wishlistItems.isEmpty
                        ? Center(
                      child: Text(
                        "Your wishlist is empty",
                        style: TextFontStyle.textFontStyle(
                          isTablet ? 18 : ResponsiveUtils.getResponsiveFontSize(context, 14),
                          Colors.black,
                          FontWeight.w400,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: wishlistItems.length,
                      itemBuilder: (context, index) {
                        final item = wishlistItems[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: isTablet ? 20 : ResponsiveUtils.getResponsiveHeight(context, 12)
                          ),
                          child: PackageCard(
                            title: item['title'],
                            description: item['description'],
                            price: item['price'],
                            imagePath: item['imagePath'],
                            rating: item['rating'],
                            showLikeIcon: true,
                            imageType: PackageImageType.wishlist,
                            primaryButtonText: "Move to Cart",
                            onPrimaryButtonPressed: () {},
                            primaryButtonWidth: ResponsiveUtils.getResponsiveWidth(context, 130),
                            primaryButtonHeight: ResponsiveUtils.getResponsiveHeight(context, 29),
                            secondaryButtonText: "Remove",
                            onSecondaryButtonPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${item['title']} removed from Wishlist",
                                  ),
                                ),
                              );
                            },
                            secondaryButtonWidth: ResponsiveUtils.getResponsiveWidth(context, 75),
                            secondaryButtonHeight: ResponsiveUtils.getResponsiveHeight(context, 29),
                            scalingFactor: scalingFactor, // Pass scaling factor
                          ),
                        );
                      },
                    ))
                        : (conceptsTabImages.isEmpty
                        ? Center(
                      child: Text(
                        "No concepts available",
                        style: TextFontStyle.textFontStyle(
                          isTablet ? 18 : ResponsiveUtils.getResponsiveFontSize(context, 14),
                          Colors.black,
                          FontWeight.w400,
                        ),
                      ),
                    )
                        : GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: conceptsTabImages.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 3 : 2,
                        mainAxisSpacing: isTablet ? 16 : ResponsiveUtils.getResponsiveHeight(context, 10),
                        crossAxisSpacing: isTablet ? 16 : ResponsiveUtils.getResponsiveWidth(context, 10),
                        childAspectRatio: isTablet ? 1.3 : 1.1,
                      ),
                      itemBuilder: (context, index) {
                        final item = conceptsTabImages[index];
                        return CustomImageCard(
                          imageUrl: item['imagePath'],
                          width: (MediaQuery.of(context).size.width -
                              (isTablet ? 64 : ResponsiveUtils.getResponsiveWidth(context, 28))) /
                              (isTablet ? 3 : 2),
                          height: isTablet ? 180 : ResponsiveUtils.getResponsiveHeight(context, 146),
                          isAsset: true,
                          favoriteSelected: item['isLiked'],
                          onFavoriteToggle: () {
                            setState(() {
                              item['isLiked'] = !item['isLiked'];
                            });
                          },
                        );
                      },
                    )),
                  ),
                ],
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