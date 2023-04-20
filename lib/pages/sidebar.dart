import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leavemanagementadmin/pages/branch.dart';
import 'package:leavemanagementadmin/pages/department.dart';
import 'package:leavemanagementadmin/pages/designation.dart';
import 'package:leavemanagementadmin/pages/homepage.dart';

import 'package:leavemanagementadmin/widget/logoutPage.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constant/constant.dart';

@RoutePage()
class SidebarPage extends StatelessWidget {
  SidebarPage({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
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
          final isSmallScreen = MediaQuery.of(context).size.width < 800;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: Text(_getTitleByIndex(_controller.selectedIndex)),
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
      if (_items.length > 4) {
        setState(() {
          isclicked = true;
        });
      } else {
        setState(() {
          isclicked = false;
        });
      }
      setState(() {
        isexpanded = widget._controller.extended;
      });
      if (isexpanded) {
        if (_items.length > 4) {
          log(isclicked.toString());
          int i;
          for (i = 1; i < 5; i++) {
            _items.removeAt(_items.length - 1);
          }
          _items.addAll(settingsubitems);
        }
      } else {
        if (_items.length > 4) {
          int i;
          for (i = 1; i < 5; i++) {
            _items.removeAt(_items.length - 1);
          }
          _items.addAll(settingsubitems);
        }
      }
    });
    _items = _generateItems;
  }

  List<SidebarXItem> get settingsubitems {
    log('sub items$isexpanded');
    return [
      SidebarXItem(
        iconWidget: Padding(
          padding: EdgeInsets.only(left: isexpanded ? 40 : 0),
          child: const Icon(
            FontAwesomeIcons.codeBranch,
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
      SidebarXItem(
        icon: Icons.settings,
        label: 'Setting                🔻',
        onTap: () {
          if (_items.length > 4) {
            setState(() {
              isclicked = true;
            });
            log(isclicked.toString());
            int i;
            for (i = 1; i < 4; i++) {
              _items.removeAt(_items.length - 2);
            }
          } else {
            widget._controller.addListener(() {
              setState(() {
                isclicked = false;
                isexpanded = widget._controller.extended;
              });
              log(isclicked.toString());
            });
            _items.removeAt(3);
            _items.addAll(settingsubitems);
          }

          log(_items.length.toString());
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

bool isselectedsetting = false;
bool isselected0 = true;
bool isselected1 = false;
bool isselected3 = false;
bool isselected4 = false;
bool isselected5 = false;
bool isselected6 = false;

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
    widget.controller.addListener(() {
      log(widget.controller.selectedIndex.toString());
      switch (widget.controller.selectedIndex) {
        case 0:
          setState(
            () {
              isselected0 = true;
              isselected1 = false;
              isselected3 = false;
              isselected4 = false;
              isselected5 = false;
              isselected6 = false;
            },
          );
          break;
        case 1:
          setState(
            () {
              isselected0 = false;

              isselected1 = true;
              isselected3 = false;
              isselected4 = false;
              isselected5 = false;
              isselected6 = false;
            },
          );
          break;
        case 2:
          setState(
            () {
              isselectedsetting = !isselectedsetting;
              isselected0 = isselected0 ? true : false;
              isselected1 = isselected1 ? true : false;
              isselected3 = isselected3 ? true : false;
              isselected4 = isselected4 ? true : false;
              isselected5 = isselected5 ? true : false;
              isselected6 = isselected6 ? true : false;
            },
          );
          break;
        case 3:
          setState(
            () {
              isselected0 = false;
              isselected1 = false;
              isselected3 = true;
              isselected4 = false;
              isselected5 = false;
              isselected6 = false;
            },
          );
          break;
        case 4:
          setState(
            () {
              isselected0 = false;
              isselected1 = false;
              isselected3 = false;
              isselected4 = true;
              isselected5 = false;
              isselected6 = false;
            },
          );
          break;
        case 5:
          setState(
            () {
              isselected0 = false;
              isselected1 = false;
              isselected3 = false;
              isselected4 = false;
              isselected5 = true;
              isselected6 = false;
            },
          );
          break;
        case 6:
          setState(
            () {
              isselected0 = false;
              isselected1 = false;
              isselected3 = false;
              isselected4 = false;
              isselected5 = false;
              isselected6 = true;
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
        final pageTitle = _getTitleByIndex(widget.controller.selectedIndex);

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
            return const HomePage();

          case 2:
            return isselected0
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
                                color: Colors.redAccent, fontSize: 56),
                          ),
                        )
                      ],
                    ))
                : isselected1
                    ? const HomePage()
                    : isselected3
                        ? isselectedsetting
                            ? const LogOutPage()
                            : const BranchPage()
                        : isselected4
                            ? const DepartmentPage()
                            : isselected5
                                ? const DesignationPage()
                                : isselected6
                                    ? isselectedsetting
                                        ? const LogOutPage()
                                        : const LogOutPage()
                                    : const HomePage();
          case 3:
            return isselectedsetting ? const BranchPage() : const LogOutPage();
          case 4:
            return const DepartmentPage();
          case 5:
            return const DesignationPage();
          case 6:
            return const LogOutPage();
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Dashboard';
    case 1:
      return 'User';
    case 2:
      return 'Balance';
    case 3:
      return 'Reports';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
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
