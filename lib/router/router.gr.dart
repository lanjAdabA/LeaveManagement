// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/material.dart' as _i8;
import 'package:leavemanagementadmin/Authflow/auth_flow.dart' as _i1;
import 'package:leavemanagementadmin/pages/homepage.dart' as _i2;
import 'package:leavemanagementadmin/pages/leave_report.dart' as _i3;
import 'package:leavemanagementadmin/pages/loginpage.dart' as _i4;
import 'package:leavemanagementadmin/pages/newpage.dart' as _i5;
import 'package:leavemanagementadmin/pages/sidebar.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LeaveReportRoute.name: (routeData) {
      final args = routeData.argsAs<LeaveReportRouteArgs>(
          orElse: () => const LeaveReportRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LeaveReportPage(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    NewRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.NewPage(),
      );
    },
    SidebarRoute.name: (routeData) {
      final args = routeData.argsAs<SidebarRouteArgs>(
          orElse: () => const SidebarRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SidebarPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i7.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LeaveReportPage]
class LeaveReportRoute extends _i7.PageRouteInfo<LeaveReportRouteArgs> {
  LeaveReportRoute({
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          LeaveReportRoute.name,
          args: LeaveReportRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LeaveReportRoute';

  static const _i7.PageInfo<LeaveReportRouteArgs> page =
      _i7.PageInfo<LeaveReportRouteArgs>(name);
}

class LeaveReportRouteArgs {
  const LeaveReportRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'LeaveReportRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.NewPage]
class NewRoute extends _i7.PageRouteInfo<void> {
  const NewRoute({List<_i7.PageRouteInfo>? children})
      : super(
          NewRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SidebarPage]
class SidebarRoute extends _i7.PageRouteInfo<SidebarRouteArgs> {
  SidebarRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SidebarRoute.name,
          args: SidebarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SidebarRoute';

  static const _i7.PageInfo<SidebarRouteArgs> page =
      _i7.PageInfo<SidebarRouteArgs>(name);
}

class SidebarRouteArgs {
  const SidebarRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'SidebarRouteArgs{key: $key}';
  }
}
