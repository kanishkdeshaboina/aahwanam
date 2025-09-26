import 'package:aahwanam/models/service_details.dart';

import 'package:flutter/material.dart';

import 'custom_event_date_time_picker.dart';
import 'custom_text_field.dart';

class ServiceOverviewTab extends StatelessWidget {
  final String heading;
  final String packagePrice;
  final String description;
  final String subHeading;
  final String subHeadingDetails;
  final String eventTitle;
  final String address;
  final String addressDescription;
  final VoidCallback onChangeAddress;
  final String? label1;
  final String? label2;
  final String? initialValue1;
  final String? initialValue2;

  const ServiceOverviewTab({
    Key? key,
    required this.heading,
    required this.packagePrice,
    required this.description,
    required this.subHeading,
    required this.subHeadingDetails,
    required this.eventTitle,
    required this.address,
    required this.addressDescription,
    required this.onChangeAddress,
    this.label1,
    this.label2,
    this.initialValue1,
    this.initialValue2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16,left:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                heading,
                style: TextFontStyle.textFontStyle(
                  14,
                  const Color(0xFF575959),
                  FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  packagePrice,
                  style: TextFontStyle.textFontStyle(
                    14,
                    const Color(0xFF1E535B),
                    FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(
            description,
            style: TextFontStyle.textFontStyle(
              12,
              const Color(0xFF757575),
              FontWeight.w400,
            ),
          ),

          const SizedBox(height: 10),
          Text(
            subHeading,
            style: TextFontStyle.textFontStyle(
              14,
              const Color(0xFF575959),
              FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subHeadingDetails,
            style: TextFontStyle.textFontStyle(
              12,
              const Color(0xFF757575),
              FontWeight.w400,
            ),
          ),

          const SizedBox(height: 8),

          // Event Details Centered Title
          Row(
            children: [
              const Expanded(
                  child: Divider(color: Color(0xFFE4E4E4), thickness: 0.5)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  eventTitle,
                  style: TextFontStyle.textFontStyle(
                    16,
                    const Color(0xFF575959),
                    FontWeight.w600,
                  ),
                ),
              ),
              const Expanded(
                  child: Divider(color: Color(0xFFE4E4E4), thickness: 0.5)),
            ],
          ),

          const SizedBox(height: 16),
          const EventDateTimePicker(),
          const SizedBox(height: 16),
          // Dynamic Input Fields

          if (label1 != null && label2 != null) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label1!,
                        style:   TextFontStyle.textFontStyle(
                          12,
                          const Color(0xFF575959),
                          FontWeight.w500,
                        ),

                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: initialValue1 ?? '',
                        cursorColor:
                        Color(0xFF1E535B), // Set your desired cursor color
                        decoration: InputDecoration(
                          hintText: 'Enter $label1',
                          hintStyle: TextFontStyle.textFontStyle(
                            12,
                            const Color(0xFF757575),
                            FontWeight.w500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(
                                    0xFFE4E4E4)), // Border color when NOT focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF1E535B),
                                width: 1.5), // Custom focus color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label2!,
                        style:   TextFontStyle.textFontStyle(
                          12,
                          const Color(0xFF575959),
                          FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: initialValue2 ?? '',
                        cursorColor:
                        Color(0xFF1E535B), // Set your desired cursor color
                        decoration: InputDecoration(
                          hintText: 'Enter $label2',
                          hintStyle: TextFontStyle.textFontStyle(
                            12,
                            const Color(0xFF757575),
                            FontWeight.w500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(
                                    0xFFE4E4E4)), // Border color when NOT focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF1E535B),
                                width: 1.5), // Custom focus color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          const SizedBox(height: 16),
          if (label1 != null && label2 != null) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label1!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF575959)),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: initialValue1 ?? '',
                        cursorColor:
                        Color(0xFF1E535B), // Set your desired cursor color
                        decoration: InputDecoration(
                          hintText: 'Enter $label1',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF757575),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(
                                    0xFFE4E4E4)), // Border color when NOT focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF1E535B),
                                width: 1.5), // Custom focus color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label2!,
                        style: TextFontStyle.textFontStyle(
                          12,
                          const Color(0xFF575959),
                          FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: initialValue2 ?? '',
                        cursorColor:
                        Color(0xFF1E535B), // Set your desired cursor color
                        decoration: InputDecoration(
                          hintText: 'Enter $label2',
                          hintStyle: TextFontStyle.textFontStyle(
                            12,
                            const Color(0xFF757575),
                            FontWeight.w500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(
                                    0xFFE4E4E4)), // Border color when NOT focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF1E535B),
                                width: 1.5), // Custom focus color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No. Of Vehicles *",
                      style: TextFontStyle.textFontStyle(
                        12,
                        const Color(0xFF575959),
                        FontWeight.w500,
                      ),

                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: initialValue1 ?? '',
                      cursorColor: Color(0xFF1E535B),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF757575),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          const BorderSide(color: Color(0xFFE4E4E4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF1E535B), width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No. Of Associates",
                      style: TextFontStyle.textFontStyle(
                        12,
                        const Color(0xFF575959),
                        FontWeight.w500,
                      ),


                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: initialValue2 ?? '',
                      cursorColor: Color(0xFF1E535B),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF757575),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          const BorderSide(color: Color(0xFFE4E4E4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF1E535B), width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Address Section
          const Text('Event Address*',

              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF575959))),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E4E4)),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(address,
                        style: TextFontStyle.textFontStyle(
                          14,
                          const Color(0xFF575959),
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: onChangeAddress,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF1E535B),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: const BorderSide(
                                color: Color(0xFF1E535B), width: 1),
                          ),
                          padding: const EdgeInsets.all(6),
                          minimumSize: const Size(0, 0),
                        ),
                        child:  Text("Change",
                          style: TextFontStyle.textFontStyle(
                            10,
                            const Color(0xFF575959),
                            FontWeight.w500,
                          ),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(addressDescription,
                  style: TextFontStyle.textFontStyle(
                    12,
                    const Color(0xFF757575),
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
