import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Const {
  /// Color
  static const Color kBackground = Color(0xFF363062);
  static const Color kheader = Color(0xFF4D4C7D);
  static const Color kBody = Color(0xFFE9D5DA);
  static const Color kButton = Color(0xFF827397);
  static const Color kWhite = Color(0xFFF7F5F2);
  static const Color kBlack = Color(0xFF383838);

  /// Padding
  static const double kPaddingS = 8.0;
  static const double kPaddingM = 16.0;
  static const double kPaddingL = 32.0;

  /// Spacing
  static const double kSpaceS = 8.0;
  static const double kSpaceM = 16.0;

  ///Large
  static TextStyle large = GoogleFonts.poppins(
    color: Const.kBlack,
    fontWeight: FontWeight.bold,
    fontSize: 30.sp,
  );

  ///Medium
  static TextStyle bold = GoogleFonts.poppins(
    color: Const.kBlack,
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
  );

  /// Small
  static TextStyle medium = GoogleFonts.poppins(
    color: Const.kBlack,
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );
}

class RichWidget extends StatelessWidget {
  RichWidget({this.text, this.style, this.span});
  TextStyle? style;
  String? text;
  List<TextSpan>? span;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: text, style: style, children: span),
    );
  }
}

void showError({String? error, context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(error!, style: Const.medium.copyWith(color: Const.kWhite)),
    backgroundColor: Const.kheader,
  ));
}

void showMessage({String? message, context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message!,
      style: Const.medium.copyWith(color: Const.kWhite),
    ),
    backgroundColor: Const.kheader,
  ));
}
