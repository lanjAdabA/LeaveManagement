import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:intl/intl.dart';
import 'package:leavemanagementadmin/constant.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/check_empcode_cubit.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/checkemailexist_cubit.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/create_employee_cubit.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/getemployeelist_cubit.dart';
import 'package:leavemanagementadmin/logic/branch/getallbranch_cubit.dart';
import 'package:leavemanagementadmin/logic/department/cubit/get_alldept_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/get_alldesign_cubit.dart';
import 'package:leavemanagementadmin/logic/leave/cubit/getallleavetype_cubit.dart';
import 'package:leavemanagementadmin/logic/leave/cubit/getallleavetype_forleavebalance_cubit.dart';
import 'package:leavemanagementadmin/logic/role/cubit/get_role_cubit.dart';
import 'package:leavemanagementadmin/model/emp%20_listmodel.dart';
import 'package:leavemanagementadmin/widget/filter.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../constant/debouncer.dart';
import '../logic/AddLeaveBal/cubit/add_leave_balance_cubit.dart';
import '../logic/Employee/cubit/updateemployee_cubit.dart';
import '../logic/leave_balance/cubit/leave_balance_cubit.dart';
import '../model/leave_balance.dart';
import '../widget/popupEditLeaveBal.dart';

final today = DateUtils.dateOnly(DateTime.now());

@RoutePage()
class LeaveBalancePage extends StatefulWidget {
  const LeaveBalancePage({Key? key}) : super(key: key);

  @override
  _LeaveBalancePageState createState() => _LeaveBalancePageState();
}

class _LeaveBalancePageState extends State<LeaveBalancePage> {
  List<Employee> employees = <Employee>[];
  bool isactive = false;
  String fillname = "";

  TextEditingController leaveappliedforcontroller = TextEditingController();
  TextEditingController leavereasoncontroller = TextEditingController();

  TextEditingController namesearchcontroller = TextEditingController();
  bool israngeselected = false;

//Dropdown Label String
  String dropdownbranchlabel = 'Select';
  String dropdownDepartmentlabel = 'Select';
  String dropdownDesignationlabel = 'Select';
  String dropdownLeaveatypelabel = 'Select';
  String? empsearchname;

  String empDropDownName = "";
  String leavetypeDropDownName = "";
  int? leavedropdownvalue;
  String leavecredit = '';
  bool? ismoreloading;
  List<String> allEmp = [];
  Map<dynamic, dynamic> empNameWithId = {};
  int datalimit = 15;
  ScrollController datatablescrollcontroller = ScrollController();
  @override
  void initState() {
    super.initState();
    readall();

    _selectedRadioTile = 1;
    selectedRadioTileforleave = 1;
    selectedRadioTileforgender = 1;
    // datatablescrollcontroller.addListener(() {
    //   if (datatablescrollcontroller.position.pixels ==
    //       datatablescrollcontroller.position.maxScrollExtent) {
    //     if (ismoreloading == false) {
    //       log('Item reach its limit');
    //     } else {
    //       setState(() {
    //         datalimit = datalimit + 15;
    //       });
    //       displayedDataCell.clear();
    //       context.read<GetemployeelistCubit>().getemployeelist(
    //           datalimit: datalimit,
    //           ismoredata: true,
    //           branchid: dropdownvalue_branchid,
    //           deptid: dropdownvalue_departmentid,
    //           desigid: dropdownvalue_designid,
    //           rolename: dropdownleavetypevalue);

    //       log('reach buttom');
    //     }
    //   }
    // });
  }

  final _debouncer = Debouncer(500);
  bool isfocus = false;
  int? _selectedRadioTile;

  int? selectedRadioTileforleave;
  int? selectedRadioTileforgender;

  void readall() {
    log('reading cubit.......');
    context.read<GetallleavetypeCubit>().getallleavetype();
    context
        .read<GetemployeelistCubit>()
        .getemployeelist(datalimit: datalimit, ismoredata: true);
    context.read<GetallbranchCubit>().getallbranch();
    context.read<GetAlldeptCubit>().getalldept();
    context.read<GetAlldesignCubit>().getalldesign();
    // context.read<GetRoleCubit>().getallrole();

    context.read<GetallleavetypeForleavebalanceCubit>().getallleavetype();

    context.read<GetLeaveBalanceCubit>().getleavebalance();
  }

