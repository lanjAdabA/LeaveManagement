import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:leavemanagementadmin/constant.dart';

import 'package:leavemanagementadmin/logic/leavereport/leave_report_cubit.dart';
import 'package:leavemanagementadmin/model/leave_report.dart';

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
  List<LeaveReportModel> leavereportdatalist = [];
  List<DataCell> displayedDataCell = [];

  String month = "";
  String initialenddate = "";
  int currentyear = DateTime.now().year;

  @override
  void initState() {
    super.initState();

    context.read<GetLeaveReportCubit>().getleavereport();
    DateTime currentmonth = DateTime.now();
    final DateFormat formatter = DateFormat("MMM");
    final DateFormat initialend = DateFormat("dd MMM ,yyyy");
    final String formattedmonth = formatter.format(currentmonth);
    final String initialenddate1 = initialend.format(currentmonth);
    setState(() {
      month = formattedmonth;
      initialenddate = initialenddate1;
    });
    log("month : $month");
    log("Initial end date : $initialenddate");
  }

  void getleavereportlist(List<LeaveReportModel> getbranchlist) async {
    for (var item in getbranchlist) {
      displayedDataCell.add(
        DataCell(
          Text(
            (getbranchlist.indexOf(item) + 1).toString(),
          ),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Text(item.name),
        ),
      );

      displayedDataCell.add(
        DataCell(item.gl == "0.00"
            ? Text(item.gl)
            : Text(
                item.gl,
                style: const TextStyle(color: Colors.red),
              )),
      );

      displayedDataCell.add(
        DataCell(item.lwp == "0.00"
            ? Text(item.lwp)
            : Text(
                item.lwp,
                style: const TextStyle(color: Colors.red),
              )),
      );
      displayedDataCell.add(
        // ignore: unrelated_type_equality_checks
        DataCell(item.margl == "0.00"
            ? Text(item.margl)
            : Text(
                item.margl,
                style: const TextStyle(color: Colors.red),
              )),
      );
      displayedDataCell.add(
        DataCell(item.matl == "0.00"
            ? Text(item.matl)
            : Text(
                item.matl,
                style: const TextStyle(color: Colors.red),
              )),
      );
      displayedDataCell.add(
        DataCell(item.pt == "0.00"
            ? Text(item.pt)
            : Text(
                item.pt,
                style: const TextStyle(color: Colors.red),
              )),
      );
      displayedDataCell.add(
        DataCell(item.bl == "0.00"
            ? Text(item.bl)
            : Text(
                item.bl,
                style: const TextStyle(color: Colors.red),
              )),
      );
      displayedDataCell.add(
        DataCell(item.total == "0.00"
            ? Text(item.total)
            : Text(
                item.total,
                style: const TextStyle(color: Colors.red),
              )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final leavereportdatalist =
    //     context.watch<GetLeaveReportState>().leavereportlist;

    return BlocConsumer<GetLeaveReportCubit, GetLeaveReportState>(
      listener: (context, state) {
        getleavereportlist(state.leavereportlist);
      },
      builder: (context, state) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
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
                                  startdatefinal = DateFormat('MMM d, yyyy')
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
                                      DateFormat.yMMMd().format(value[0]!);
                                  enddate =
                                      "${value[1]!.year}-${value[1]!.month}-${value[1]!.day}";
                                  enddatefinal =
                                      DateFormat.yMMMd().format(value[1]!);
                                },
                              );
                            }
                            displayedDataCell.clear();
                            context.read<GetLeaveReportCubit>().getleavereport(
                                  startdate: startdate,
                                  enddate: enddate,
                                );
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
                            width: enddatefinal.isNotEmpty ||
                                    israngeselected == false
                                ? MediaQuery.of(context).size.width / 4
                                : MediaQuery.of(context).size.width / 10,
                            height: 40,
                            borderRadius: 13,
                            child: startdatefinal.isEmpty &&
                                    enddatefinal.isEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'From : ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "01 $month, $currentyear",
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
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            initialenddate,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      israngeselected
                                          ? Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                enddatefinal.isEmpty
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          startdatefinal,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .white),
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
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            startdatefinal,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Text(
                                                            "To : ",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            enddatefinal,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        ],
                                                      )
                                              ],
                                            )
                                          : const SizedBox(),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 7),
                                        child: Icon(Icons.calendar_month,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: ElevatedButton(
                      onPressed: () {}, child: Text("Download report")),
                ),
              ],
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      rows: <DataRow>[
                        for (int i = 0; i < displayedDataCell.length; i += 9)
                          DataRow(cells: [
                            displayedDataCell[i],
                            displayedDataCell[i + 1],
                            displayedDataCell[i + 2],
                            displayedDataCell[i + 3],
                            displayedDataCell[i + 4],
                            displayedDataCell[i + 5],
                            displayedDataCell[i + 6],
                            displayedDataCell[i + 7],
                            displayedDataCell[i + 8],
                          ])
                      ],
                      columns: <DataColumn>[
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 20,
                          label: const Text(
                            'Sl.no',
                          ),
                        ),
                        const DataColumn2(
                          label: Text(
                            overflow: TextOverflow.ellipsis,
                            'Employee',
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 15,
                          label: const Text(
                            'GL',
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 15,
                          label: const Text(
                            'LWP',
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 13,
                          label: const Text(
                            'MargL',
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 15,
                          label: const Text(
                            'MatL',
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 15,
                          label: const Text(
                            'PL',
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 15,
                          label: const Text(
                            'BL',
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.S,
                          fixedWidth: MediaQuery.of(context).size.width / 17,
                          label: const Text(
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
      },
    );
  }
}
