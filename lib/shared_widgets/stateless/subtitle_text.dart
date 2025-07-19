import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

///Don't use it with items or cards (inside any lists) because it uses SizeHelper inside it so the O(n) and the best solution here is to use SizeHelper from the outside and pass the result to every item/card by parameters so the big O will be O(1).
class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.isBold = false,
    this.subtractedSize = 0.0,
    this.textDirection,
    this.margin,
    this.color,
    this.fontFamily,
    this.maxLines = 10,
    this.overflow,
    this.isUpperCase = false,
    this.stopTranslate = false,
    this.decoration,
  });

  final String text;
  final bool isBold;
  final bool isUpperCase;
  final bool stopTranslate;
  final double subtractedSize;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final EdgeInsets? margin;
  final Color? color;
  final String? fontFamily;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const SubtitleText.small({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
    TextOverflow? overflow,
    bool isUpperCase = false,
    bool stopTranslate = false,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: 4.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
          overflow: overflow,
          isUpperCase: isUpperCase,
          stopTranslate: stopTranslate,
        );
  const SubtitleText.medium({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
    TextOverflow? overflow,
    bool isUpperCase = false,
    bool stopTranslate = false,
    TextDecoration? decoration,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: 2.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
          overflow: overflow,
          isUpperCase: isUpperCase,
          stopTranslate: stopTranslate,
          decoration: decoration,
        );

  const SubtitleText.large({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
    TextOverflow? overflow,
    bool isUpperCase = false,
    bool stopTranslate = false,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: -6.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
          overflow: overflow,
          isUpperCase: isUpperCase,
          stopTranslate: stopTranslate,
        );

  const SubtitleText.extraLarge({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
    TextOverflow? overflow,
    bool isUpperCase = false,
    bool stopTranslate = false,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: -12.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
          overflow: overflow,
          isUpperCase: isUpperCase,
          stopTranslate: stopTranslate,
        );

  @override
  Widget build(BuildContext context) {
    final textStyleBefore = context
        .sizeHelper(
          mobileLarge:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.0),
          tabletSmall: Theme.of(context).textTheme.bodyMedium,
          tabletLarge: Theme.of(context).textTheme.bodyLarge,
          desktopSmall:
              Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18.0),
        )
        .copyWith(
          color: color,
          fontFamily: fontFamily,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          decoration: decoration,
        );

    final textStyleAfter = textStyleBefore.copyWith(
        fontSize: textStyleBefore.fontSize! - subtractedSize);
    Widget child = Text(
      (isUpperCase && stopTranslate)
          ? text.toUpperCase()
          : (isUpperCase && !stopTranslate)
              ? text.toUpperCase().tr()
              : stopTranslate
                  ? text
                  : text.tr(),
      softWrap: true,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      textDirection: textDirection,
      style: textStyleAfter,
    );

    if (margin != null) child = Padding(padding: margin!, child: child);

    return child;
  }
}
