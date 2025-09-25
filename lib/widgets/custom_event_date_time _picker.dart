import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDateTimePicker extends StatefulWidget {
  const EventDateTimePicker({Key? key, String? label}) : super(key: key);

  @override
  _EventDateTimePickerState createState() => _EventDateTimePickerState();
}

class _EventDateTimePickerState extends State<EventDateTimePicker> {
  DateTime? selectedDate;
  DateTime? selectedTime; // Add this line

  DateTime currentMonth = DateTime.now();

  List<DateTime> _getDaysInMonth(DateTime month) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);

    // Adjust weekday so that Monday = 0, Sunday = 6
    int weekdayOffset = (firstDayOfMonth.weekday + 6) % 7;

    List<DateTime> days = List.generate(daysInMonth, (index) {
      return DateTime(month.year, month.month, index + 1);
    });

    // Add empty dates for alignment
    return List<DateTime>.filled(weekdayOffset, DateTime(0)) + days;
  }

  void _showCustomDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Select Event Date",
                      style: TextFontStyle.textFontStyle(
                        14,
                        const Color(0xFF333333),
                        FontWeight.w500 ,
                      ),

                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('MMMM yyyy',
                            Localizations.localeOf(context).toString())
                            .format(currentMonth),
                        style:     TextFontStyle.textFontStyle(
                          14,
                          const Color(0xFF333333),
                          FontWeight.w400 ,
                        ),

                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              DateTime previousMonth = DateTime(
                                  currentMonth.year, currentMonth.month - 1);
                              DateTime now = DateTime.now();
                              if (previousMonth.year > now.year ||
                                  (previousMonth.year == now.year &&
                                      previousMonth.month >= now.month)) {
                                modalState(() {
                                  currentMonth = previousMonth;
                                });
                              }
                            },
                            icon: Icon(Icons.keyboard_arrow_left_sharp,
                                size: 24, color: Color(0xFF333333)),
                          ),
                          IconButton(
                            onPressed: () {
                              modalState(() {
                                currentMonth = DateTime(
                                    currentMonth.year, currentMonth.month + 1);
                              });
                            },
                            icon: Icon(Icons.keyboard_arrow_right_sharp,
                                size: 24, color: Color(0xFF333333)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Color(0xFFE4E4E4),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                        .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style:TextFontStyle.textFontStyle(
                            14,
                            const Color(0xFF666666),
                            FontWeight.w500 ,
                          ),

                        ),
                      ),
                    ))
                        .toList(),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _getDaysInMonth(currentMonth).length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        DateTime date = _getDaysInMonth(currentMonth)[index];

                        if (date.year == 0) return Container();

                        DateTime today = DateTime.now();
                        bool isPastDate = date.isBefore(
                            DateTime(today.year, today.month, today.day));
                        bool isSelected = selectedDate != null &&
                            selectedDate!.day == date.day &&
                            selectedDate!.month == date.month &&
                            selectedDate!.year == date.year;

                        return GestureDetector(
                          onTap: isPastDate
                              ? null
                              : () {
                            modalState(() {
                              selectedDate = date;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xFF1E535B)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "${date.day}",

                              style: TextStyle(
                                color: isPastDate
                                    ? Colors.grey
                                    : isSelected
                                    ? Colors.white
                                    : Color(0xFF333333),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFF1E535B)),
                          foregroundColor:
                          Color(0xFF1E535B), // For text and splash
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style:TextFontStyle.textFontStyle(
                            14,
                            const Color(0xFF1E535B),
                            FontWeight.bold ,
                          ),

                        ),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedDate = selectedDate;
                          });
                          Navigator.pop(context, selectedDate);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1E535B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Set",
                          style: TextFontStyle.textFontStyle(
                            12,
                            Colors.white,
                            FontWeight.bold ,
                          ),

                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showCustomTimePicker(BuildContext context) {
    DateTime now = DateTime.now();

    // Use previously selected time if available, otherwise use current time
    final DateTime initialTime = selectedTime ?? now;

    int selectedHour =
    initialTime.hour % 12 == 0 ? 11 : (initialTime.hour % 12) - 1;
    int selectedMinute = initialTime.minute;
    int selectedPeriodIndex = initialTime.hour >= 12 ? 1 : 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Select Event Time",
                    style: TextFontStyle.textFontStyle(
                      18,
                      const Color(0xFF333333),
                      FontWeight.w600 ,
                    ),

                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hour Picker
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectedHour),
                            itemExtent: 50.0,
                            onSelectedItemChanged: (index) {
                              setModalState(() {
                                selectedHour = index;
                              });
                            },
                            children: List.generate(12, (index) {
                              return Center(child: Text('${index + 1}'));
                            }),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(":", style: TextStyle(fontSize: 24)),
                        SizedBox(width: 10),
                        // Minute Picker
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectedMinute),
                            itemExtent: 50.0,
                            onSelectedItemChanged: (index) {
                              setModalState(() {
                                selectedMinute = index;
                              });
                            },
                            children: List.generate(60, (index) {
                              return Center(
                                  child:
                                  Text(index.toString().padLeft(2, '0')));
                            }),
                          ),
                        ),
                        SizedBox(width: 10),
                        // AM/PM Picker
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectedPeriodIndex),
                            itemExtent: 50.0,
                            onSelectedItemChanged: (index) {
                              setModalState(() {
                                selectedPeriodIndex = index;
                              });
                            },
                            children: const [
                              Center(child: Text("AM")),
                              Center(child: Text("PM")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFF1E535B)),
                          foregroundColor:
                          Color(0xFF1E535B), // For text and splash
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextFontStyle.textFontStyle(
                            12,
                            const Color(0xFF1E535B),
                            FontWeight.bold ,
                          ),

                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          int hour = (selectedHour + 1) % 12;
                          if (selectedPeriodIndex == 1) hour += 12;

                          DateTime now = DateTime.now();
                          setState(() {
                            selectedTime = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              hour,
                              selectedMinute,
                            );
                          });

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1E535B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Set"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Event Date Picker
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event Date*",
                style: TextFontStyle.textFontStyle(
                  MediaQuery.of(context).size.width * 0.035, // responsive font size
                  const Color(0xFF575959),
                  FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.008, // responsive spacing
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE4E4E4)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Flexible( // ✅ prevents overflow
                      child: Text(
                        selectedDate != null
                            ? DateFormat('dd, MMM yyyy').format(selectedDate!)
                            : "Select Date",
                        overflow: TextOverflow.ellipsis, // ✅ handles long text
                        style: TextFontStyle.textFontStyle(
                          12,
                          const Color(0xFF575959),
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02), // ✅ spacing
                    GestureDetector(
                      onTap: () => _showCustomDatePicker(context),
                      child: Icon(
                        Icons.calendar_month,
                        size: MediaQuery.of(context).size.width * 0.04,
                        color: const Color(0xFF575959),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),


        SizedBox(width: 16),

        // Event Time Picker (uses same style)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event Time*",
                style: TextFontStyle.textFontStyle(
                  14,
                  const Color(0xFF575959),
                  FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE4E4E4)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    /// Use Flexible instead of fixed width
                    Flexible(
                      child: Text(
                        selectedTime != null
                            ? DateFormat('hh:mm a').format(selectedTime!)
                            : "Select time",
                        overflow: TextOverflow.ellipsis, // will truncate if long
                        style: TextFontStyle.textFontStyle(
                          12,
                          const Color(0xFF575959),
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8), // add small gap
                    GestureDetector(
                      onTap: () => _showCustomTimePicker(context),
                      child: Icon(
                        Icons.access_time,
                          size: 20,
                        color: Color(0xFF575959),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }
}
