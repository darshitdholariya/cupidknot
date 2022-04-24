import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid/infrastructure/local_storage/local_storage.dart';
import 'package:cupid/presentation/router/routes.dart';
import 'package:cupid/presentation/screens/dashboard/widget/build_appbar.dart';
import 'package:cupid/presentation/screens/dashboard/widget/build_floatingButton.dart';
import 'package:cupid/presentation/screens/dashboard/widget/build_showmodelsheet.dart';
import 'package:cupid/presentation/screens/profile/widget/name_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/constants.dart';
import '../../../application/string.dart';
import '../../../domain/model/auth_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../infrastructure/firebase/firebase.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  AuthModel? data;
  @override
  void initState() {
    data = MyHydratedStorage().getUser();
    FirebaseRepo().getContact(data!.data.userDetails.id.toString());
    super.initState();
  }

  TextEditingController? name = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? mob = TextEditingController();
  static final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingButton(ontap: () async {
              await buildShowModalBottomSheet(context, _orderFormKey,
                  name: name, email: email, data: data, mob: mob);
            }),
            backgroundColor: Const.kBody,
            body: CustomScrollView(slivers: [
              build_appbar(
                onTap: () => Navigator.pushNamed(context, AppRouter.profile),
              ),
              StreamBuilder<QuerySnapshot<Object?>>(
                  stream: FirebaseRepo()
                      .getContact(data!.data.userDetails.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  height: 50.h,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        NameIcon(
                                            firstName:
                                                '${snapshot.data!.docs[index].get(
                                              'full_name',
                                            )}',
                                            backgroundColor: Const.kheader,
                                            textColor: Const.kWhite),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${snapshot.data!.docs[index].get(
                                                  'email',
                                                )}',
                                                style: Const.medium.copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Const.kBackground,
                                                )),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                                '${snapshot.data!.docs[index].get(
                                                  'contactNumber',
                                                )}',
                                                style: Const.bold.copyWith(
                                                  fontSize: 10.sp,
                                                  color: Const.kBackground,
                                                )),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            FirebaseRepo().deleteContact(
                                                data!.data.userDetails.id
                                                    .toString(),
                                                index);
                                            setState(() {});
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Const.kheader,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: snapshot.data!.docs.length,
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: 1.sh,
                            width: 1.sw,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.image.nodata.image(fit: BoxFit.fitWidth),
                                SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 50.h,
                                    margin: const EdgeInsets.symmetric(
                                            horizontal: 60)
                                        .r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: Const.kheader,
                                    ),
                                    child: Center(
                                      child: Text(
                                        Strings.refresh,
                                        style: Const.bold.copyWith(
                                            decoration: TextDecoration.none,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
            ])));
  }
}
