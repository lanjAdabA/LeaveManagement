// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:leavemanagementadmin/Authflow/auth_flow.dart' as _i1;
import 'package:leavemanagementadmin/pages/Employee.dart' as _i2;
import 'package:leavemanagementadmin/pages/leave_report.dart' as _i4;
import 'package:leavemanagementadmin/pages/leaveBalance.page.dart' as _i3;
import 'package:leavemanagementadmin/pages/loginpage.dart' as _i5;
import 'package:leavemanagementadmin/pages/newpage.dart' as _i6;
import 'package:leavemanagementadmin/pages/sidebar.dart' as _i7;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    EmployeeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.EmployeePage(),
      );
    },
    LeaveBalanceRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LeaveBalancePage(),
      );
    },
    LeaveReportRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LeaveReportPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    NewRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.NewPage(),
      );
    },
    SidebarRoute.name: (routeData) {
      final args = routeData.argsAs<SidebarRouteArgs>(
          orElse: () => const SidebarRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SidebarPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i8.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.EmployeePage]
class EmployeeRoute extends _i8.PageRouteInfo<void> {
  const EmployeeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          EmployeeRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LeaveBalancePage]
class LeaveBalanceRoute extends _i8.PageRouteInfo<void> {
  const LeaveBalanceRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LeaveBalanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaveBalanceRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LeaveReportPage]
class LeaveReportRoute extends _i8.PageRouteInfo<void> {
  const LeaveReportRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LeaveReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaveReportRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.NewPage]
class NewRoute extends _i8.PageRouteInfo<void> {
  const NewRoute({List<_i8.PageRouteInfo>? children})
      : super(
          NewRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SidebarPage]
class SidebarRoute extends _i8.PageRouteInfo<SidebarRouteArgs> {
  SidebarRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SidebarRoute.name,
          args: SidebarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SidebarRoute';

  static const _i8.PageInfo<SidebarRouteArgs> page =
      _i8.PageInfo<SidebarRouteArgs>(name);
}

class SidebarRouteArgs {
  const SidebarRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'SidebarRouteArgs{key: $key}';
  }
}
