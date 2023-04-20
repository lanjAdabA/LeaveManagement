import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/constant.dart';
import 'package:leavemanagementadmin/logic/branch/create_branch_cubit.dart';
import 'package:leavemanagementadmin/logic/branch/create_branch_state.dart';
import 'package:leavemanagementadmin/logic/branch/delete_branch_cubit.dart';
import 'package:leavemanagementadmin/logic/branch/getallbranch_cubit.dart';
import 'package:leavemanagementadmin/logic/branch/update_branch_cubit.dart';
import 'package:leavemanagementadmin/logic/branch/update_branch_state.dart';

import 'package:leavemanagementadmin/model/branch_list.dart';

class BranchPage extends StatefulWidget {
  const BranchPage({Key? key}) : super(key: key);

  @override
  _BranchPageState createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  TextEditingController namecontroller = TextEditingController();
  bool isactive = false;
  final String avtive = "";

  List<DataCell> displayedDataCell = [];

  @override
  void initState() {
    super.initState();
    context.read<GetallbranchCubit>().getallbranch();
  }

  void getbranchlist(List<AllBranchList> getbranchlist) async {
    for (var item in getbranchlist) {
      displayedDataCell.add(
        DataCell(
          Text(
            (getbranchlist.indexOf(item) + 1).toString(),
          ),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Text(item.name),
        ),
      );

      displayedDataCell.add(
        DataCell(Text(item.isActive == "1" ? "Active" : "Inactive",
            style: item.isActive == "1"
                ? const TextStyle(color: Color.fromARGB(255, 91, 203, 95))
                : TextStyle(color: Colors.red[200]))),
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
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[400],
                                        // side: const BorderSide(
                                        //     color: Colors.grey)
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("CANCEL")),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (namecontroller.text.isEmpty ||
                                            namecontroller.text.isEmpty) {
                                          EasyLoading.showError(
                                              'Name field is empty');
                                        } else {
                                          if (namecontroller.text.length < 5) {
                                            EasyLoading.showToast(
                                                "Name must be longer than or equal to 5 characters ");
                                          } else {
                                            context
                                                .read<UpdateBranchCubit>()
                                                .updatebranch(
                                                    branchname:
                                                        namecontroller.text,
                                                    id: item.id,
                                                    isactive: isactive == true
                                                        ? "1"
                                                        : "0");

                                            namecontroller.clear();
                                            isactive = false;
                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                      child: Material(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        elevation: 15,
                                        child: const CardWidget(
                                            color: Colors.green,
                                            width: 70,
                                            height: 30,
                                            borderRadius: 5,
                                            child: Center(
                                              child: Text(
                                                'Update',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      )),
                                ],
                              )
                            ],
                            title: const Text(
                              "Update Branch",
                            ),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Column(
                                children: [
                                  TextFormField(
                                    autofocus: true,
                                    controller: namecontroller,
                                    decoration: const InputDecoration(
                                      hintText: "Department Name",
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
                                          .read<DeleteBranchCubit>()
                                          .deletebranch(item.id);
                                      Navigator.pop(context);
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
    return BlocConsumer<GetallbranchCubit, GetallbranchState>(
      listener: (context, state) {
        getbranchlist(state.allbranchlist);
      },
      builder: (context, state2) {
        return BlocConsumer<UpdateBranchCubit, UpdateBranchStatus>(
          listener: (context, state3) {
            switch (state3) {
              case UpdateBranchStatus.initial:
                break;
              case UpdateBranchStatus.loading:
                EasyLoading.show(status: 'Update Branch..');
                break;
              case UpdateBranchStatus.loaded:
                EasyLoading.showToast(' Successfully Updated').whenComplete(() {
                  displayedDataCell.clear();
                  context.read<GetallbranchCubit>().getallbranch();
                });

                break;
              case UpdateBranchStatus.error:
                EasyLoading.showError('Error');
                break;
            }
          },
          builder: (context, state) {
            return BlocConsumer<BranchCubit, BranchStatus>(
              listener: (context, state) {
                switch (state) {
                  case BranchStatus.initial:
                    break;
                  case BranchStatus.loading:
                    EasyLoading.show(status: 'Addiing Branch..');
                    break;
                  case BranchStatus.loaded:
                    EasyLoading.showToast('Added Successfully')
                        .whenComplete(() {
                      displayedDataCell.clear();
                      context.read<GetallbranchCubit>().getallbranch();
                    });

                    break;
                  case BranchStatus.error:
                    EasyLoading.showError('Error');
                    break;
                }
              },
              builder: (context, state2) {
                return Scaffold(
                  backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                  body: Column(children: [
                    const SizedBox(
                      height: 35,
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
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Branch",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: MediaQuery.of(context).size.width > 1040
                          ? const EdgeInsets.only(left: 50, top: 13)
                          : const EdgeInsets.only(left: 10, top: 13),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () {
                              namecontroller.clear();
                              isactive = false;

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Add new Branch",
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
                                                controller: namecontroller,
                                                decoration:
                                                    const InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 212, 211, 211)),
                                                  hintText: "Branch Name",
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey[300],
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.blueGrey),
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
                                                          .read<BranchCubit>()
                                                          .addbranch(
                                                            branchname:
                                                                namecontroller
                                                                    .text,
                                                          );

                                                      namecontroller.clear();
                                                      isactive = false;

                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Material(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
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
                                        'Add Branch',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
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
                              dataRowHeight: 43,
                              dividerThickness: 2,
                              headingTextStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              headingRowColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey.withOpacity(0.2)),
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
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Sl.no',
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Branch Name',
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'IsActive',
                                  ),
                                ),
                                DataColumn(
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
