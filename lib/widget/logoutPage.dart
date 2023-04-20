import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leavemanagementadmin/Interceptor/storetoken.dart';
import 'package:leavemanagementadmin/constant.dart';
import 'package:leavemanagementadmin/logic/Authflow/auth_flow_cubit.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({super.key});

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 20,
          child: Container(
            height: height / 1.8,
            width: width / 1.8,
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey[100],
                      height: height / 4,
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
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Leave Management System",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const Text(
                                "Admin Panel",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Form(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 120,
                              ),
                              const Text(
                                "Logout ?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.router.replaceNamed('/');
                                        },
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            //set border radius more than 50% of height and width to make circle
                                          ),
                                          child: CardWidget(
                                              gradient: const [
                                                Color.fromARGB(
                                                    255, 219, 217, 217),
                                                Color.fromARGB(
                                                    255, 246, 244, 244)
                                              ],
                                              width: 120,
                                              height: 32,
                                              borderRadius: 13,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.cancel,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      "Not now",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Store.clear().whenComplete(() {
                                            context
                                                .read<AuthFlowCubit>()
                                                .getloginstatus();
                                          });
                                        },
                                        child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            //set border radius more than 50% of height and width to make circle
                                          ),
                                          child: CardWidget(
                                              gradient: const [
                                                Color.fromARGB(
                                                    255, 211, 32, 39),
                                                Color.fromARGB(255, 164, 92, 95)
                                              ],
                                              width: 120,
                                              height: 32,
                                              borderRadius: 13,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                        ),
                      ]),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
