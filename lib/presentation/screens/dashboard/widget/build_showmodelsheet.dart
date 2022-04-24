import 'package:cupid/domain/model/auth_model.dart';
import 'package:cupid/infrastructure/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application/constants.dart';
import '../../../../application/string.dart';
import '../../../../gen/assets.gen.dart';
import '../../auth_screen/widget/txt_field.dart';

buildShowModalBottomSheet(BuildContext context, _orderFormKey,
    {AuthModel? data,
    TextEditingController? name,
    TextEditingController? email,
    TextEditingController? mob}) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (contedxt, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            decoration: const BoxDecoration(
              color: Const.kBody,
            ),
            child: BlocConsumer<DashboardBloc, DashboardState>(
              listener: (context, state) {
                if (state is AddContactLoaded) {
                  showMessage(
                      context: contedxt, message: 'Successfully Added Contact');
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Container(
                          height: 2.h, width: 50.w, color: Const.kheader),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Assets.image.contacts.image(width: 30.w, height: 30.h),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          Strings.addContact,
                          style: Const.bold.copyWith(
                            color: Const.kheader,
                            fontSize: 18.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Const.kWhite,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]),
                      child: Form(
                        key: _orderFormKey,
                        child: Column(
                          children: [
                            TextField_Register(
                              hint: Strings.name,
                              controller: name,
                              orderFormKey: _orderFormKey,
                            ),
                            TextField_Register(
                              hint: Strings.phone,
                              orderFormKey: _orderFormKey,
                              controller: mob,
                            ),
                            TextField_Register(
                              hint: Strings.email,
                              orderFormKey: _orderFormKey,
                              controller: email,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final form = _orderFormKey.currentState;
                        if (form!.validate()) {
                          BlocProvider.of<DashboardBloc>(context).add(
                              AddContact(
                                  email: email!.text,
                                  name: name!.text,
                                  id: data!.data.userDetails.id.toString(),
                                  phone: mob!.text));
                          email.clear();
                          name.clear();
                          mob.clear();
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: 50.h,
                        margin: const EdgeInsets.symmetric(horizontal: 60).r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: Const.kheader,
                        ),
                        child: Center(
                          child: Text(
                            Strings.add,
                            style: Const.bold.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
      });
}
