import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:leavemanagementadmin/constant.dart';

@RoutePage()
class LeaveReportPage extends StatefulWidget {
  const LeaveReportPage({super.key});

  @override
  State<LeaveReportPage> createState() => _LeaveReportPageState();
}

class _LeaveReportPageState extends State<LeaveReportPage> {
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
              ? const EdgeInsets.only(
                  left: 50,
                )
              : const EdgeInsets.only(
                  left: 10,
                ),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Leave Report",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: MediaQuery.of(context).size.width > 1040
              ? const EdgeInsets.only(left: 50, top: 13)
              : const EdgeInsets.only(left: 10, top: 13),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  showCalendarDatePicker2Dialog(
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      firstDayOfWeek: 1,
                      calendarType: CalendarDatePicker2Type.range,
                      selectedDayTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      selectedDayHighlightColor: Colors.purple[800],
                      centerAlignModePicker: true,
                      customModePickerIcon: const SizedBox(),
                    ),
                    context: (context),
                    dialogSize: const Size(325, 400),
                  ).then((value) {
                    israngeselected = false;
                    startdate = "";
                    enddate = "";
                    startdatefinal = "";
                    enddatefinal = "";

                    if (value!.length == 1) {
                      setState(
                        () {
                          israngeselected = true;
                          startdatefinal =
                              DateFormat('MMM d, yyyy').format(value[0]!);
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
                          startdatefinal = DateFormat.yMMMd().format(value[0]!);
                          enddate =
                              "${value[1]!.year}-${value[1]!.month}-${value[1]!.day}";
                          enddatefinal = DateFormat.yMMMd().format(value[1]!);
                        },
                      );
                    }

                    log(israngeselected.toString());
                    log('Start Date :$startdate');
                    log('End Date $enddate');
                  });
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
                    width: israngeselected == false || enddatefinal.isEmpty
                        ? MediaQuery.of(context).size.width / 10
                        : MediaQuery.of(context).size.width / 4,
                    height: 40,
                    borderRadius: 13,
                    child: startdatefinal.isEmpty && enddatefinal.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                "Select date",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              israngeselected
                                  ? Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        enddatefinal.isEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  startdatefinal,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    'From : ',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    startdatefinal,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    "To : ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    enddatefinal,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )
                                      ],
                                    )
                                  : const SizedBox(),
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.calendar_month,
                                    color: Colors.white),
                              ),
                            ],
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
                    borderRadius: BorderRadius.circular(3),
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
                  rows: const <DataRow>[
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
