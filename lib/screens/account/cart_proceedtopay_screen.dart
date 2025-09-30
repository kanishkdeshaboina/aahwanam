import 'package:aahwanam/blocs/account/account_bloc.dart';
import 'package:aahwanam/blocs/account/account_event.dart';
import 'package:aahwanam/blocs/account/account_state.dart';
import 'package:aahwanam/routes/app_routes.dart';
import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../services/proceedpay.dart';
import '../../utils/responsive_utils.dart';

class CartProceedToPayScreen extends StatelessWidget {

  final Map<String, dynamic>? booking;
  final DateTime selectedDateTime;
  final String? imagePath;
  final String? price;
  final int? count;

  const CartProceedToPayScreen({
    super.key,
    this.imagePath,
    this.price,
    this.count,
    this.booking,
    required this.selectedDateTime,
  });

  @override
  Widget build(BuildContext context) {
    double parseFee(dynamic fee) {
      if (fee == null) return 0.0;
      if (fee is num) return fee.toDouble();
      if (fee is String) {
        if (fee.toLowerCase() == 'free' || fee
            .trim()
            .isEmpty) {
          return 0.0;
        }
        return double.tryParse(fee.replaceAll(',', '').trim()) ?? 0.0;
      }
      return 0.0;
    }

    return BlocProvider(
      create: (context) =>
      AccountBloc()
        ..add(LoadAccountInfo()),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Book Service",
            style: TextFontStyle.textFontStyle(
              ResponsiveUtils.getResponsiveFontSize(context, 16),
              const Color(0xFF575959),
              FontWeight.w500,
            ),
          ),
          leading: IconButton(
            padding: EdgeInsets.only(
              top: ResponsiveUtils.getResponsiveHeight(context, 2),
              left: ResponsiveUtils.getResponsiveWidth(context, 12),
            ),
            icon: Icon(
              Icons.arrow_back_ios,
              size: ResponsiveUtils.getResponsiveFontSize(context, 18),
              color: const Color(0xFF575959),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getResponsiveWidth(context, 20),
            vertical: ResponsiveUtils.getResponsiveHeight(context, 40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.bookPhotographService);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E535B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.getResponsiveWidth(context, 45),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentOptionsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E535B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.getResponsiveWidth(
                          context, 10),
                      vertical: ResponsiveUtils.getResponsiveHeight(context, 0),
                    ),
                  ),
                  child: Text(
                    "Proceed to pay",
                    style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 14),
                      const Color(0xFFFFFDFC),
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        backgroundColor: Colors.white,
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              final serviceChargeNum = parseFee(booking?['price']);
              final platformFeeNum = parseFee(
                  state.bookServiceDetails.platformFee);
              final transportFeeNum = parseFee(
                  state.bookServiceDetails.transportFee);

              final totalAmountNum = serviceChargeNum + platformFeeNum +
                  transportFeeNum;
              final totalAmountStr = '₹${totalAmountNum.toStringAsFixed(2)}';

              return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(
                        ResponsiveUtils.getResponsiveWidth(context, 16)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// Package card (image + title + price)
                        Container(
                          padding: ResponsiveUtils.getResponsivePadding(
                              context, all: 12),
                          margin: EdgeInsets.symmetric(
                              vertical: ResponsiveUtils.getResponsiveHeight(
                                  context, 8)
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF2E4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  booking?['imagePath'] ??
                                      'assets/images/Choreographers.png',
                                  height: ResponsiveUtils.getResponsiveHeight(
                                      context, 110),
                                  width: ResponsiveUtils.getResponsiveWidth(
                                      context, 90),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                  width: ResponsiveUtils.getResponsiveWidth(
                                      context, 12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking?['title'] ?? 'No Title',
                                      style: TextFontStyle.textFontStyle(
                                          ResponsiveUtils.getResponsiveFontSize(
                                              context, 13),
                                          const Color(0xFF575959),
                                          FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveUtils
                                        .getResponsiveHeight(context, 4)),
                                    Text(
                                      booking?['description'] ??
                                          'No Description',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextFontStyle.textFontStyle(
                                          ResponsiveUtils.getResponsiveFontSize(
                                              context, 12),
                                          const Color(0xFF757575),
                                          FontWeight.w300
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveUtils
                                        .getResponsiveHeight(context, 6)),
                                    Text(
                                      '₹ ${booking?['price'] ??
                                          '0'}${(booking?['isPerSession'] ??
                                          false) ? ' / Session' : ''}',
                                      style: TextFontStyle.textFontStyle(
                                          ResponsiveUtils.getResponsiveFontSize(
                                              context, 14),
                                          const Color(0xFF1E535B),
                                          FontWeight.w600
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveUtils
                                        .getResponsiveHeight(context, 6)),
                                    Text(
                                      '${DateFormat('dd, MMM yyyy').format(
                                          selectedDateTime)} (${DateFormat
                                          .jm()
                                          .format(selectedDateTime)})',
                                      style: TextFontStyle.textFontStyle(
                                          ResponsiveUtils.getResponsiveFontSize(
                                              context, 13),
                                          const Color(0xFF575959),
                                          FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                            context, 16)),

                        /// Event Address Section
                        Text('Event Address*',
                          style: TextFontStyle.textFontStyle(
                              ResponsiveUtils.getResponsiveFontSize(
                                  context, 14),
                              const Color(0xFF575959),
                              FontWeight.w500
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                            context, 10)),
                        Container(
                          padding: EdgeInsets.all(
                              ResponsiveUtils.getResponsiveWidth(context, 10)
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE4E4E4)),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.bookServiceDetails.locationTitle,
                                      style: TextFontStyle.textFontStyle(
                                        ResponsiveUtils.getResponsiveFontSize(
                                            context, 14),
                                        const Color(0xFF575959),
                                        FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: ResponsiveUtils.getResponsiveWidth(
                                          context, 10)),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _showChangeAddress(context),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF1E535B),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0),
                                        side: const BorderSide(
                                            color: Color(0xFF1E535B), width: 1),
                                      ),
                                      padding: EdgeInsets.all(
                                          ResponsiveUtils.getResponsiveWidth(
                                              context, 6)
                                      ),
                                      minimumSize: const Size(0, 0),
                                    ),
                                    child: Text("Change",
                                      style: TextFontStyle.textFontStyle(
                                        ResponsiveUtils.getResponsiveFontSize(
                                            context, 10),
                                        const Color(0xFF1E535B),
                                        FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsiveHeight(
                                      context, 8)),
                              Text(state.bookServiceDetails.locationDescription,
                                style: TextFontStyle.textFontStyle(
                                    ResponsiveUtils.getResponsiveFontSize(
                                        context, 12),
                                    const Color(0xFF757575),
                                    FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                            context, 16)),

                        /// Billing section
                        Row(
                          children: [
                            Expanded(child: Divider(
                                color: const Color(0xFFF1F1F1), thickness: 1)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils
                                      .getResponsiveWidth(context, 8)
                              ),
                              child: Text("Bill Details",
                                style: TextFontStyle.textFontStyle(
                                    ResponsiveUtils.getResponsiveFontSize(
                                        context, 14),
                                    const Color(0xFF575959),
                                    FontWeight.w600
                                ),
                              ),
                            ),
                            Expanded(child: Divider(
                                color: const Color(0xFFF1F1F1), thickness: 1)),
                          ],
                        ),
                        SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                            context, 16)),
                        _buildChargeRow('Service Charges', booking?['price']),
                        SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                            context, 8)),
                        _buildChargeRow('Platform Fee',
                            state.bookServiceDetails.platformFee),
                        SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                            context, 8)),
                        _buildChargeRow('Transport Fee',
                            state.bookServiceDetails.transportFee,
                            valueColor: const Color(0xFF1E535B)),
                        SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                            context, 8)),
                        _buildChargeRow('Total', totalAmountStr, isBold: true),
                      ],
                    ),
                  )
              );
            } else if (state is AccountError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Select a photographer"));
          },
        ),
      ),
    );
  }

  Widget _buildChargeRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                color: const Color(0xFF575959),
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
                color: valueColor ?? const Color(0xFF757575),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        );
      },
    );
  }

  void _showChangeAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.5,
          padding: EdgeInsets.all(
              ResponsiveUtils.getResponsiveWidth(context, 16)
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Address',
                  style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 18),
                      const Color(0xFF575959),
                      FontWeight.w600
                  ),
                ),
                SizedBox(
                    height: ResponsiveUtils.getResponsiveHeight(context, 16)),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showAddNewAddress(context);
                    },
                    icon: Icon(
                      Icons.add,
                      color: const Color(0xFF1E535B),
                      size: ResponsiveUtils.getResponsiveFontSize(context, 18),
                    ),
                    label: Text(
                      'Add New Address',
                      style: TextStyle(
                        color: const Color(0xFF1E535B),
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context, 14),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      side: const BorderSide(color: Color(0xFF1E535B)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.getResponsiveHeight(
                            context, 14),
                        horizontal: ResponsiveUtils.getResponsiveWidth(
                            context, 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: ResponsiveUtils.getResponsiveHeight(context, 24)),
                Text(
                  'Your saved address',
                  style: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 15),
                      const Color(0xFF575959),
                      FontWeight.w500
                  ),
                ),
                SizedBox(
                    height: ResponsiveUtils.getResponsiveHeight(context, 16)),

                /// Address Tiles
                _addressTile(
                  title: 'Financial District',
                  subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
                ),
                SizedBox(
                    height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                _addressTile(
                  title: 'Madhapur',
                  subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
                ),
                SizedBox(
                    height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                _addressTile(
                  title: 'Hitech City',
                  subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
                ),
                SizedBox(
                    height: ResponsiveUtils.getResponsiveHeight(context, 20)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _addressTile({required String title, required String subtitle}) {
    return Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(
                ResponsiveUtils.getResponsiveWidth(context, 12)
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7F1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextFontStyle.textFontStyle(
                            ResponsiveUtils.getResponsiveFontSize(context, 14),
                            const Color(0xFF575959),
                            FontWeight.w500
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveHeight(
                          context, 4)),
                      Text(
                        subtitle,
                        style: TextFontStyle.textFontStyle(
                            ResponsiveUtils.getResponsiveFontSize(context, 13),
                            const Color(0xFF757575),
                            FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(
                        ResponsiveUtils.getResponsiveWidth(context, 45),
                        ResponsiveUtils.getResponsiveHeight(context, 30)
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.getResponsiveWidth(
                          context, 10),
                      vertical: ResponsiveUtils.getResponsiveHeight(context, 0),
                    ),
                    side: const BorderSide(color: Color(0xFF1E535B)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: TextFontStyle.textFontStyle(
                        ResponsiveUtils.getResponsiveFontSize(context, 13),
                        const Color(0xFF1E535B),
                        FontWeight.w400
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  void _showAddNewAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(
              ResponsiveUtils.getResponsiveWidth(context, 16)
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Address',
                    style: TextFontStyle.textFontStyle(
                        ResponsiveUtils.getResponsiveFontSize(context, 18),
                        const Color(0xFF575959),
                        FontWeight.w500
                    ),
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 16)),
                  _buildTextField(
                    hintText: 'Enter your Flat / House no / Building name ',
                    label: 'Flat / House no / Building name *',
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                  _buildTextField(
                    hintText: 'Floor (Optional)',
                    label: 'Floor',
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                  _buildTextField(
                    hintText: 'Enter your area / sector / locality',
                    label: 'Area / Sector / Locality *',
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                  _buildTextField(
                    hintText: 'Enter landmark',
                    label: 'Landmark',
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 24)),
                  Text(
                    'Enter your details for seamless experience',
                    style: TextFontStyle.textFontStyle(
                        ResponsiveUtils.getResponsiveFontSize(context, 14),
                        const Color(0xFF757575),
                        FontWeight.w400
                    ),
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 16)),
                  _buildTextField(
                    hintText: 'Enter your name',
                    label: 'Name *',
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 12)),
                  _buildTextField(
                    hintText: 'Enter your mobile number',
                    label: 'Phone Number',
                    keyboardType: TextInputType.number,
                    isNumberField: true,
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 24)),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Future.delayed(const Duration(milliseconds: 20), () {
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E535B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.getResponsiveWidth(
                              context, 40),
                          vertical: ResponsiveUtils.getResponsiveHeight(
                              context, 14),
                        ),
                        minimumSize: const Size(0, 0),
                      ),
                      child: Text(
                        'Save Address',
                        style: TextFontStyle.textFontStyle(
                            ResponsiveUtils.getResponsiveFontSize(context, 16),
                            Colors.white,
                            FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveHeight(context, 10)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Common textfield builder
  Widget _buildTextField({
    required String hintText,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool isNumberField = false,
  }) {
    return Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextFontStyle.textFontStyle(
                    ResponsiveUtils.getResponsiveFontSize(context, 14),
                    const Color(0xFF575959),
                    FontWeight.w400
                ),
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveHeight(context, 6)),
              TextField(
                keyboardType: keyboardType,
                inputFormatters: isNumberField
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : null,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextFontStyle.textFontStyle(
                      ResponsiveUtils.getResponsiveFontSize(context, 14),
                      const Color(0xFF757575),
                      FontWeight.w300
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.getResponsiveWidth(context, 12),
                    vertical: ResponsiveUtils.getResponsiveHeight(context, 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}