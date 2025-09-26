import 'package:aahwanam/blocs/makeup/makeup_bloc.dart';
import 'package:aahwanam/blocs/makeup/makeup_event.dart';
import 'package:aahwanam/blocs/makeup/makeup_state.dart';
import 'package:aahwanam/services/makeup_hair_service/makeup_hair_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_card_makup.dart';
import '../../widgets/custom_card_widget.dart';
import '../../widgets/custom_circle_widget.dart';
import '../../widgets/custom_date_time_bottom_sheet.dart';
import '../../widgets/custom_image_card_widget.dart';
import '../../widgets/custom_text_field.dart';

class MakeupScreen extends StatelessWidget {

  const MakeupScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
              padding: const EdgeInsets.only(left: 4),
              splashRadius: 20,
              constraints: const BoxConstraints(),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 40,
                width:190,
                child: _buildSearchBar(),
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
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                      Icon(Icons.calendar_today, size: 20, color: Color(0xFF004d40)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(Icons.access_time, size: 10, color: Color(0xFF004d40)),
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

      body: BlocProvider(
        create: (context) => MakeupBloc()..add(FetchMakeup()),
        child: BlocBuilder<MakeupBloc, MakeupState>(
          builder: (context, state) {
            if (state is MakeupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MakeupLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Reduced vertical padding
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomCircleWidget(
                        heading: "Makeup Look",
                        categories: state.makeUpLook,
                        showViewAll: true,

                        onCategoryTap: (String categoryName) {
                          // Directly navigate to DecorationThemeScreen for all categories
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MakeupHairService(makeupAndHairArtist: {},)),
                          );
                        },

                      ),


                      const SizedBox(height: 2),

                      CustomCircleWidget(
                        heading: "Hair Style Look",
                        categories: state.hairStyleLook,
                        showViewAll: true,
                        onCategoryTap: (String categoryName) {
                          // Map category names to route names
                          final Map<String, String> categoryRoutes = {
                            // Add more categories and routes here
                          };

                          final routeName = categoryRoutes[categoryName];
                          if (routeName != null) {
                            Navigator.pushNamed(context, routeName);
                          } else {
                            // Handle cases where a route is not mapped
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('No route available for $categoryName')),
                            );
                          }
                        },
                        onViewAll: () {},

                      ),


                      const SizedBox(height: 2),
                      // Decorators Section
                      CustomCardMakeUpWidgets.buildSection(
                        context,
                        title: "Makeup & Hair Artists",
                        data: state.makeupAndHairArtists,
                        showViewAll: true,

                        onViewAll: () {
                          // Show first item or navigate to a full list page
                          if (state.makeupAndHairArtists.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MakeupHairService(makeupAndHairArtist: state.makeupAndHairArtists[0]),
                              ),
                            );
                          }

                        },
                      ),


                      // Trending Section
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0), // No left padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Trending Looks",
                              style: TextFontStyle.textFontStyle(16, const Color(0xFF575959), FontWeight.w600),


                            ),
                            TextButton(
                              onPressed: () => _navigateTo(context, "Trending"),
                              child:  Text(
                                "View All",
                                style: TextFontStyle.textFontStyle(12, const Color(0xFF1E535B), FontWeight.w400),


                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.trendingLooks.length,
                            itemBuilder: (context, index) {
                              final item = state.trendingLooks[index];
                              return CustomImageCard(
                                imageUrl: item['image']!,
                                isAsset: item['image']!.startsWith('assets/'),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
              );
            } else if (state is MakeupError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Welcome to Dashboard!'));
          },
        ),
      ),
    );
  }
}
Widget _buildSearchBar() {
  return SizedBox(
    height: 40,
    width: 200,
    child: TextField(
      style: TextFontStyle.textFontStyle(
        14,
        const Color(0xFF575959),
        FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: 'Search here...',
        // Padding applied only to the left of the icon
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10), // 5 px from left edge
          child: const Icon(Icons.search, size: 20, color: Color(0xFF575959)),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 25,
          minHeight: 20,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0), // text padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
void _navigateTo(BuildContext context, String section) {
  // Navigation logic
  Navigator.pushNamed(context, '/$section');
}
