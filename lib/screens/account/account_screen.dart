import 'dart:io';
import 'package:aahwanam/blocs/account/account_bloc.dart';
import 'package:aahwanam/blocs/account/account_event.dart';
import 'package:aahwanam/blocs/account/account_state.dart';
import 'package:aahwanam/screens/account/mypackages_screen.dart';
import 'package:aahwanam/screens/account/profile_screen.dart';
import 'package:aahwanam/screens/account/booking_screen.dart';
import 'package:aahwanam/screens/account/wishlist_screen.dart';
import 'package:aahwanam/widgets/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/custom_text_field.dart';
import '../auth/home_screen.dart';
import '../dashboard/dashboard_screen.dart';
import 'cart_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

Widget _supportSectionTitle(String title) {
  return Text(
    title,
    style: TextFontStyle.textFontStyle(
        16, const Color(0xFF1E535B), FontWeight.w500),
  );
}

class _AccountScreenState extends State<AccountScreen> {
  File? _profileImage;
  final picker = ImagePicker();

  /// Pick profile image
  Future<void> _pickProfileImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  /// Show image picker options
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.black87),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickProfileImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading:
                const Icon(Icons.photo_library, color: Colors.black87),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickProfileImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// ✅ Show confirmation dialog before logout
  void _showLogoutConfirmationDialog() {
    final size = MediaQuery.of(context).size;
    final textScale = size.width / 390; // Reference width: iPhone 12

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Dialog(
          backgroundColor: const Color(0xFFF4F6FB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.height * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are you sure you want to\nlogout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16 * textScale,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color(0xFF78A3EB), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.015,
                          ),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14 * textScale,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF78A3EB),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          _logoutUser();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF78A3EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.015,
                          ),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 14 * textScale,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Handle actual logout and redirect
  void _logoutUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()), // ✅ go to main home
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountBloc()..add(LoadAccountInfo()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            'Account Information',
            style: TextFontStyle.textFontStyle(
              16,
              const Color(0xFF575959),
              FontWeight.w600,
            ),
          ),
          leading: IconButton(
            padding: const EdgeInsets.only(top: 2, left: 10),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Color(0xFF575959),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
          ),
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                children: [
                  Card(
                    color: const Color(0xFF1E535B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 85,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : AssetImage(state.profileUrl)
                                  as ImageProvider,
                                ),
                                Positioned(
                                  bottom: -0.8,
                                  right: 6,
                                  child: GestureDetector(
                                    onTap: _showImagePickerOptions,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF1E535B),
                                            Colors.pinkAccent,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 7,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${state.firstName} ${state.lastName}',
                                  style: TextFontStyle.textFontStyle(
                                      16, Colors.white, FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.email,
                                  style: TextFontStyle.textFontStyle(
                                      14,
                                      const Color(0xFFE4E4E4),
                                      FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your Information",
                    style: TextFontStyle.textFontStyle(
                        14, const Color(0xFF575959), FontWeight.w600),
                  ),
                  CustomTile(
                    imagePath: 'assets/images/profileimage.png',
                    title: 'Profile',
                    bgColor: const Color(0xFFE3FDEE),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<AccountBloc>(context),
                              child: const ProfileScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  CustomTile(
                    imagePath: 'assets/images/booking1.png',
                    title: 'Bookings',
                    bgColor: const Color(0xFFDFE3FF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<AccountBloc>(context),
                              child: BookingScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  CustomTile(
                    imagePath: 'assets/images/cart1.png',
                    title: 'Cart',
                    bgColor: const Color(0xFFDFF4FF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<AccountBloc>(context),
                              child: const CartScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  CustomTile(
                    imagePath: 'assets/images/wishlist1.png',
                    title: 'Wishlist',
                    bgColor: const Color(0xFFFFECEC),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<AccountBloc>(context),
                              child: const WishlistScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  CustomTile(
                    imagePath: 'assets/images/mypackages1.png',
                    title: 'My Packages',
                    bgColor: const Color(0xFFE9FFE2),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<AccountBloc>(context),
                              child: const MyPackagesScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Others",
                    style: TextFontStyle.textFontStyle(
                      14,
                      const Color(0xFF575959),
                      FontWeight.w500,
                    ),
                  ),
                  CustomTile(
                    imagePath: 'assets/images/refer people1.png',
                    title: 'Refer People',
                    bgColor: const Color(0xFFFFE8FB),
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  _supportSectionTitle('Aahwanam Support*'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E535B),
                          shape: BoxShape.circle,
                        ),
                        child:
                        const Icon(Icons.call, color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '3659252957',
                        style: TextFontStyle.textFontStyle(
                            16, const Color(0xFF575959), FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: const EdgeInsets.only(left: 10, top: 68, right: 10),
                    child: OutlinedButton(
                      onPressed: _showLogoutConfirmationDialog,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF1E535B)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        "Logout",
                        style: TextFontStyle.textFontStyle(
                          14,
                          const Color(0xFF1E535B),
                          FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is AccountError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
