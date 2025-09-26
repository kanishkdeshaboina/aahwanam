import 'package:aahwanam/screens/dashboard/photo_gallery.dart';
import 'package:aahwanam/screens/dashboard/reviewList.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/PackageDetail/package_detail_bloc.dart';
import '../../blocs/PackageDetail/package_detail_event.dart';
import '../../blocs/PackageDetail/package_detail_state.dart';
import '../../routes/app_routes.dart';
import '../../widgets/book_service_screen.dart';
import '../../widgets/custom_ChangeAddressSheet.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/custom_date_time_bottom_sheet.dart';
import '../../widgets/custom_event_date_time_picker.dart';
import '../../widgets/custom_inputfield.dart';
import '../../widgets/custom_text_field.dart';


class PackageDetailScreen extends StatelessWidget {
  final Map<String, dynamic> package;
  const PackageDetailScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PackageDetailBloc()..add(LoadPackageDetail(package)),
      child: BlocBuilder<PackageDetailBloc, PackageDetailState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: 56,
                titleSpacing: 0,
                leadingWidth: 0,
                backgroundColor: Colors.white,
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
                        child: SizedBox(
                          height: 40,
                          child: _buildSearchBar(), // 🔍 your search bar widget
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),

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
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0), // 👈 space between row and TabBar
                    child: TabBar(
                      indicatorColor: Colors.teal,
                      dividerColor: Colors.transparent,
                      labelColor: Color(0xFF575959),
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextFontStyle.textFontStyle(
                        16,
                        const Color(0xFF575959),
                        FontWeight.w600,
                      ),
                      tabs: const [
                        Tab(text: "All Details"),
                        Tab(text: "Gallery"),
                        Tab(text: "Reviews"),
                      ],
                    ),
                  ),
                ),

              ),
              body: TabBarView(
                children: [
                  _buildDetailsTab(state),
                  PhotoGallery(photoGallery: package["photo_gallery"]),
                  ReviewList(
                      reviews: package["reviews"], galleryImages: state.gallery),
                ],
              ),
              bottomNavigationBar: BottomActionBar(
                onAddToCart: () {
                  // Handle add to cart
                },
                onBookService: (BuildContext context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookServiceScreen(package: package)),
                  );
                },
              ),
            ),
          );



        },
      ),
    );

  }

  Widget _buildDetailsTab(PackageDetailState state) {
    return Container(
      color: Colors.white,
    child: SingleChildScrollView(

      padding: const EdgeInsets.fromLTRB(19, 16, 26, 5),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "About ${state.package?['title']}",
                style:
                  TextFontStyle.textFontStyle( 15, Color(0xFF575959),FontWeight.w500)
              ),
              Text(
                "₹${state.package?['price']}",
                style:
                  TextFontStyle.textFontStyle( 15, Colors.teal,FontWeight.w600)
              ),
            ],
          ),
           const SizedBox(height: 8),
          Text(
            state.package?['description'],
            style:
              TextFontStyle.textFontStyle( 13, Color(0xFF575959),FontWeight.w400)
          ),
          const SizedBox(height: 16),
          Text(
            "Included in this Package are:",
            style:
              TextFontStyle.textFontStyle( 15,Color(0xFF575959),FontWeight.w500)
          ),
          const SizedBox(height: 6),
          ...((package["included"] as List<String>)
              .map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0,left:8.0),
            child: Text("• $item",
                style:
                TextFontStyle.textFontStyle( 13, Color(0xFF575959),FontWeight.w400)),

          )).toList()),
          // const SizedBox(height: 20),
          // const Divider(),
          // const SizedBox(height: 10),
          // const Text(
          //   "Details & Requirements",
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins'),
          // ),
         Column(
          children: [
            const SizedBox(height: 30), // Push it down

            Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFFE4E4E4)
                  , // Light grey color
                ),
              ),
              const SizedBox(width: 10),

              Text(
                "Details & Requirements",
                style:
                  TextFontStyle.textFontStyle( 18, Color(0xFF575959),FontWeight.w500)
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFFE4E4E4),
                ),
              ),
            ],
          ),
         ],
         ),
          const SizedBox(height: 20),

          // const SizedBox(height: 15),
          EventDateTimePicker(),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  labelText: 'No. of Guests*',
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomInputField(
                  labelText: 'No. of Bartenders*',

                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomChangeAddressSheet(),
          const SizedBox(height: 20),
        ],
      ),

    ),
    );
  }
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
