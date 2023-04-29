import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leavemanagementadmin/pages/Employee.dart';
import 'package:leavemanagementadmin/pages/branch.dart';
import 'package:leavemanagementadmin/pages/department.dart';
import 'package:leavemanagementadmin/pages/designation.dart';
import 'package:leavemanagementadmin/pages/leave_report.dart';

import 'package:leavemanagementadmin/widget/logoutPage.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constant/constant.dart';
import 'leaveBalance.page.dart';

@RoutePage()
class SidebarPage extends StatelessWidget {
  SidebarPage({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Globizs Leave Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.purple,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          //! if screensize < 600 then sidebar will be hidden
          final isSmallScreen = MediaQuery.of(context).size.width < 1200;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: 32,
                            child: Image.asset("assets/images/GlobizsLM.png")),
                      ],
                    ),
                    //  const Text(
                    //   "Globizs Leave Management",
                    //   style: TextStyle(
                    //     color: Color.fromARGB(255, 211, 32, 39),
                    //   ),
                    // ),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatefulWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  State<ExampleSidebarX> createState() => _ExampleSidebarXState();
}

class _ExampleSidebarXState extends State<ExampleSidebarX> {
  List<SidebarXItem> _items = [];
  bool isexpanded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._controller.addListener(() {
      setState(() {
        isexpanded = widget._controller.extended;
      });
      log('Item Length  :${_items.length}');
      // if (_items.length > 6) {
      //   setState(() {
      //     isclicked = true;
      //   });
      // } else {
      //   setState(() {
      //     isclicked = false;
      //   });
      // }
      // setState(() {
      //   isexpanded = widget._controller.extended;
      // });
      // if (isexpanded) {
      //   if (_items.length > 6) {
      //     log(isclicked.toString());
      //     int i;
      //     for (i = 1; i < 5; i++) {
      //       _items.removeAt(_items.length - 1);
      //     }
      //     _items.addAll(settingsubitems);
      //   }
      // } else {
      //   if (_items.length > 6) {
      //     int i;
      //     for (i = 1; i < 5; i++) {
      //       _items.removeAt(_items.length - 1);
      //     }
      //     _items.addAll(settingsubitems);
      //   }
      // }
    });
    _items = _generateItems;
  }

  List<SidebarXItem> get reportsubitems1 {
    log('sub items$isexpanded');
    return [
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            Icons.format_align_left_sharp,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Leave Report',
      ),
      SidebarXItem(
        icon: Icons.settings,
        label: 'Setting                🔻',
        onTap: () {
          if (_items.length == 6) {
            log('item 5 only..............');
            log(isclicked.toString());
            _items.removeAt(5);

            _items.addAll(settingsubitems);
          } else if (_items.length == 7) {
            log('True item number 6');
            _items.removeAt(6);
            _items.addAll(settingsubitems);
          } else if (_items.length == 9) {
            _items.removeRange(5, 8);
          } else if (_items.length == 10) {
            _items.removeRange(6, 9);
          } else {
            log('else part');
          }

          log('Item Length from settiing :${_items.length}');
        },
      ),
      SidebarXItem(
        icon: Icons.logout_rounded,
        label: 'Log out',
        onTap: () {
          log('log out');
        },
      ),
    ];
  }

  List<SidebarXItem> get reportsubitems2 {
    log('sub items$isexpanded');
    return [
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            Icons.format_align_left,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Leave Report',
      ),
      SidebarXItem(
        icon: Icons.settings,
        label: 'Setting                🔻',
        onTap: () {
          if (_items.length == 6) {
            log('item 5 only..............');
            log(isclicked.toString());
            _items.removeAt(5);

            _items.addAll(settingsubitems);
          } else if (_items.length == 7) {
            log('True item number 6');
            _items.removeAt(6);
            _items.addAll(settingsubitems);
          } else if (_items.length == 9) {
            _items.removeRange(5, 8);
          } else if (_items.length == 10) {
            _items.removeRange(6, 9);
          } else {
            log('else part');
          }

          log('Item Length from settiing :${_items.length}');
        },
      ),
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            Icons.lan,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Branch',
      ),
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            FontAwesomeIcons.buildingUser,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Department',
      ),
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            FontAwesomeIcons.addressCard,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Designation',
      ),
      SidebarXItem(
        icon: Icons.logout_rounded,
        label: 'Log out',
        onTap: () {
          log('log out');
        },
      ),
    ];
  }

  List<SidebarXItem> get settingsubitems {
    log('sub items$isexpanded');
    return [
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            Icons.lan,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Branch',
      ),
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            FontAwesomeIcons.buildingUser,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Department',
      ),
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            FontAwesomeIcons.addressCard,
            // color: Color.fromARGB(255, 164, 92, 95),
            size: 15,
          ),
        ),
        label: 'Designation',
      ),
      SidebarXItem(
        icon: Icons.logout_rounded,
        label: 'Log out',
        onTap: () {
          log('log out');
        },
      ),
    ];
  }

  bool isclicked = false;
  List<SidebarXItem> get _generateItems {
    log('Before return :$isclicked');
    return [
      SidebarXItem(
        icon: Icons.dashboard,
        label: 'Dashboard',
        onTap: () {
          debugPrint('Dashboard');
        },
      ),
      const SidebarXItem(
        icon: Icons.account_box_rounded,
        label: 'Employee',
      ),
      const SidebarXItem(
        icon: Icons.medical_information,
        label: 'Leave Balance',
      ),
      SidebarXItem(
        icon: FontAwesomeIcons.book,
        label: 'Report                🔻',
        onTap: () {
          if (_items.length == 6) {
            log('item 5 only..............');
            log(isclicked.toString());
            _items.removeRange(4, 6);

            _items.addAll(reportsubitems1);
          } else if (_items.length == 7) {
            log('item 6 only..............');

            _items.removeAt(4);
          } else if (_items.length == 9) {
            _items.removeRange(4, 9);
            _items.addAll(reportsubitems2);
          } else if (_items.length == 10) {
            _items.removeAt(4);
          }

          log('Item Length :${_items.length}');
        },
      ),
      SidebarXItem(
        icon: Icons.settings,
        label: 'Setting                🔻',
        onTap: () {
          if (_items.length == 5) {
            log('item 5 only..............');
            log(isclicked.toString());
            _items.removeAt(4);

            _items.addAll(settingsubitems);
          } else if (_items.length == 6) {
            log('True item number 6');
            _items.removeAt(5);
            _items.addAll(settingsubitems);
          } else if (_items.length == 8) {
            _items.removeRange(4, 7);
          } else if (_items.length == 9) {
            _items.removeRange(5, 8);
          } else {
            log('else part');
          }

          log('Item Length from settiing :${_items.length}');
        },
      ),
      SidebarXItem(
        icon: Icons.logout,
        label: 'Log out',
        onTap: () {
          log('log out');
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
        headerDivider: const Divider(
          thickness: 1,
          color: Color.fromARGB(255, 231, 231, 231),
        ),
        controller: widget._controller,
        theme: SidebarXTheme(
          width: 82,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: scaffoldBackgroundColor,
          textStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          selectedTextStyle: const TextStyle(color: Colors.white),

          itemTextPadding: const EdgeInsets.only(left: 20),
          selectedItemTextPadding: const EdgeInsets.only(left: 20),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 211, 32, 39),
                Color.fromARGB(255, 164, 92, 95)
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 10,
              )
            ],
          ),
          //! -> sidebar icon theme
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
        ),
        footerDivider: divider,
        headerBuilder: (context, extended) {
          log(extended.toString());

          return FittedBox(
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/G-png-only.png'),
                  ),
                ),
                extended
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Leave",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Management",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          );
        },
        items: _items);
  }
}

