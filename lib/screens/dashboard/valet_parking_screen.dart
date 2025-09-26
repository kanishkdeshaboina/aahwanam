import 'package:aahwanam/blocs/valetParking/valetParking_bloc.dart';
import 'package:aahwanam/blocs/valetParking/valetParking_event.dart';
import 'package:aahwanam/blocs/valetParking/valetParking_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/valet_parking/valet_parking_service.dart';
import '../../widgets/custom_date_time_bottom_sheet.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/package_card.dart';

class ValetParkingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValetParkingBloc()..add(FetchValetParking()),
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
                icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF1E535B)),
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
        body: BlocBuilder<ValetParkingBloc, ValetParkingState>(
          builder: (context, state) {
            if (state is ValetParkingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ValetParkingLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Our Services Section

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Packages",
                            style: TextFontStyle.textFontStyle(16, const Color(0xFF575959), FontWeight.w600), // smaller text

                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ValetParkingServiceScreen()),
                              );
                            },
                            child:  Text(
                              "View All",
                              style: TextFontStyle.textFontStyle(14, const Color(0xFF1E535B), FontWeight.w400), // smaller text

                            ),
                          ),



                        ],
                      ),
                      const SizedBox(height: 10),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.Packages.length,
                        itemBuilder: (context, index) {
                          final package = state.Packages[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ValetParkingServiceScreen(

                                    ),
                                  ),
                                );
                              },
                              child: PackageCard(
                                title: package['title'],
                                description: package['description'],
                                price: package['price'],
                                details: package['details'],
                                imagePath: package['imagePath'],
                                rating: package['rating'],
                              ),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
              );
            } else if (state is ValetParkingError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Select a valet"));
          },
        ),
      ),
    );
  }
}
Widget _buildSearchBar() {
  return TextField(
    style: TextFontStyle.textFontStyle(14, const Color(0xFF575959), FontWeight.w400), // smaller text
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
void _navigateTo(BuildContext context, String section) {
  // Navigation logic
  Navigator.pushNamed(context, '/$section');
}
