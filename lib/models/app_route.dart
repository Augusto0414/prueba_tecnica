import 'package:flutter/material.dart';

class AppRoute {
  AppRoute({this.name, required this.route, this.icon, required this.screen});

  final String? name;
  final String route;
  final IconData? icon;
  final Widget screen;
}
