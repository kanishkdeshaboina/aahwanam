
import 'package:aahwanam/blocs/chef/chef_bloc.dart';
import 'package:aahwanam/blocs/chef/chef_event.dart';
import 'package:aahwanam/blocs/chef/chef_state.dart';
import 'package:aahwanam/services/chef_service/chef_service.dart';
import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_card_chef.dart';
import '../../widgets/custom_card_widget.dart';
import '../../widgets/custom_circle_widget.dart';
import '../../widgets/custom_date_time_bottom_sheet.dart';

class ChefScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefBloc()..add(FetchChefs()),
      child: Scaffold(
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
        body: BlocBuilder<ChefBloc, ChefState>(
          builder: (context, state) {
            if (state is ChefLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChefLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Our Services Section
                      CustomCircleWidget(
                        heading: "Categories",
                        categories: state.categories,
                        showViewAll: false,

                        onCategoryTap: (String categoryName) {
                          // Directly navigate to DecorationThemeScreen for all categories
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChefService(chefs: {},)),
                          );
                        },
                      ),
                      const SizedBox(height: 2),

                      // Packages Section
                      CustomCardChefWidgets.buildSection(
                        context,
                        title: "Chefs for you",
                        data: state.chefs,
                        showViewAll: true,

                        onViewAll: () {
                          // Show first item or navigate to a full list page
                          if (state.chefs.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChefService(chefs: state.chefs[0]),
                              ),
                            );
                          }

                        },
                      ),


                    ],
                  ),
                ),
              );
            } else if (state is ChefError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Select a photographer"));
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
