import 'package:cupid/application/constants.dart';
import 'package:cupid/gen/assets.gen.dart';
import 'package:cupid/infrastructure/bloc/auth_bloc/auth_bloc.dart';
import 'package:cupid/presentation/router/routes.dart';
import 'package:cupid/presentation/screens/auth_screen/widget/txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/string.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController? email = TextEditingController();
  final TextEditingController? password = TextEditingController();

  fetchLogin(context) async {
    final form = _orderFormKey.currentState;
    if (form!.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(FetchLogin(email: email!.text, pass: password!.text));
    }
  }

  final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthLoaded) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRouter.dashBoard, (route) => false);
            showMessage(context: context, message: state.dataModel!.message);
          } else if (state is AuthError) {
            showError(context: context, error: state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    Hero(
                      tag: 'LOGIN',
                      child: Center(
                        child: SizedBox(
                          height: 80.h,
                          width: 80.w,
                          child: Assets.image.contacts
                              .image(width: 60.w, height: 60.h),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Strings.login,
                            style: Const.bold.copyWith(
                                color: const Color.fromRGBO(49, 39, 79, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Const.kWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromRGBO(196, 135, 198, .3),
                                    blurRadius: 20.r,
                                    offset: const Offset(0, 10),
                                  )
                                ]),
                            child: Form(
                              key: _orderFormKey,
                              child: Column(
                                children: <Widget>[
                                  TextField_Register(
                                    orderFormKey: _orderFormKey,
                                    hint: Strings.email,
                                    controller: email,
                                  ),
                                  TextField_Register(
                                    hint: Strings.password,
                                    orderFormKey: _orderFormKey,
                                    controller: password,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                              child: Text(
                            Strings.forgetPass,
                            style: Const.medium.copyWith(
                                color: const Color.fromRGBO(196, 135, 198, 1)),
                          )),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () => fetchLogin(context),
                            child: Container(
                              height: 50.h,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Const.kheader,
                              ),
                              child: Center(
                                child: Text(
                                  Strings.login,
                                  style:
                                      Const.bold.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamedAndRemoveUntil(
                                context, AppRouter.register, (route) => false),
                            child: Center(
                                child: Text(
                              Strings.createAc,
                              style:
                                  Const.medium.copyWith(color: Const.kheader),
                            )),
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
