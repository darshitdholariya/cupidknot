import 'package:cupid/application/constants.dart';
import 'package:cupid/infrastructure/bloc/auth_bloc/auth_bloc.dart';
import 'package:cupid/presentation/router/routes.dart';
import 'package:cupid/presentation/screens/auth_screen/widget/txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../application/string.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  fetchRegister(context) async {
    final form = _orderFormKey.currentState;
    if (form!.validate()) {
      if (disGender != null && selectedDate != null) {
        BlocProvider.of<AuthBloc>(context).add(FetchRegister(
            email: email!.text,
            pass: pass!.text,
            gender: disGender,
            dob: DateFormat('yyy-MM-dd').format(selectedDate).split(' ')[0],
            confirmPass: conPass!.text,
            name: name!.text,
            phone: mob!.text));
      } else {
        showError(error: 'Please select Dob and Gender', context: context);
      }
    }
  }

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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Strings.register,
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
                                children: <Widget>[
                                  TextField_Register(
                                    hint: Strings.name,
                                    controller: name,
                                    orderFormKey: _orderFormKey,
                                  ),
                                  TextField_Register(
                                    hint: Strings.email,
                                    orderFormKey: _orderFormKey,
                                    controller: email,
                                  ),
                                  TextField_Register(
                                    hint: Strings.phone,
                                    orderFormKey: _orderFormKey,
                                    controller: mob,
                                  ),
                                  TextField_Register(
                                    hint: Strings.password,
                                    orderFormKey: _orderFormKey,
                                    controller: pass,
                                  ),
                                  TextField_Register(
                                    orderFormKey: _orderFormKey,
                                    hint: Strings.conPass,
                                    controller: conPass,
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
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      style: Const.medium.copyWith(
                                          fontSize: 14.sp,
                                          color: Const.kheader),
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
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () => fetchRegister(context),
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color.fromRGBO(49, 39, 79, 1),
                              ),
                              child: Center(
                                child: Text(
                                  Strings.register,
                                  style:
                                      Const.bold.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamedAndRemoveUntil(
                                context, AppRouter.login, (route) => false),
                            child: Center(
                                child: Text(
                              Strings.alreadyAc,
                              style: Const.medium.copyWith(
                                  color: const Color.fromRGBO(49, 39, 79, .6)),
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
