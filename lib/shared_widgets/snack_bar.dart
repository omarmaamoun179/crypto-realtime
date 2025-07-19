import 'dart:developer';

import '../core/services/redundant_request_exception.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,
    {required dynamic message,
    Widget? action,
    int duration = 4,
    bool? isThereAreStackBottomNav,
    EdgeInsetsGeometry? marginWithBottomNav =
        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
    EdgeInsetsGeometry? margin =
        const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
    Color color = Colors.red}) {
  if (message is RedundantRequestException ||
      message.toString().length > 100 ||
      message.toString().contains('Request is already pending'))
    return log(message.toString());

  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
  if (scaffoldMessenger == null) return;

  scaffoldMessenger.clearSnackBars();

  message = message.toString();

  final snackBarDuration = Duration(seconds: duration);

  final snackBar = SnackBar(
      duration: snackBarDuration,
      margin: isThereAreStackBottomNav ?? false ? marginWithBottomNav : margin,
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      content: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  scaffoldMessenger.clearSnackBars();
                },
                child: Text(
                  (message as String),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            if (action != null) action,
          ],
        ),
      ));

  scaffoldMessenger.showSnackBar(snackBar);
}
