import 'package:aahwanam/blocs/mehndi/mehndi_bloc.dart';
import 'package:aahwanam/blocs/mehndi/mehndi_event.dart';
import 'package:aahwanam/blocs/mehndi/mehndi_state.dart';
import 'package:aahwanam/widgets/custom_card_mehndi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/mehandi_service/mehandi.dart';

import '../../widgets/custom_circle_widget.dart';
import '../../widgets/custom_date_time_bottom_sheet.dart';
import '../../widgets/custom_image_card_widget.dart';
import '../../widgets/custom_text_field.dart';

class MehndiScreen extends StatelessWidget {
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
        create: (context) => MehndiBloc()..add(FetchMehndi()),
        child: BlocBuilder<MehndiBloc, MehndiState>(
          builder: (context, state) {
            if (state is MehndiLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MehndiLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Reduced vertical padding
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomCircleWidget(
                        heading: "Mehndi Theme",
                        categories: state.mehndiTheme,
                        showViewAll: false,
                        onCategoryTap: (String categoryName) {
                          // Directly navigate to DecorationThemeScreen for all categories
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MehndiService(mehndiArtist: {},)),
                          );
                        },
                        onViewAll: (){},
                      ),

                      const SizedBox(height: 2),
                      // Decorators Section
                      CustomCardMehndiWidgets.buildSection(
                        context,
                        title: "Mehndi Artists",
                        data: state.mehndiArtists,
                        showViewAll: true,
                        onViewAll: () {
                          // Show first item or navigate to a full list page
                          if (state.mehndiArtists.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MehndiService( mehndiArtist:state.mehndiArtists[0]),
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
                            const Text(
                              "Trending Designs",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF575959),
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
                            itemCount: state.trendingMehndiDesigns.length,
                            itemBuilder: (context, index) {
                              final item = state.trendingMehndiDesigns[index];
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
            } else if (state is MehndiLoadedError) {
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
