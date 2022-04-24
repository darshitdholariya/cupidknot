import 'package:flutter/material.dart';

import '../../../../application/constants.dart';

class NameIcon extends StatelessWidget {
  final String firstName;
  final Color backgroundColor;
  final Color textColor;

  const NameIcon({
    Key? key,
    required this.firstName,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  String get firstLetter => this.firstName.substring(0, 1).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: this.backgroundColor,
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(this.firstLetter,
            style: Const.medium.copyWith(
              color: this.textColor,
            )),
      ),
    );
  }
}
