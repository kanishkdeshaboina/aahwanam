import 'package:aahwanam/blocs/chef/chef_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/chef/chef_state.dart';
import '../../widgets/custom_text_field.dart';





class ChefGalleryImageList extends StatelessWidget {
  const ChefGalleryImageList({super.key});

  Widget _buildImageRow(String title, List<String> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            title,
            style:  TextFontStyle.textFontStyle(
              14,
              Color(0xFF575959),
              FontWeight.w600,
            ),


          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                width: 108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChefBloc,ChefState>(
      builder: (context, state) {
        List<String> galleryImages = [];

        if (state is ChefGalleryLoaded) {
          galleryImages = state.galleryImages;
        }

        // Split images into 3 groups
        final chefs = galleryImages.take(4).toList();       // 0-3
        final anniversaryImages = galleryImages.skip(4).take(4).toList(); // 4-6
        final poojaImages = galleryImages.skip(8).take(4).toList();       // 7-10

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildImageRow('Kitty Party ', chefs),
              _buildImageRow('Get Together', anniversaryImages),
              _buildImageRow('Birthday Party', poojaImages),
            ],
          ),
        );
      },
    );
  }
}
