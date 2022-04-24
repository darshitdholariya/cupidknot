import 'package:cupid/application/constants.dart';
import 'package:cupid/infrastructure/bloc/dashboard/dashboard_bloc.dart';
import 'package:cupid/infrastructure/local_storage/local_storage.dart';
import 'package:cupid/presentation/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../application/string.dart';
import '../auth_screen/widget/txt_field.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  static final GlobalKey<FormFieldState<String>> _orderFormKey =
      GlobalKey<FormFieldState<String>>();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? email = TextEditingController();

  TextEditingController? name = TextEditingController();

  TextEditingController? pass = TextEditingController();

  TextEditingController? conPass = TextEditingController();

  TextEditingController? mob = TextEditingController();

  String? disGender;

  DateTime selectedDate = DateTime.now();
  static final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1810, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(const GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Const.kBody,
      appBar: AppBar(
        backgroundColor: Const.kheader,
        elevation: 6,
        title: Text(
          Strings.profile,
          style: Const.bold.copyWith(fontSize: 18.sp, color: Const.kWhite),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              MyHydratedStorage().clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRouter.login, (route) => false);
            },
            child: const Icon(
              Icons.login_outlined,
              color: Const.kBody,
            ),
          ),
          SizedBox(
            width: 15.w,
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              name!.text = state.data!.data.userDetails.name;
              mob!.text = state.data!.data.userDetails.mobileNo;
              disGender = state.data!.data.userDetails.gender;
              selectedDate = state.data!.data.userDetails.dob;
            }
          },
          builder: (context, state) {
            if (state is FirebaseLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30.h,
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
                            child: Column(
                              children: <Widget>[
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
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 8.w, left: 8.w),
                                  child: DropdownButton<String>(
                                    value: disGender,
                                    focusColor: Const.kWhite,
                                    underline: Container(),
                                    hint: Text(Strings.male,
                                        style: Const.medium.copyWith(
                                            fontSize: 14.sp,
                                            color: Const.kheader)),
                                    isExpanded: true,
                                    alignment: AlignmentDirectional.centerStart,
                                    style: Const.medium.copyWith(
                                        fontSize: 14.sp, color: Const.kheader),
                                    iconSize: 14.w,
                                    items: <String>[
                                      'MALE',
                                      'FEMALE',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: Const.medium.copyWith(
                                                fontSize: 14.sp,
                                                color: Const.kheader)),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        disGender = val;
                                      });
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(10).r,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey[200]!))),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          selectedDate != null
                                              ? DateFormat('yyy-MM-dd')
                                                  .format(selectedDate)
                                                  .split(' ')[0]
                                              : Strings.dob,
                                          style: Const.medium
                                              .copyWith(color: Colors.grey)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<DashboardBloc>(context).add(
                                  UpdateProfile(
                                      gender: disGender,
                                      dob: DateFormat('yyy-MM-dd')
                                          .format(selectedDate)
                                          .split(' ')[0],
                                      name: name!.text,
                                      phone: mob!.text));
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Const.kheader,
                              ),
                              child: Center(
                                child: Text(
                                  Strings.save,
                                  style:
                                      Const.bold.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
