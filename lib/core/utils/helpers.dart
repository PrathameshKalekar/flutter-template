import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/custom_router.dart';
import 'package:page_transition/page_transition.dart';

class Helper {
  final BuildContext context;
  Helper( this.context);

  Size get size => MediaQuery.sizeOf(context);
  TextTheme get textTheme => Theme.of(context).textTheme;

  void navigate({
    PageTransitionType type = PageTransitionType.fade,
    required Widget page,
    bool isReplace = false,
    bool isRemoveUntil = false,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    if (isReplace) {
      Navigator.of(context).pushReplacement(
        customRoute(
          child: page,
          type: type,
          duration: duration,
        ),
      );
    } else if (isRemoveUntil) {
      Navigator.of(context).pushAndRemoveUntil(
        customRoute(
          child: page,
          type: type,
          duration: duration,
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).push(
        customRoute(
          child: page,
          type: type,
          duration: duration,
        ),
      );
    }
  }

  void pop(BuildContext context, {dynamic data}) {
    Navigator.pop(context, data);
  }
}
