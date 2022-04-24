import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application/constants.dart';

class TextField_Register extends StatelessWidget {
  const TextField_Register({
    Key? key,
    this.hint,
    required this.orderFormKey,
    this.controller,
  }) : super(key: key);
  final String? hint;
  final TextEditingController? controller;
  final GlobalKey<FormState> orderFormKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10).r,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextFormField(
        // key: orderFormKey,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field can\'t be empty';
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: Const.medium.copyWith(color: Colors.grey)),
      ),
    );
  }
}
