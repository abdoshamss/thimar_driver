import 'package:flutter/material.dart';

import '../../main.dart';

Future push(Widget child,{BuildContext? c}) {
  return Navigator.of(c??navigatorKey.currentContext!)
      .push(SlideRight(page: child));
}

pushBack([dynamic data]) {
  return Navigator.of(navigatorKey.currentContext!).pop(data);
}

pushReplacement(Widget child) {
  return Navigator.of(navigatorKey.currentContext!)
      .pushReplacement(MaterialPageRoute(builder: (context) => child));
}

pushAndRemoveUntil(Widget child, {BuildContext? c}) {
  return Navigator.of(c ?? navigatorKey.currentContext!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child), (route) => false);
}

class SlideRight extends PageRouteBuilder {
  final page;

  SlideRight({this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
