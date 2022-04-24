import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application/constants.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    this.ontap,
    Key? key,
  }) : super(key: key);
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Const.kButton.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 3,
                offset: const Offset(0, 4),
              )
            ],
            color: Const.kheader,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Const.kWhite,
              size: 30.r,
            ),
          )),
    );
  }
}