bool? isselectedsetting;
bool? issectedreport;
bool? ischoosereport;

bool? isselected0;
bool? isselected1;
bool? isselected2;
bool? isselected5;
bool? isselected4;
bool? isselected6;
bool? isselected7;
bool? isselected8;
bool? isselected9;

class _ScreensExample extends StatefulWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  State<_ScreensExample> createState() => _ScreensExampleState();
}

class _ScreensExampleState extends State<_ScreensExample> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isselectedsetting = false;
    ischoosereport = false;
    issectedreport = false;
    isselected0 = true;
    isselected1 = false;
    isselected2 = false;
    isselected4 = false;
    isselected5 = false;
    isselected6 = false;
    isselected7 = false;
    isselected8 = false;
    isselected9 = false;
    widget.controller.addListener(() {
      log('Selected Index :${widget.controller.selectedIndex}');
      switch (widget.controller.selectedIndex) {
        case 0:
          setState(
            () {
              isselected0 = true;
              isselected1 = false;
              isselected2 = false;
              isselected6 = false;
              isselected7 = false;
              isselected8 = false;
              isselected9 = false;
              isselected5 = false;
            },
          );
          break;
        case 1:
          setState(
            () {
              isselected0 = false;
              isselected2 = false;
              isselected1 = true;
              isselected6 = false;
              isselected7 = false;
              isselected8 = false;
              isselected9 = false;
              isselected5 = false;
            },
          );
          break;
        case 2:
          setState(
            () {
              isselected0 = false;
              isselected1 = false;
              isselected2 = true;
              isselected4 = false;
              isselected6 = false;
              isselected7 = false;
              isselected8 = false;
              isselected9 = false;
              isselected5 = false;
            },
          );
          break;
        case 3:
          setState(
            () {
              issectedreport = issectedreport! ? false : false;
              ischoosereport = !ischoosereport!;
              isselected0 = isselected0! ? true : false;
              isselected1 = isselected1! ? true : false;
              isselected2 = isselected2! ? true : false;
              isselected6 = isselected6! ? true : false;
              isselected7 = isselected7! ? true : false;
              isselected8 = isselected8! ? true : false;
              isselected9 = isselected9! ? true : false;
              isselected9 = isselected5! ? true : false;
            },
          );
          break;
        case 4:
          log('Ischoosereport :$ischoosereport');
          setState(
            () {
              isselectedsetting = ischoosereport! ? false : !isselectedsetting!;
              issectedreport = ischoosereport! ? true : false;
              isselected0 = ischoosereport!
                  ? false
                  : isselected0!
                      ? true
                      : false;
              isselected1 = ischoosereport!
                  ? false
                  : isselected1!
                      ? true
                      : false;
              isselected2 = ischoosereport!
                  ? false
                  : isselected2!
                      ? true
                      : false;
              isselected4 = ischoosereport!
                  ? true
                  : isselected4!
                      ? true
                      : false;
              isselected6 = ischoosereport!
                  ? false
                  : isselected6!
                      ? true
                      : false;
              isselected7 = ischoosereport!
                  ? false
                  : isselected7!
                      ? true
                      : false;
              isselected8 = ischoosereport!
                  ? false
                  : isselected8!
                      ? true
                      : false;
              isselected9 = ischoosereport!
                  ? false
                  : isselected9!
                      ? true
                      : false;
            },
          );
          break;

        // case 5:
        //   setState(
        //     () {
        //       isselectedsetting = ischoosereport!
        //           ? isselectedsetting!
        //               ? true
        //               : true
        //           : isselectedsetting!
        //               ? true
        //               : false;
        //       isselected0 = ischoosereport!
        //           ? false
        //           : isselected0!
        //               ? true
        //               : false;
        //       isselected2 = ischoosereport!
        //           ? false
        //           : isselected2!
        //               ? true
        //               : false;
        //       isselected1 = ischoosereport!
        //           ? false
        //           : isselected1!
        //               ? true
        //               : false;
        //       isselected6 = ischoosereport!
        //           ? false
        //           : isselected6!
        //               ? true
        //               : false;
        //       isselected7 = ischoosereport!
        //           ? false
        //           : isselected7!
        //               ? true
        //               : false;
        //       isselected8 = ischoosereport!
        //           ? false
        //           : isselected8!
        //               ? true
        //               : false;
        //       isselected9 = ischoosereport!
        //           ? false
        //           : isselected9!
        //               ? true
        //               : false;
        //     },
        //   );
        //   break;
        case 5:
          setState(
            () {
              isselectedsetting = ischoosereport!
                  ? isselectedsetting!
                      ? true
                      : true
                  : isselectedsetting!
                      ? true
                      : false;
              isselected5 = ischoosereport! ? false : true;
              isselected0 = isselected0! ? false : false;
              isselected2 = isselected2! ? false : false;
              isselected1 = isselected1! ? false : false;
              isselected6 = isselected6! ? false : false;
              isselected7 = isselected7! ? false : false;
              isselected8 = isselected8! ? false : false;
              isselected9 = isselected9! ? false : false;
            },
          );
          break;
        case 6:
          setState(
            () {
              isselected0 = false;
              issectedreport = false;
              isselected1 = false;
              isselected2 = false;
              isselected6 = true;
              isselected7 = false;
              isselected8 = false;
              isselected9 = false;
              isselected5 = false;
            },
          );
          break;
        case 7:
          setState(
            () {
              issectedreport = false;
              isselected0 = false;
              isselected1 = false;
              isselected2 = false;
              isselected6 = false;
              isselected7 = true;
              isselected8 = false;
              isselected9 = false;
              isselected5 = false;
            },
          );
          break;
        case 8:
          setState(
            () {
              issectedreport = false;
              isselected0 = false;
              isselected1 = false;
              isselected2 = false;
              isselected6 = false;
              isselected7 = false;
              isselected8 = true;
              isselected9 = false;
              isselected5 = false;
            },
          );
          break;
        case 9:
          setState(
            () {
              issectedreport = false;
              isselected0 = false;
              isselected1 = false;
              isselected2 = false;
              isselected6 = false;
              isselected7 = false;
              isselected8 = false;
              isselected9 = true;
              isselected5 = false;
            },
          );
          break;

        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        switch (widget.controller.selectedIndex) {
          case 0:
            return FittedBox(
                fit: BoxFit.fill,
                child: Column(
                  children: const [
                    Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Globizs web solution Pvt. Ltd.",
                        style: TextStyle(color: Colors.redAccent, fontSize: 56),
                      ),
                    )
                  ],
                ));
          case 1:
            return const EmployeePage();

          case 2:
            return const LeaveBalancePage();

          case 3:
            return issectedreport!
                ? const LeaveReportPage()
                : isselected4!
                    ? const LeaveReportPage()
                    : isselected2!
                        ? const LeaveBalancePage()
                        : isselected0!
                            ? FittedBox(
                                fit: BoxFit.fill,
                                child: Column(
                                  children: const [
                                    Text(
                                      "Welcome",
                                      style: TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Globizs web solution Pvt. Ltd.",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 211, 32, 39),
                                            fontSize: 56),
                                      ),
                                    )
                                  ],
                                ))
                            : isselected1!
                                ? const EmployeePage()
                                : isselected6!
                                    ? isselectedsetting!
                                        ? const LogOutPage()
                                        : const BranchPage()
                                    : isselected7!
                                        ? const DepartmentPage()
                                        : isselected8!
                                            ? ischoosereport!
                                                ? const LogOutPage()
                                                : const DesignationPage()
                                            : isselected9!
                                                ? isselectedsetting!
                                                    ? const LogOutPage()
                                                    : const LogOutPage()
                                                : const EmployeePage();
          case 4:
            return issectedreport!
                ? const LeaveReportPage()
                : isselected0!
                    ? FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          children: const [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: 42, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Globizs web solution Pvt. Ltd.",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 211, 32, 39),
                                    fontSize: 56),
                              ),
                            )
                          ],
                        ))
                    : isselected2!
                        ? const LeaveBalancePage()
                        : isselected1!
                            ? const EmployeePage()
                            : isselected5!
                                ? ischoosereport!
                                    ? const BranchPage()
                                    : const BranchPage()
                                : isselected6!
                                    ? ischoosereport!
                                        ? const BranchPage()
                                        : const DepartmentPage()
                                    : isselected7!
                                        ? ischoosereport!
                                            ? const DepartmentPage()
                                            : const DesignationPage()
                                        : isselected8!
                                            ? ischoosereport!
                                                ? const DesignationPage()
                                                : const LogOutPage()
                                            : isselected9!
                                                ? isselectedsetting!
                                                    ? const LogOutPage()
                                                    : const LogOutPage()
                                                : const EmployeePage();
          case 5:
            log('Isselectedsetting :$isselectedsetting');
            return isselectedsetting!
                ? ischoosereport!
                    ? issectedreport!
                        ? const LeaveReportPage()
                        : isselected0!
                            ? FittedBox(
                                fit: BoxFit.fill,
                                child: Column(
                                  children: const [
                                    Text(
                                      "Welcome",
                                      style: TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Globizs web solution Pvt. Ltd.",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 211, 32, 39),
                                            fontSize: 56),
                                      ),
                                    )
                                  ],
                                ))
                            : isselected1!
                                ? const EmployeePage()
                                : isselected6!
                                    ? isselectedsetting!
                                        ? const BranchPage()
                                        : const LogOutPage()
                                    : isselected7!
                                        ? const DepartmentPage()
                                        : isselected8!
                                            ? const DesignationPage()
                                            : isselected9!
                                                ? isselectedsetting!
                                                    ? const LogOutPage()
                                                    : const LogOutPage()
                                                : const EmployeePage()
                    : isselectedsetting!
                        ? const BranchPage()
                        : const LogOutPage()
                : const LogOutPage();

          case 6:
            return ischoosereport!
                ? isselectedsetting!
                    ? const BranchPage()
                    : const LogOutPage()
                : const DepartmentPage();
          case 7:
            return ischoosereport!
                ? isselectedsetting!
                    ? const DepartmentPage()
                    : const LogOutPage()
                : const DesignationPage();

          case 8:
            return ischoosereport!
                ? isselectedsetting!
                    ? const DesignationPage()
                    : const LogOutPage()
                : const LogOutPage();
          case 9:
            return issectedreport!
                ? isselectedsetting!
                    ? const LogOutPage()
                    : const LogOutPage()
                : const LogOutPage();
          default:
            return Text(
              '',
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

class OnHoverButton2 extends StatefulWidget {
  final Widget child;
  const OnHoverButton2({super.key, required this.child});

  @override
  State<OnHoverButton2> createState() => _OnHoverButton2State();
}

class _OnHoverButton2State extends State<OnHoverButton2> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.1);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
        transform: transform,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
