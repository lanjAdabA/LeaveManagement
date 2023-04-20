import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/constant.dart';
import 'package:leavemanagementadmin/constant/login_emailcheck.dart';
import 'package:leavemanagementadmin/constant/login_numbercheck.dart';
import 'package:leavemanagementadmin/logic/Authflow/auth_flow_cubit.dart';
import 'package:leavemanagementadmin/logic/loginCubit/cubit/login_bymail_cubit.dart';
import 'package:leavemanagementadmin/logic/loginCubit/cubit/login_verifybymail_cubit.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailorphoncontroller = TextEditingController();
  TextEditingController verifymailotpcontroller = TextEditingController();

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 120);
  bool isresend = false;
  bool istimeout = false;
  bool issend = false;
  bool showsendbutton = false;
  bool is30second = false;

  final FocusNode _passwordFocusNode = FocusNode();

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    setState(() {
      if (seconds < 0) {
        countdownTimer!.cancel();

        isresend = true;
        istimeout = true;
      } else if (seconds < 31) {
        is30second = true;
        myDuration = Duration(seconds: seconds);
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 120));
  }

  String strDigits(int n) => n.toString().padLeft(
        3,
      );

  @override
  void initState() {
    super.initState();
    setState(() {
      isresend = false;
      istimeout = false;
      issend = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final seconds = strDigits(myDuration.inSeconds);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var c = context.watch<LoginBymailCubit>();
    issend = c.state.issend;

    return BlocConsumer<LoginVerifybymailCubit, VerifyStatusformail>(
        listener: (context, state) {
      switch (state) {
        case VerifyStatusformail.initial:
          log('Initial');
          EasyLoading.show(status: 'Please Wait..');
          break;

        case VerifyStatusformail.loading:
          log('Loading');
          EasyLoading.show(status: 'Please Wait..');
          break;

        case VerifyStatusformail.loaded:
          Navigator.pop(context);
          EasyLoading.showToast(
            'Successfully Login',
          ).whenComplete(() => context.read<AuthFlowCubit>().getloginstatus());

          break;

        case VerifyStatusformail.error:
          context.router.pop();
          EasyLoading.showError(
            "Invalid OTP",
          );

          break;
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Center(
          child: Card(
            color: Colors.grey[100],
            elevation: 20,
            child: SizedBox(
              height: height / 1.8,
              width: width <= 700 ? width / 1.2 : width / 1.8,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey[100],
                        height: height / 3.8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: SizedBox(
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 90,
                                    child: Image.asset(
                                        "assets/images/G-png-only.png")),
                                Padding(
                                  padding: width <= 600
                                      ? const EdgeInsets.symmetric(
                                          vertical: 2.0)
                                      : const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                  child: width <= 1000
                                      ? const Text(
                                          "Leave Management System",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : const Text(
                                          "Leave Management System",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                ),
                                width <= 1000
                                    ? const Text("Admin Panel",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))
                                    : const Text(
                                        "Admin Panel",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                              ],
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Center(
                            child: SizedBox(
                              // color: Colors.amber,
                              height: height / 2.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: height / 32,
                                  ),
                                  TextFormField(
                                    onTap: () {
                                      setState(() {
                                        showsendbutton = true;
                                      });
                                    },
                                    enabled: issend ? false : true,

                                    controller: emailorphoncontroller,
                                    autovalidateMode: AutovalidateMode.always,
                                    autofillHints: const [AutofillHints.email],
                                    //not for form, this will make the input suggest that the field wants email as input
                                    decoration: InputDecoration(
                                        // fillColor: Colors.amber,
                                        suffix: showsendbutton
                                            ? TextButton(
                                                // style: TextButton.styleFrom(
                                                //     backgroundColor: Colors.blue),
                                                onPressed: issend
                                                    ? null
                                                    : () {
                                                        if (emailorphoncontroller
                                                            .text.isEmpty) {
                                                          EasyLoading.showToast(
                                                              'Email or Phone Cannot be Empty');
                                                        } else if (isEmail(
                                                            emailorphoncontroller
                                                                .text)) {
                                                          context
                                                              .read<
                                                                  LoginBymailCubit>()
                                                              .emaillogin(
                                                                  email:
                                                                      emailorphoncontroller
                                                                          .text)
                                                              .then((value) =>
                                                                  startTimer());

                                                          //send email to api
                                                        } else if (isValidPhoneNumber(
                                                            emailorphoncontroller
                                                                .text)) {
                                                          context
                                                              .read<
                                                                  LoginBymailCubit>()
                                                              .phonelogin(
                                                                  phonenumber:
                                                                      emailorphoncontroller
                                                                          .text)
                                                              .then((value) {
                                                            startTimer();
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    _passwordFocusNode);
                                                          });
                                                        } else {
                                                          EasyLoading.showToast(
                                                              "Invalid Email or Phone Number");
                                                        }
                                                      },
                                                child: Text(
                                                  "Send OTP",
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.account_circle_outlined),
                                        border: const OutlineInputBorder(),
                                        labelText: "Enter email/ Phone no. :",
                                        hintText: "example@globizs.com",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),

                                    cursorColor: Colors.red,
                                  ),
                                  SizedBox(
                                    height: height / 48,
                                  ),
                                  TextFormField(
                                    focusNode: _passwordFocusNode,
                                    controller: verifymailotpcontroller,
                                    autovalidateMode: AutovalidateMode.always,
                                    autofillHints: const [AutofillHints.email],
                                    //not for form, this will make the input suggest that the field wants email as input
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                            Icons.lock_outline_rounded),
                                        border: const OutlineInputBorder(),
                                        labelText: "OTP : ",
                                        hintText: " Enter OTP",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),

                                    cursorColor: Colors.red,
                                  ),
                                  SizedBox(
                                    height: height / 46,
                                  ),
                                  issend
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            istimeout
                                                ? const Text(
                                                    'Didn\'t recieved code?')
                                                : Row(
                                                    children: [
                                                      const Text(
                                                          "Time remaining : "),
                                                      Text(
                                                        "${seconds}s",
                                                        style: TextStyle(
                                                            color: is30second
                                                                ? Colors.red
                                                                : Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                            TextButton(
                                                onPressed: isresend
                                                    ? () {
                                                        if (isEmail(
                                                            emailorphoncontroller
                                                                .text)) {
                                                          context
                                                              .read<
                                                                  LoginBymailCubit>()
                                                              .emaillogin_forreset(
                                                                  email:
                                                                      emailorphoncontroller
                                                                          .text);
                                                          resetTimer();
                                                          startTimer();
                                                          setState(() {
                                                            isresend = false;
                                                            istimeout = false;
                                                          });

                                                          //send email to api
                                                        } else if (isValidPhoneNumber(
                                                            emailorphoncontroller
                                                                .text)) {
                                                          context
                                                              .read<
                                                                  LoginBymailCubit>()
                                                              .phonelogin_forreset(
                                                                  phonenumber:
                                                                      emailorphoncontroller
                                                                          .text);
                                                          resetTimer();
                                                          startTimer();
                                                          setState(() {
                                                            isresend = false;
                                                            istimeout = false;
                                                          });
                                                        }
                                                      }
                                                    : null,
                                                child: const Text(
                                                  "Resend OTP",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ))
                                          ],
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: height / 46,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      countdownTimer!.cancel();
                                      if (emailorphoncontroller.text.isEmpty &&
                                          verifymailotpcontroller
                                              .text.isEmpty) {
                                        EasyLoading.showToast(
                                            'Email or Phone Cannot be Empty');
                                      } else if (emailorphoncontroller
                                          .text.isEmpty) {
                                        EasyLoading.showToast(
                                            'Email Cannot be Empty');
                                      } else if (verifymailotpcontroller
                                          .text.isEmpty) {
                                        EasyLoading.showToast(
                                            'OTP Cannot be Empty');
                                      } else if (isEmail(
                                          emailorphoncontroller.text)) {
                                        context
                                            .read<LoginVerifybymailCubit>()
                                            .verifymail(
                                                email:
                                                    emailorphoncontroller.text,
                                                otp: verifymailotpcontroller
                                                    .text,
                                                userorphone: 'username');

                                        //send email to api
                                      } else if (isValidPhoneNumber(
                                          emailorphoncontroller.text)) {
                                        context
                                            .read<LoginVerifybymailCubit>()
                                            .verifymail(
                                                email:
                                                    emailorphoncontroller.text,
                                                otp: verifymailotpcontroller
                                                    .text,
                                                userorphone: 'phone');
                                      } else {
                                        EasyLoading.showToast(
                                            "Invalid Email or Phone Number");
                                      }
                                    },
                                    child: Center(
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          //set border radius more than 50% of height and width to make circle
                                        ),
                                        child: const CardWidget(
                                            gradient: [
                                              Color.fromARGB(255, 211, 32, 39),
                                              Color.fromARGB(255, 164, 92, 95)
                                            ],
                                            width: 340,
                                            height: 48,
                                            borderRadius: 13,
                                            child: Center(
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
