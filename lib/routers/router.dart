import 'package:flutter/material.dart';
import 'package:jd_shop/pages/search.dart';
import 'package:jd_shop/pages/tabs/Tabs.dart';

final routes = {
  '/': (context) => const Tabs(),
  '/search': (context) => const SearchPage()
};
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (settings.arguments != null) {
    final Route route = MaterialPageRoute(
      builder: (context) =>
          pageContentBuilder(context, arguments: settings.arguments),
    );
    return route;
  } else {
    final Route route =
        MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    return route;
  }
};
