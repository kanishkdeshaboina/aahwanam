import 'package:flutter_bloc/flutter_bloc.dart';
import 'chef_event.dart';
import 'chef_state.dart';

class ChefBloc extends Bloc<ChefEvent, ChefState> {
  ChefBloc() : super(ChefInitial()) {
    on<FetchChefs>((event, emit) async {
      emit(ChefLoading());
      try {
        await Future.delayed(Duration(seconds: 2));

        final categories = [
          {'name': 'Cuisines', 'image': 'assets/images/Cuisines.png'},
          {'name': 'Tiffins', 'image': 'assets/images/Tiffins.png'},
          {'name': 'Snacks', 'image': 'assets/images/Snacks.png'},
          {'name': 'Desserts', 'image': 'assets/images/Desserts.png'},
          {'name': 'Pizza', 'image': 'assets/images/Pizza.png'},
          {'name': 'Beverages', 'image': 'assets/images/Beverages.png'},
          {'name': 'Appetizers', 'image': 'assets/images/Appetizers.png'},
          {'name': 'Platters', 'image': 'assets/images/Platters.png'},
        ];

        final chefs = [
          {'image': 'assets/images/Ambika Caters.png', 'name': 'Ambika Cooking', 'price': '₹8,000 Onwards', 'rating': '4.7'},
          {'image': 'assets/images/Food Zone.png', 'name': 'Food Zone', 'price': '₹3,000 Onwards', 'rating': '4.7'},
          {'image': 'assets/images/Food Hut.png', 'name': 'Food Hut', 'price': '₹15,000 Onwards', 'rating': '4.7'},
          {'image': 'assets/images/Food Hut1.png', 'name': 'Food Hut', 'price': '₹15,000 Onwards', 'rating': '4.7'},
          {'image': 'assets/images/Taza Kitchen.png', 'name': 'Taza Kitchen', 'price': '₹4,000 Onwards', 'rating': '4.7'},
          {'image': 'assets/images/Taza Kitchen1.png', 'name': 'Taza Kitchen', 'price': '₹4,000 Onwards', 'rating': '4.7'},
        ];

        emit(ChefLoaded(categories, chefs));
      } catch (e) {
        emit(ChefError("Failed to load chef data"));
      }
    });

    on<SelectChefs>((event, emit) {
      print("Chef selected: ${event.chefId}");
    });

    on<LoadChefTabScreen>((event, emit) async {
      emit(ChefLoading());
      await Future.delayed(const Duration(milliseconds: 300));

      switch (event.index) {
        case 0:
          final chefThemes = [
            {'image': 'assets/images/Ambika Caters.png', 'price': '₹8000', 'type': 'theme'},
            {'image': 'assets/images/Food Hut.png', 'price': '₹15000', 'type': 'theme'},
            {'image': 'assets/images/Food Zone.png', 'price': '₹3000', 'type': 'theme'},
            {'image': 'assets/images/Taza Kitchen.png', 'price': '₹4000', 'type': 'theme'},
          ];
          emit(ChefThemesLoaded(chefThemes));
          break;



        case 1:
          final menuItems = [
            {
              'name': 'Cheese Potato balls',
              'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              'image': 'assets/images/cheesepotatoballs.png',
              'isVeg': true,
            },
            {
              'name': 'Cheese Potato balls',
              'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              'image': 'assets/images/cheesepotatoballs1.png',
              'isVeg': true,
            },
            {
              'name': 'Cheese Potato balls',
              'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              'image': 'assets/images/cheesepotatoballs2.png',
              'isVeg': true,
            },
          ];
          emit(ChefMenuLoaded(menuItems));
          break;
        case 2:
          final galleryImages = [
            'assets/images/Kitty-party3.png',
            'assets/images/Kitty party EE.png',
            'assets/images/Kitty-party2.png',
            'assets/images/Kitty-party3.png',
            'assets/images/Get-Together1.png',
            'assets/images/Get-Together2.png',
            'assets/images/Get-Together3.png',
            'assets/images/Get-Together1.png',
            'assets/images/birthday_decor.png',
            'assets/images/Birthday event.png',
            'assets/images/birthdayGallery1.png',
            'assets/images/birthdayGallery2.png',

          ];

          emit(ChefGalleryLoaded(galleryImages: galleryImages));
          break;
        case 3:
          final photos = [
            'assets/images/Food Hut.png',
            'assets/images/Food Hut1.png',
            'assets/images/Food Zone.png',
            'assets/images/Pizza.png',
          ];
          final ratingData = {5: 60, 4: 25, 3: 10, 2: 3, 1: 2};
          emit(ChefReviewLoaded(photos: photos, ratingData: ratingData));
          break;

        default:
          emit(ChefError("Invalid tab selected"));
      }
    });
  }
}
