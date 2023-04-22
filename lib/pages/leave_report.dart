import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:leavemanagementadmin/constant.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveReportPage extends StatefulWidget {
  LeaveReportPage({super.key});

  @override
  State<LeaveReportPage> createState() => _LeaveReportPageState();
}

class _LeaveReportPageState extends State<LeaveReportPage> {
  String selectedDate = '';

  String dateCount = '';

  String range = '';

  String rangeCount = '';
  // DateTime datetime = DateTime.now();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
      } else {
        rangeCount = args.value.length.toString();
      }
    });
  }

  String datetime = '';
  String startdate = '';
  String enddate = '';
  String startdatefinal = '';
  String enddatefinal = '';
  bool israngeselected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: MediaQuery.of(context).size.width > 1040
              ? const EdgeInsets.only(left: 50, top: 13)
              : const EdgeInsets.only(left: 10, top: 13),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 222, 221, 221)),
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              israngeselected
                                  ? Row(
                                      children: [
                                        enddatefinal.isEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  startdatefinal,
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    'From : ',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    startdatefinal,
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    "To : ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    enddatefinal,
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  )
                                                ],
                                              )
                                      ],
                                    )
                                  : const SizedBox(),
                              InkWell(
                                onTap: () {
                                  showCalendarDatePicker2Dialog(
                                    config:
                                        CalendarDatePicker2WithActionButtonsConfig(
                                      firstDayOfWeek: 1,
                                      calendarType:
                                          CalendarDatePicker2Type.range,
                                      selectedDayTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      selectedDayHighlightColor:
                                          Colors.purple[800],
                                      centerAlignModePicker: true,
                                      customModePickerIcon: const SizedBox(),
                                    ),
                                    context: (context),
                                    dialogSize: const Size(325, 400),
                                  ).then((value) {
                                    if (value!.length == 1) {
                                      setState(
                                        () {
                                          israngeselected = true;
                                          startdatefinal =
                                              DateFormat('MMMM d, yyyy')
                                                  .format(value[0]!);
                                          startdate =
                                              "${value[0]!.year}-${value[0]!.month}-${value[0]!.day}";
                                        },
                                      );
                                    } else if (value.length == 2) {
                                      setState(
                                        () {
                                          israngeselected = true;
                                          startdate =
                                              "${value[0]!.year}-${value[0]!.month}-${value[0]!.day}";
                                          startdatefinal =
                                              DateFormat('MMMM d, yyyy')
                                                  .format(value[0]!);
                                          enddate =
                                              "${value[1]!.year}-${value[1]!.month}-${value[1]!.day}";
                                          enddatefinal =
                                              DateFormat('MMMM d, yyyy')
                                                  .format(value[1]!);
                                        },
                                      );
                                    }

                                    log(israngeselected.toString());
                                    log('Start Date :$startdate');
                                    log('End Date $enddate');
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.calendar_month),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  elevation: 15,
                  child: CardWidget(
                    gradient: const [
                      Color.fromARGB(255, 211, 32, 39),
                      Color.fromARGB(255, 164, 92, 95)
                    ],
                    width: 120,
                    height: 40,
                    borderRadius: 13,
                    child:
                        //  CupertinoButton(
                        //   child: Text("Date Picker"),
                        //   onPressed: () {
                        //     showCupertinoDialog(
                        //       context: context,
                        //       builder: (context) {
                        //         return SizedBox(
                        //             height: 250,
                        //             child: CupertinoDatePicker(
                        //               onDateTimeChanged: (value) {
                        //                 setState(() {
                        //                   datetime = value;
                        //                 });
                        //               },
                        //              mode: CupertinoDatePickerMode.date,
                        //             ));
                        //       },
                        //     );
                        //   },
                        // )

                        SfDateRangePicker(
                      enableMultiView: true,
                      enablePastDates: true,
                      yearCellStyle: DateRangePickerYearCellStyle(),
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                          showTrailingAndLeadingDates: true),
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: PickerDateRange(
                          DateTime.now().subtract(const Duration(days: 4)),
                          DateTime.now().add(const Duration(days: 3))),
                    ),
                  ),
                )),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: MediaQuery.of(context).size.width > 1040
                  ? const EdgeInsets.only(left: 50, right: 50, top: 20)
                  : const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable2(
                  empty: const Center(
                    child: SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator()),
                  ),
                  fixedTopRows: 1,
                  showBottomBorder: true,
                  dataRowHeight: 43,
                  dividerThickness: 2,
                  headingTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey.withOpacity(0.2)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  rows: <DataRow>[
                    // for (int i = 0;
                    //     i < displayedDataCell.length;
                    //     i += 4)
                    //   DataRow(cells: [
                    //     displayedDataCell[i],
                    //     displayedDataCell[i + 1],
                    //     displayedDataCell[i + 2],
                    //     displayedDataCell[i + 3],
                    //   ])
                  ],
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Sl.no',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        overflow: TextOverflow.ellipsis,
                        'Employee',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'GL',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'LWP',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ML',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Up',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'PL',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'BL',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ]),
    );
  }
}
