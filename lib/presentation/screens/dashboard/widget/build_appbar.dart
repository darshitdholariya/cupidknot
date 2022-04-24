import 'package:cupid/infrastructure/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application/constants.dart';
import '../../../../application/string.dart';
import '../../../../domain/model/auth_model.dart';
import '../../profile/widget/name_generator.dart';

class build_appbar extends StatelessWidget {
  const build_appbar({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    AuthModel? data = MyHydratedStorage().getUser();
    return SliverAppBar(
      pinned: true,
      collapsedHeight: 0,
      stretchTriggerOffset: 20,
      backgroundColor: Const.kheader,
      centerTitle: false,
      flexibleSpace: Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h),
        child: Row(
          children: [
            Text(
              Strings.dashboard,
              style:
                  Const.medium.copyWith(color: Const.kWhite, fontSize: 20.sp),
            ),
            const Spacer(),
            GestureDetector(
                onTap: onTap,
                child: NameIcon(
                  firstName: data!.data.userDetails.fullName,
                  backgroundColor: Const.kBody,
                  textColor: Const.kheader,
                ))
          ],
        ),
      ),
      floating: true,
      primary: true,
      titleSpacing: 0,
      toolbarHeight: 0,
      titleTextStyle: Const.bold.copyWith(color: Const.kWhite),
      title: Text(
        Strings.dashboard,
        style: Const.bold.copyWith(color: Const.kWhite),
      ),
      expandedHeight: 50.0,
    );
  }
}