  void fetchdata({
    required List<Employeeleaveblc> allemplist,
    // required Map<dynamic, dynamic> branchidwithname,
    // required Map<dynamic, dynamic> deptnamewithid,
    // required Map<dynamic, dynamic> designidwithname
  }) {
    log('Not empty');

    for (var item in allemplist) {
      log("All emplist : $allemplist");
      // if (branchidwithname.isNotEmpty &&
      //     deptnamewithid.isNotEmpty &&
      //     designidwithname.isNotEmpty) {
      //   log("Display datacell $displayedDataCell");

      displayedDataCell.add(
        DataCell(
          SizedBox(
            width: 20,
            child: Center(
              child: Text(
                (allemplist.indexOf(item) + 1).toString(),
              ),
            ),
          ),
        ),
      );

      displayedDataCell.add(
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(item.employeeName),
          ),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              item.branch,
            ),
          ),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(item.department),
          ),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(item.designation),
          ),
        ),
      );

      displayedDataCell.add(
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(item.leaveType),
        )),
      );
      displayedDataCell.add(
        DataCell(
          Center(
            child: Text(item.availableBalance),
          ),
        ),
      );

      displayedDataCell.add(
        DataCell(Center(
          child: FittedBox(
            child: TextButton(
                onPressed: item.leaveType == 'General' ||
                        item.leaveType == 'LWP'
                    ? null
                    : () {
                        // empcode.text = item.employeeEmpCode.toString();
                        // _namefieldcontroller.text = item.employeeName;
                        // numbercontroller.text = item.employeePhone;
                        // emailcontroller.text = item.email;

                        setState(() {
                          // dropdownvalue1 =
                          //     designidwithname[item.employeeDesignationId]
                          //         .toString();

                          // dropdownvalue2 =
                          //     deptnamewithid[item.employeeDepartmentId].toString();
                          // dropdownvalue3 = item.role;
                          // dropdownvalue4 =
                          //     branchidwithname[item.employeeBranchId].toString();
                        });

                        showDialog(
                          context: context,
                          builder: (cnt) {
                            return BlocConsumer<
                                GetallleavetypeForleavebalanceCubit,
                                GetallleavetypeForleavebalanceState>(
                              listener: (context, allLeaveTypeState) {
                                // TODO: implement listener
                              },
                              builder: (context, allLeaveTypeState) {
                                return StatefulBuilder(builder: (BuildContext
                                        context,
                                    void Function(void Function()) setState) {
                                  return EditLeaveBalPopUp(
                                    empName: item.employeeName,
                                    leavetype: item.leaveType,
                                    leavetypelist:
                                        allLeaveTypeState.allleavetypenamelist,
                                    creditnamewithid: allLeaveTypeState
                                        .alleavetypenamewithcredit,
                                  );
                                });
                              },
                            );
                          },
                        );
                      },
                child: item.leaveType == 'General' || item.leaveType == 'LWP'
                    ? const Text("Edit")
                    : const OnHoverButton(child: Text("Edit"))),
          ),
        )),
      );
      //}
    }
  }

  String? dropdownvalue_designname;
  int? dropdownvalue_designid;
  int? dropdownvalue_departmentid;
  String? dropdownvalue_departmentname;
  String? dropdownLeavetypeName;
  int? dropdownleavetypevalue;
  String? dropdownvalue_branchname;
  int? dropdownvalue_branchid;

  String? dropdownvalue1;
  int? dropdownvalue11;
  int? dropdownvalue22;
  String? dropdownvalue2;
  String? dropdownvalue3;
  int? dropdownvalue33;
  String? dropdownvalue4;
  int? dropdownvalue44;
  String? leavetypedropdown;
  int? leavetypedropdownid;
  final TextEditingController empcode = TextEditingController();
  final TextEditingController _namefieldcontroller = TextEditingController();

  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController numbercontroller = TextEditingController();

  final TextEditingController _namefieldcontroller2 = TextEditingController();

  String datetime = '';
  String startdate = '';
  String enddate = '';
  String startdatefinal = '';
  String enddatefinal = '';

  String datetime2 = '';
  String datetime3 = '';
  String datetime4 = '';

  var format = DateFormat("dd-MM-yyyy");

  @override
  void dispose() {
    _namefieldcontroller.dispose();
    _namefieldcontroller2.dispose();
    super.dispose();
  }

  @override
  List<DataCell> displayedDataCell = [];
  bool isempty = false;
  int index = 1;
  @override
  Widget build(BuildContext context) {
    String size = MediaQuery.of(context).size.width.toString();

    var role = context.watch<GetRoleCubit>();

    var roleidwithname = role.state.rolenamewithid;

    var allrolename = role.state.allrolenamelist;

    return BlocConsumer<UpdateemployeeCubit, UpdateEmployeeStatus>(
      listener: (context, updatestatus) {
        switch (updatestatus) {
          case UpdateEmployeeStatus.initial:
            break;
          case UpdateEmployeeStatus.loading:
            EasyLoading.show(status: 'Updating Employee..');
            break;
          case UpdateEmployeeStatus.loaded:
            EasyLoading.showToast('Updated Successfully').whenComplete(() {
              displayedDataCell.clear();
              context.read<GetallbranchCubit>().getallbranch();
              context.read<GetAlldeptCubit>().getalldept();
              context.read<GetAlldesignCubit>().getalldesign();
              context
                  .read<GetemployeelistCubit>()
                  .getemployeelist(datalimit: datalimit, ismoredata: true);
            });

            break;
          case UpdateEmployeeStatus.error:
            EasyLoading.showError('Error');
            break;
        }
      },
      builder: (context, updatestatus) {
        return BlocConsumer<CheckEmpcodeCubit, CheckEmpcodeState>(
          listener: (context, checkempState) {
            log('From Build${checkempState.isexist}');
          },
          builder: (context, checkempState) {
            log('From Build2 ${checkempState.isexist}');
            return BlocConsumer<GetallbranchCubit, GetallbranchState>(
              listener: (context, allbranchState) {},
              builder: (context, allbranchState) {
                return BlocConsumer<GetAlldeptCubit, GetAlldeptState>(
                  listener: (context, alldeptState) {},
                  builder: (context, alldeptState) {
                    return BlocConsumer<GetAlldesignCubit, GetAlldesignState>(
                      listener: (context, alldesignstate) {},
                      builder: (context, alldesignstate) {
                        return BlocConsumer<GetLeaveBalanceCubit,
                            GetLeaveBalanceState>(
                          listener: (context, leaveBalanceState) {
                            fetchdata(
                              allemplist: leaveBalanceState.leavebalancelist,
                            );
                          },
                          builder: (context, leaveBalanceState) {
                            return BlocConsumer<GetemployeelistCubit,
                                    PostState>(
                                listener: (context, getempoyeestate) {
                              if (getempoyeestate is PostErrorState) {
                                SnackBar snackBar = SnackBar(
                                  content: Text(getempoyeestate.error),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (getempoyeestate is PostinitialState) {
                              } else if (getempoyeestate is PostLoadingState) {
                              } else if (getempoyeestate is PostLoadedState) {
                                log('All Branch :${allbranchState.branchidwithname}');
                                log('All Dept :${alldeptState.deptidwithname}');
                                log('All Design :${alldesignstate.designidwithname}');
                                ismoreloading = getempoyeestate.isloading;
                                isempty = getempoyeestate.isempty;
                                allEmp = getempoyeestate.allempnamelist;
                                empNameWithId = getempoyeestate.emptidwithname;
                              }
                            }, builder: (context, getempoyeestate) {
                              return BlocConsumer<GetallleavetypeCubit,
                                  GetallleavetypeState>(
                                listener: (context, getallleavetype6State) {},
                                builder: (context, getallleavetype6State) {
                                  return BlocConsumer<
                                      GetallleavetypeForleavebalanceCubit,
                                      GetallleavetypeForleavebalanceState>(
                                    listener: (context, allLeaveTypeState) {},
                                    builder: (context, allLeaveTypeState) {
                                      return BlocConsumer<CreateEmployeeCubit,
                                          CreateEmployeeStatus>(
                                        listener: (context, creatempstate) {
                                          switch (creatempstate) {
                                            case CreateEmployeeStatus.initial:
                                              break;
                                            case CreateEmployeeStatus.loading:
                                              EasyLoading.show(
                                                  status: 'Adding Employee..');
                                              break;
                                            case CreateEmployeeStatus.loaded:
                                              displayedDataCell.clear();
                                              context
                                                  .read<GetemployeelistCubit>()
                                                  .getemployeelist(
                                                      datalimit: datalimit,
                                                      ismoredata: true);
                                              displayedDataCell.clear();
                                              context
                                                  .read<GetallbranchCubit>()
                                                  .getallbranch();
                                              context
                                                  .read<GetAlldeptCubit>()
                                                  .getalldept();
                                              context
                                                  .read<GetAlldesignCubit>()
                                                  .getalldesign();
                                              EasyLoading.showToast(
                                                  'Added Successfully');

                                              break;
                                            case CreateEmployeeStatus.error:
                                              EasyLoading.showError('Error');
                                              break;
                                          }
                                        },
                                        builder: (context, creatempstate) {
                                          log(checkempState.isexist);
                                          return BlocConsumer<
                                              AddLeaveBalanceCubit,
                                              AddLeaveBalanceStatus>(
                                            listener: (context, addleavestate) {
                                              switch (addleavestate) {
                                                case AddLeaveBalanceStatus
                                                    .initial:
                                                  // TODO: Handle this case.
                                                  break;
                                                case AddLeaveBalanceStatus
                                                    .loading:
                                                  // TODO: Handle this case.
                                                  break;
                                                case AddLeaveBalanceStatus
                                                    .loaded:
                                                  displayedDataCell.clear();
                                                  context
                                                      .read<
                                                          GetLeaveBalanceCubit>()
                                                      .getleavebalance();
                                                  // fetchdata(
                                                  //   allemplist:
                                                  //       leaveBalanceState
                                                  //           .leavebalancelist,
                                                  // );
                                                  break;
                                                case AddLeaveBalanceStatus
                                                    .error:
                                                  // TODO: Handle this case.
                                                  break;
                                              }
                                            },
                                            builder: (context, addleavestate) {
                                              return Scaffold(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 245, 245, 245),
                                                body: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      Padding(
                                                        padding: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width >
                                                                1040
                                                            ? const EdgeInsets
                                                                .only(
                                                                left: 50,
                                                              )
                                                            : const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                              ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              'Leave Balance ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          50.0),
                                                              child: ElevatedButton.icon(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey),
                                                                  onPressed:
                                                                      () {},
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .download),
                                                                  label: const Text(
                                                                      "Download")),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width >
                                                                1040
                                                            ? const EdgeInsets
                                                                    .only(
                                                                left: 50,
                                                                top: 15)
                                                            : const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 15),
                                                        child: InkWell(
                                                            onTap: () {
                                                              _namefieldcontroller
                                                                  .clear();
                                                              usernamecontroller
                                                                  .clear();
                                                              emailcontroller
                                                                  .clear();
                                                              numbercontroller
                                                                  .clear();
                                                              empcode.clear();
                                                              setState(() {
                                                                datetime2 = '';
                                                              });
                                                              dropdownvalue1 =
                                                                  null;
                                                              dropdownvalue2 =
                                                                  null;
                                                              dropdownvalue3 =
                                                                  null;
                                                              dropdownvalue4 =
                                                                  null;
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (cnt) {
                                                                  log('From Showdialog :${checkempState.isexist}');
                                                                  return BlocConsumer<
                                                                      CheckemailexistCubit,
                                                                      CheckemailexistState>(
                                                                    listener:
                                                                        (context,
                                                                            emailcheck) {
                                                                      // TODO: implement listener
                                                                    },
                                                                    builder:
                                                                        (context,
                                                                            emailcheck) {
                                                                      return BlocConsumer<
                                                                          CheckEmpcodeCubit,
                                                                          CheckEmpcodeState>(
                                                                        listener:
                                                                            (context,
                                                                                checkempStatefinal) {
                                                                          // TODO: implement listener
                                                                        },
                                                                        builder:
                                                                            (context,
                                                                                checkempStatefinal) {
                                                                          return StatefulBuilder(builder:
                                                                              (BuildContext context, void Function(void Function()) setState) {
                                                                            double
                                                                                height =
                                                                                MediaQuery.of(context).size.height;
                                                                            return SizedBox(
                                                                              height: height / 2,
                                                                              child: AlertDialog(
                                                                                elevation: 10,
                                                                                actions: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      OnHoverButton(
                                                                                        child: ElevatedButton(
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              backgroundColor: Colors.grey[300],
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                              setState(() {});
                                                                                            },
                                                                                            child: const Text(
                                                                                              "Cancel",
                                                                                              style: TextStyle(color: Colors.blueGrey),
                                                                                            )),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 10),
                                                                                        child: InkWell(
                                                                                            onTap: () {
                                                                                              context.read<AddLeaveBalanceCubit>().addleavebalance(leavetypeid: leavedropdownvalue!, empname: empDropDownName);

                                                                                              context.router.pop();
                                                                                            },
                                                                                            child: Material(
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(13),
                                                                                              ),
                                                                                              elevation: 15,
                                                                                              child: const OnHoverButton(
                                                                                                child: CardWidget(
                                                                                                    color: Colors.green,
                                                                                                    width: 70,
                                                                                                    height: 30,
                                                                                                    borderRadius: 5,
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                        'Submit',
                                                                                                        style: TextStyle(color: Colors.white),
                                                                                                      ),
                                                                                                    )),
                                                                                              ),
                                                                                            )),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                                title: const Text(
                                                                                  "Add Leave Balance",
                                                                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                content: SizedBox(
                                                                                  height: 200.0,
                                                                                  width: 400.0,
                                                                                  child: Form(
                                                                                    child: SizedBox(
                                                                                      width: 300,
                                                                                      height: 725,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width,
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 13),
                                                                                            decoration: BoxDecoration(color: const Color.fromARGB(255, 240, 237, 237), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))),
                                                                                            child: DropdownSearch<String>(
                                                                                              popupProps: PopupProps.menu(
                                                                                                searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                                                constraints: BoxConstraints.expand(height: height / 2.5),
                                                                                                showSearchBox: true,
                                                                                                showSelectedItems: true,
                                                                                              ),
                                                                                              items: allEmp,
                                                                                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                                  hintStyle: TextStyle(
                                                                                                    fontSize: 15,
                                                                                                  ),
                                                                                                  border: InputBorder.none,
                                                                                                  labelText: "Employee Name :",
                                                                                                  hintText: "Select Employee Name",
                                                                                                ),
                                                                                              ),
                                                                                              onChanged: (String? newValue) {
                                                                                                setState(() {
                                                                                                  empDropDownName = newValue as String;
                                                                                                });
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 10,
                                                                                          ),
                                                                                          Container(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 13),
                                                                                            decoration: BoxDecoration(color: const Color.fromARGB(255, 240, 237, 237), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))),
                                                                                            child: DropdownSearch<String>(
                                                                                              popupProps: PopupProps.menu(
                                                                                                searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                                                constraints: BoxConstraints.expand(height: height / 3.5),
                                                                                                showSearchBox: true,
                                                                                                showSelectedItems: true,
                                                                                              ),
                                                                                              items: allLeaveTypeState.allleavetypenamelist,
                                                                                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                                  hintStyle: TextStyle(
                                                                                                    fontSize: 15,
                                                                                                  ),
                                                                                                  border: InputBorder.none,
                                                                                                  labelText: "Leave Type :",
                                                                                                  hintText: "Select Applicable Leave Type",
                                                                                                ),
                                                                                              ),
                                                                                              onChanged: (String? newValue) {
                                                                                                setState(() {
                                                                                                  leavetypeDropDownName = newValue as String;
                                                                                                  leavecredit = allLeaveTypeState.alleavetypenamewithcredit[leavetypeDropDownName];
                                                                                                });

                                                                                                leavedropdownvalue = allLeaveTypeState.alleavetypeidwithname[leavetypeDropDownName];
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 10,
                                                                                          ),
                                                                                          Container(
                                                                                              height: 52,
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 13),
                                                                                              decoration: BoxDecoration(color: const Color.fromARGB(255, 240, 237, 237), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    " Balance Credit : ",
                                                                                                    style: TextStyle(color: Colors.grey[600]),
                                                                                                  ),
                                                                                                  Text(leavecredit)
                                                                                                ],
                                                                                              ))
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );

                                                                            // AddBalPopUp(
                                                                            //   allEmpNameList:
                                                                            //       allEmp,
                                                                            //   empNameWithId:
                                                                            //       empNameWithId,
                                                                            //   allLeaveType:
                                                                            //       allLeaveTypeState.allleavetypenamelist,
                                                                            //   leaveTypeWithId:
                                                                            //       allLeaveTypeState.alleavetypeidwithname,
                                                                            //   leavatypenamewithcredit:
                                                                            //       allLeaveTypeState.alleavetypenamewithcredit,
                                                                            //   datacell:
                                                                            //       displayedDataCell,
                                                                            // );
                                                                          });
                                                                        },
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Material(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                              ),
                                                              elevation: 15,
                                                              child:
                                                                  const OnHoverButton(
                                                                child:
                                                                    CardWidget(
                                                                        gradient: [
                                                                      Color.fromARGB(
                                                                          255,
                                                                          211,
                                                                          32,
                                                                          39),
                                                                      Color.fromARGB(
                                                                          255,
                                                                          164,
                                                                          92,
                                                                          95)
                                                                    ],
                                                                        width:
                                                                            140,
                                                                        height:
                                                                            40,
                                                                        borderRadius:
                                                                            13,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 8.0),
                                                                            child:
                                                                                Text(
                                                                              "Add Leave Balance",
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        )),
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Padding(
                                                            padding: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >
                                                                    1040
                                                                ? const EdgeInsets
                                                                        .only(
                                                                    left: 50,
                                                                    right: 50,
                                                                    top: 20)
                                                                : const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 20),
                                                            child: SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: DataTable2(
                                                                columnSpacing:
                                                                    14,
                                                                empty: leaveBalanceState
                                                                        .isempty
                                                                    ? const Center(
                                                                        child:
                                                                            Text(
                                                                        'NO EMPLOYEE FOUND',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25),
                                                                      ))
                                                                    : const Center(
                                                                        child: SizedBox(
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            child:
                                                                                CircularProgressIndicator()),
                                                                      ),
                                                                headingRowHeight:
                                                                    80,
                                                                scrollController:
                                                                    datatablescrollcontroller,
                                                                fixedTopRows: 1,
                                                                dividerThickness:
                                                                    2,
                                                                headingRowColor:
                                                                    //! [checked ✔ ] full header row background
                                                                    MaterialStateProperty.all(Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2)),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        //! [checked ✔ ] full table background

                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.3),
                                                                          blurRadius:
                                                                              4,
                                                                          spreadRadius:
                                                                              3,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3))
                                                                    ]),
                                                                headingTextStyle:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                rows: <DataRow>[
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          displayedDataCell
                                                                              .length;
                                                                      i += 8)
                                                                    DataRow(
                                                                        cells: [
                                                                          displayedDataCell[
                                                                              i],
                                                                          displayedDataCell[i +
                                                                              1],
                                                                          displayedDataCell[i +
                                                                              2],
                                                                          displayedDataCell[i +
                                                                              3],
                                                                          displayedDataCell[i +
                                                                              4],
                                                                          displayedDataCell[i +
                                                                              5],
                                                                          displayedDataCell[i +
                                                                              6],
                                                                          displayedDataCell[i +
                                                                              7]
                                                                        ])
                                                                ],
                                                                columns: <
                                                                    DataColumn>[
                                                                  DataColumn2(
                                                                    fixedWidth:
                                                                        MediaQuery.of(context).size.width /
                                                                            20,
                                                                    label:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: const [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 6.0),
                                                                          child:
                                                                              Text(
                                                                            'Sl. no. ',
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label:
                                                                        Column(
                                                                      children: [
                                                                        const Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 6.0),
                                                                          child:
                                                                              Text(
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            'Employee Name',
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 10),
                                                                          child:
                                                                              OnHoverButton(
                                                                            child:
                                                                                Container(
                                                                              height: 36,
                                                                              width: 300,
                                                                              padding: const EdgeInsets.all(6),
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white, border: Border.all(color: Colors.grey)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8.0),
                                                                                child: TextField(
                                                                                  autofocus: isfocus,
                                                                                  controller: namesearchcontroller,
                                                                                  onChanged: (value) {
                                                                                    _debouncer.run(() {
                                                                                      if (value.length >= 3) {
                                                                                        displayedDataCell.clear();
                                                                                        setState(() {
                                                                                          isfocus = true;
                                                                                          empsearchname = value;
                                                                                        });
                                                                                        context.read<GetLeaveBalanceCubit>().getleavebalance(leave_type_no: dropdownLeaveatypelabel == "All" ? null : dropdownleavetypevalue, name: value, branch: dropdownbranchlabel == 'Select' || dropdownbranchlabel == "All" ? '' : dropdownbranchlabel, dept: dropdownDepartmentlabel == 'Select' || dropdownDepartmentlabel == "All" ? '' : dropdownDepartmentlabel, design: dropdownDesignationlabel == 'Select' || dropdownDesignationlabel == "All" ? '' : dropdownDesignationlabel);
                                                                                      }
                                                                                      if (value.isEmpty) {
                                                                                        displayedDataCell.clear();
                                                                                        context.read<GetLeaveBalanceCubit>().getleavebalance(leave_type_no: dropdownLeaveatypelabel == "All" ? null : dropdownleavetypevalue, name: value, branch: dropdownbranchlabel == 'Select' || dropdownbranchlabel == "All" ? '' : dropdownbranchlabel, dept: dropdownDepartmentlabel == 'Select' || dropdownDepartmentlabel == "All" ? '' : dropdownDepartmentlabel, design: dropdownDesignationlabel == 'Select' || dropdownDesignationlabel == "All" ? '' : dropdownDesignationlabel);
                                                                                      }
                                                                                    });
                                                                                    empsearchname = "";
                                                                                  },
                                                                                  decoration: const InputDecoration(
                                                                                    hintText: " Search       🔍",
                                                                                    border: InputBorder.none,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label:
                                                                        Column(
                                                                      children: [
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 8.0,
                                                                              bottom: 8),
                                                                          child:
                                                                              Text(
                                                                            'Branch',
                                                                          ),
                                                                        ),
                                                                        OnHoverButton(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                36,
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 13),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                border: Border.all(color: Colors.grey)),
                                                                            child:
                                                                                DropdownSearch<String>(
                                                                              selectedItem: dropdownvalue_branchname,
                                                                              popupProps: PopupProps.menu(
                                                                                searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                                constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                                showSearchBox: true,
                                                                                showSelectedItems: true,
                                                                              ),
                                                                              items: allbranchState.allbranchnamelist,
                                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                  labelText: dropdownbranchlabel,
                                                                                  border: InputBorder.none,
                                                                                  focusedBorder: InputBorder.none,
                                                                                  enabledBorder: InputBorder.none,
                                                                                  errorBorder: InputBorder.none,
                                                                                  disabledBorder: InputBorder.none,
                                                                                ),
                                                                              ),
                                                                              onChanged: (String? newValue) {
                                                                                setState(() {
                                                                                  dropdownvalue_branchname = newValue as String;
                                                                                  dropdownbranchlabel = dropdownvalue_branchname!;
                                                                                });
                                                                                dropdownvalue_branchid = allbranchState.branchidwithname.keys.firstWhere((k) => allbranchState.branchidwithname[k] == dropdownvalue_branchname, orElse: () => null);

                                                                                displayedDataCell.clear();

                                                                                context.read<GetLeaveBalanceCubit>().getleavebalance(leave_type_no: newValue == "All" ? null : dropdownleavetypevalue, name: empsearchname ?? "", branch: dropdownbranchlabel == 'Select' || dropdownbranchlabel == "All" ? '' : dropdownbranchlabel, dept: dropdownDepartmentlabel == 'Select' || dropdownDepartmentlabel == "All" ? '' : dropdownDepartmentlabel, design: dropdownDesignationlabel == 'Select' || dropdownDesignationlabel == "All" ? '' : dropdownDesignationlabel);
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label:
                                                                        Column(
                                                                      children: [
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 8.0,
                                                                              bottom: 8),
                                                                          child:
                                                                              Text(
                                                                            'Department',
                                                                          ),
                                                                        ),
                                                                        OnHoverButton(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                36,
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 13),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                border: Border.all(color: Colors.grey)),
                                                                            child:
                                                                                DropdownSearch<String>(
                                                                              popupProps: PopupProps.menu(
                                                                                searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                                constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                                showSearchBox: true,
                                                                                showSelectedItems: true,
                                                                              ),
                                                                              items: alldeptState.alldeptnamelist,
                                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                  labelText: dropdownDepartmentlabel,
                                                                                  border: InputBorder.none,
                                                                                  focusedBorder: InputBorder.none,
                                                                                  enabledBorder: InputBorder.none,
                                                                                  errorBorder: InputBorder.none,
                                                                                  disabledBorder: InputBorder.none,
                                                                                ),
                                                                              ),
                                                                              onChanged: (String? newValue) {
                                                                                setState(() {
                                                                                  dropdownDepartmentlabel = newValue as String;
                                                                                });

                                                                                displayedDataCell.clear();
                                                                                context.read<GetLeaveBalanceCubit>().getleavebalance(leave_type_no: newValue == "All" ? null : dropdownleavetypevalue, name: empsearchname ?? "", branch: dropdownbranchlabel == 'Select' || dropdownbranchlabel == "All" ? '' : dropdownbranchlabel, dept: dropdownDepartmentlabel == 'Select' || dropdownDepartmentlabel == "All" ? '' : dropdownDepartmentlabel, design: dropdownDesignationlabel == 'Select' || dropdownDesignationlabel == "All" ? '' : dropdownDesignationlabel);
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label:
                                                                        Column(
                                                                      children: [
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 8.0,
                                                                              bottom: 8),
                                                                          child:
                                                                              Text(
                                                                            'Designation',
                                                                          ),
                                                                        ),
                                                                        OnHoverButton(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                36,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 13),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                border: Border.all(color: Colors.grey)),
                                                                            child:
                                                                                DropdownSearch<String>(
                                                                              selectedItem: dropdownvalue_designname,
                                                                              popupProps: PopupProps.menu(
                                                                                searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                                constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                                showSearchBox: true,
                                                                                showSelectedItems: true,
                                                                              ),
                                                                              items: alldesignstate.alldesignationnamelist,
                                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                  labelText: dropdownDesignationlabel,
                                                                                  border: InputBorder.none,
                                                                                  focusedBorder: InputBorder.none,
                                                                                  enabledBorder: InputBorder.none,
                                                                                  errorBorder: InputBorder.none,
                                                                                  disabledBorder: InputBorder.none,
                                                                                ),
                                                                              ),
                                                                              onChanged: (String? newValue) {
                                                                                setState(() {
                                                                                  dropdownvalue_designname = newValue as String;
                                                                                  dropdownDesignationlabel = dropdownvalue_designname!;
                                                                                });

                                                                                dropdownvalue_designid = alldesignstate.designidwithname.keys.firstWhere((k) => alldesignstate.designidwithname[k] == dropdownvalue_designname, orElse: () => null);

                                                                                context.read<GetLeaveBalanceCubit>().getleavebalance(leave_type_no: newValue == "All" ? null : dropdownleavetypevalue, name: empsearchname ?? "", branch: dropdownbranchlabel == 'Select' || dropdownbranchlabel == "All" ? '' : dropdownbranchlabel, dept: dropdownDepartmentlabel == 'Select' || dropdownDepartmentlabel == "All" ? '' : dropdownDepartmentlabel, design: dropdownDesignationlabel == 'Select' || dropdownDesignationlabel == "All" ? '' : dropdownDesignationlabel);
                                                                                displayedDataCell.clear();
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label:
                                                                        Column(
                                                                      children: [
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 8.0,
                                                                              bottom: 8),
                                                                          child:
                                                                              Text(
                                                                            'Leave Type',
                                                                          ),
                                                                        ),
                                                                        OnHoverButton(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                36,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 13),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                border: Border.all(color: Colors.grey)),
                                                                            child:
                                                                                DropdownSearch<String>(
                                                                              selectedItem: dropdownLeavetypeName,
                                                                              popupProps: PopupProps.menu(
                                                                                searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                                constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                                fit: FlexFit.tight,
                                                                                showSearchBox: true,
                                                                                showSelectedItems: true,
                                                                              ),
                                                                              items: getallleavetype6State.allleavetypenamelist,
                                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                  labelText: dropdownLeaveatypelabel,
                                                                                  border: InputBorder.none,
                                                                                  focusedBorder: InputBorder.none,
                                                                                  enabledBorder: InputBorder.none,
                                                                                  errorBorder: InputBorder.none,
                                                                                  disabledBorder: InputBorder.none,
                                                                                ),
                                                                              ),
                                                                              onChanged: (String? newValue) {
                                                                                setState(() {
                                                                                  dropdownLeavetypeName = newValue as String;
                                                                                  dropdownLeaveatypelabel = dropdownLeavetypeName!;
                                                                                  dropdownleavetypevalue = getallleavetype6State.alleavetypeidwithname[dropdownLeavetypeName];
                                                                                });

                                                                                displayedDataCell.clear();
                                                                                context.read<GetLeaveBalanceCubit>().getleavebalance(leave_type_no: newValue == "All" ? null : dropdownleavetypevalue, name: empsearchname ?? "", branch: dropdownbranchlabel == 'Select' || dropdownbranchlabel == "All" ? '' : dropdownbranchlabel, dept: dropdownDepartmentlabel == 'Select' || dropdownDepartmentlabel == "All" ? '' : dropdownDepartmentlabel, design: dropdownDesignationlabel == 'Select' || dropdownDesignationlabel == "All" ? '' : dropdownDesignationlabel);
                                                                                //context.read<GetemployeelistCubit>().getemployeelist(datalimit: datalimit, ismoredata: true);
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: const [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 6.0),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Avail. Leave Balance',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: const [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 6.0),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Action',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 50,
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
                            });
                          },
                        );
                      },
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

class _OnHoverButtonState extends State<OnHoverButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.07);
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
