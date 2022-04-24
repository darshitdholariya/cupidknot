import 'package:cupid/application/constants.dart';
import 'package:cupid/gen/assets.gen.dart';
import 'package:cupid/presentation/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/model/auth_model.dart';
import '../../../infrastructure/local_storage/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AuthModel? data = MyHydratedStorage().getUser();
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        data != null ? AppRouter.dashBoard : AppRouter.login,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Const.kBackground,
      body: Container(
        color: Const.kBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                  tag: 'LOGIN',
                  child:
                      Assets.image.contacts.image(height: 120.h, width: 80.w)),
              const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Const.kBody),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
