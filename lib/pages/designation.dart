import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Skeleton/skeleton.dart';
import 'package:leavemanagementadmin/constant.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/delete_design_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/delete_design_state.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/get_alldesign_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/post_designation_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/update_design_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/update_design_state.dart';
import 'package:leavemanagementadmin/model/design_listmodel.dart';

class DesignationPage extends StatefulWidget {
  /// Creates the home page.
  const DesignationPage({Key? key}) : super(key: key);

  @override
  _BranchPageState createState() => _BranchPageState();
}

class _BranchPageState extends State<DesignationPage> {
  TextEditingController namecontroller = TextEditingController();
  bool isactive = false;

  List<DataCell> displayedDataCell = [];

  @override
  void initState() {
    super.initState();
    context.read<GetAlldesignCubit>().getalldesign();
  }

  void getalldesignation(List<AllDesignModel> alldesignlist) async {
    for (var item in alldesignlist) {
      displayedDataCell.add(
        DataCell(
          Text(
            (alldesignlist.indexOf(item) + 1).toString(),
          ),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Text(
            item.name,
          ),
        ),
      );

      displayedDataCell.add(
        DataCell(
          Text(item.isActive == "1" ? "Active" : "Inactive",
              style: item.isActive == "1"
                  ? const TextStyle(color: Color.fromARGB(255, 91, 203, 95))
                  : TextStyle(color: Colors.red[200])),
        ),
      );

      displayedDataCell.add(
        DataCell(Row(
          children: [
            TextButton(
                onPressed: () {
                  namecontroller.text = item.name;
                  if (item.isActive == "1") {
                    setState(() {
                      isactive = true;
                    });
                  } else {
                    setState(() {
                      isactive = false;
                    });
                  }
                  showDialog(
                    context: context,
                    builder: (cnt) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return AlertDialog(
                            title: const Text(
                              "Update Designation",
                              style: TextStyle(fontSize: 18),
                            ),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Column(
                                children: [
                                  TextFormField(
                                    autofocus: true,
                                    controller: namecontroller,
                                    decoration: const InputDecoration(
                                      hintText: "Designation",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      const Text("Active : "),
                                      Switch(
                                        value: isactive,
                                        activeColor: const Color.fromARGB(
                                            255, 72, 217, 77),
                                        onChanged: (bool value) {
                                          setState(() {
                                            isactive = value;
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      onPressed: () {
                                        if (namecontroller.text.isEmpty) {
                                          EasyLoading.showError(
                                              'Name field is empty');
                                        } else {
                                          if (namecontroller.text.length < 5) {
                                            EasyLoading.showToast(
                                                "Name must be longer than or equal to 5 characters ");
                                          } else {
                                            context
                                                .read<UpdateDesignCubit>()
                                                .updatedesign(
                                                    designname:
                                                        namecontroller.text,
                                                    id: item.id,
                                                    isactive:
                                                        isactive ? "1" : "0");

                                            namecontroller.clear();
                                            isactive = false;
                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "Update",
                                        style: TextStyle(fontSize: 17),
                                      )),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                child: const OnHoverButton2(child: Icon(Icons.edit))),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "CANCEL",
                                      style: TextStyle(color: Colors.blueGrey),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      context
                                          .read<DeleteDesignCubit>()
                                          .deletedesign(id: item.id);
                                      Navigator.pop(context);
                                      EasyLoading.showToast(
                                          "Successfully Deleted");
                                    },
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      elevation: 15,
                                      child: const CardWidget(
                                          color: Colors.green,
                                          width: 70,
                                          height: 30,
                                          borderRadius: 5,
                                          child: Center(
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    )),
                              ],
                            )
                          ],
                          title: const Text("Are you sure to delete"),
                        );
                      },
                    );
                  },
                );
              },
              child: const OnHoverButton2(
                child: Icon(
                  Icons.delete,
                  size: 19,
                ),
              ),
            ),
          ],
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAlldesignCubit, GetAlldesignState>(
      listener: (context, state) {
        getalldesignation(state.alldesignlist);
      },
      builder: (context, state2) {
        return BlocConsumer<UpdateDesignCubit, UpdateDesignStatus>(
          listener: (context, state3) {
            switch (state3) {
              case UpdateDesignStatus.initial:
                break;
              case UpdateDesignStatus.loading:
                EasyLoading.show(status: 'Updating Designation..');
                break;
              case UpdateDesignStatus.loaded:
                EasyLoading.showToast(' Successfully Updated').whenComplete(() {
                  displayedDataCell.clear();
                  context.read<GetAlldesignCubit>().getalldesign();
                });

                break;
              case UpdateDesignStatus.error:
                EasyLoading.showError(
                    'Name must be longer than or equal to 5 characters ');
                break;
            }
          },
          builder: (context, state) {
            return BlocConsumer<DeleteDesignCubit, DeleteDesignStatus>(
              listener: (context, state4) {
                switch (state4) {
                  case DeleteDesignStatus.initial:
                    break;
                  case DeleteDesignStatus.loading:
                    EasyLoading.show(status: 'Deleting....');
                    break;
                  case DeleteDesignStatus.loaded:
                    EasyLoading.showToast(' Successfully Delete')
                        .whenComplete(() {
                      displayedDataCell.clear();
                      context.read<GetAlldesignCubit>().getalldesign();
                    });

                    break;
                  case DeleteDesignStatus.error:
                    EasyLoading.showError(' ');
                    break;
                }
              },
              builder: (context, state) {
                return BlocConsumer<PostDesignationCubit, PostDesignStatus>(
                  listener: (context, state) {
                    switch (state) {
                      case PostDesignStatus.initial:
                        break;
                      case PostDesignStatus.loading:
                        EasyLoading.show(status: 'Addiing Designation..');
                        break;
                      case PostDesignStatus.loaded:
                        EasyLoading.showToast('Added Successfully')
                            .whenComplete(() {
                          displayedDataCell.clear();
                          context.read<GetAlldesignCubit>().getalldesign();
                        });

                        break;
                      case PostDesignStatus.error:
                        EasyLoading.showError(
                            'Name must be longer than or equal to 5 characters ');
                        break;
                    }
                  },
                  builder: (context, state) {
                    return Scaffold(
                      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                      body: Column(children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: MediaQuery.of(context).size.width > 1040
                              ? const EdgeInsets.only(
                                  left: 50,
                                )
                              : const EdgeInsets.only(
                                  left: 10,
                                ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Designation",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: MediaQuery.of(context).size.width > 1040
                              ? const EdgeInsets.only(left: 50, top: 15)
                              : const EdgeInsets.only(left: 10, top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  namecontroller.clear();
                                  isactive = false;

                                  showDialog(
                                    context: context,
                                    builder: (cnt) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return AlertDialog(
                                            title: const Text(
                                              "Add new Designation",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            content: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    autofocus: true,
                                                    controller: namecontroller,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              211,
                                                              211)),
                                                      hintText: "Designation",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey),
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        if (namecontroller
                                                                .text.isEmpty ||
                                                            namecontroller
                                                                .text.isEmpty) {
                                                          EasyLoading.showError(
                                                              'Name field is empty');
                                                        } else {
                                                          context
                                                              .read<
                                                                  PostDesignationCubit>()
                                                              .postdesignation(
                                                                  designation_name:
                                                                      namecontroller
                                                                          .text

                                                                  //isactive: isactive ? "1" : "0",
                                                                  );

                                                          namecontroller
                                                              .clear();
                                                          isactive = false;
                                                          Navigator.pop(
                                                              context);
                                                          EasyLoading.showToast(
                                                            "Successfully added",
                                                          );
                                                        }
                                                      },
                                                      child: Material(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                        ),
                                                        elevation: 15,
                                                        child: const CardWidget(
                                                            color: Colors.green,
                                                            width: 70,
                                                            height: 30,
                                                            borderRadius: 5,
                                                            child: Center(
                                                              child: Text(
                                                                'Add',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )),
                                                      )),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  elevation: 15,
                                  child: const OnHoverButton2(
                                    child: CardWidget(
                                        gradient: [
                                          Color.fromARGB(255, 211, 32, 39),
                                          Color.fromARGB(255, 164, 92, 95)
                                        ],
                                        width: 120,
                                        height: 40,
                                        borderRadius: 13,
                                        child: Center(
                                          child: Text(
                                            'Add Designation',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: MediaQuery.of(context).size.width > 1040
                                  ? const EdgeInsets.only(
                                      left: 50, right: 50, top: 20)
                                  : const EdgeInsets.only(
                                      left: 10, right: 10, top: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: DataTable2(
                                  empty: const Center(
                                    child: SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator()),
                                  ),
                                  fixedTopRows: 1,
                                  showBottomBorder: true,

                                  dividerThickness: 2,
                                  headingTextStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  headingRowColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) =>
                                              Colors.grey.withOpacity(0.2)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  // border: TableBorder.all(
                                  //     color: const Color.fromARGB(255, 159, 154, 154)),
                                  rows: <DataRow>[
                                    for (int i = 0;
                                        i < displayedDataCell.length;
                                        i += 4)
                                      DataRow(cells: [
                                        displayedDataCell[i],
                                        displayedDataCell[i + 1],
                                        displayedDataCell[i + 2],
                                        displayedDataCell[i + 3],
                                      ])
                                  ],
                                  columns: <DataColumn>[
                                    const DataColumn(
                                      label: Text(
                                        'Sl.no',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Row(
                                        children: const [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            'Designation',
                                          ),
                                          // SizedBox(
                                          //     height: 20,
                                          //     width: 100,
                                          //     //color: Colors.amber,
                                          //     child: TextField(
                                          //       decoration: InputDecoration(
                                          //           border:
                                          //               OutlineInputBorder()),
                                          // )
                                          // )
                                        ],
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Text(
                                        'IsActive',
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Text(
                                        'Action',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class OnHoverButton2 extends StatefulWidget {
  final Widget child;
  const OnHoverButton2({super.key, required this.child});

  @override
  State<OnHoverButton2> createState() => _OnHoverButton2State();
}

class _OnHoverButton2State extends State<OnHoverButton2> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.1);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
        transform: transform,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
