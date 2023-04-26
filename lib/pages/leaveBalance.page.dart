import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:leavemanagementadmin/constant.dart';

import 'package:leavemanagementadmin/logic/Employee/cubit/getemployeelist_cubit.dart';
import 'package:leavemanagementadmin/logic/branch/getallbranch_cubit.dart';
import 'package:leavemanagementadmin/logic/leave/cubit/getallleavetype_cubit.dart';
import 'package:leavemanagementadmin/logic/leave/cubit/getallleavetype_forleavebalance_cubit.dart';

import 'package:leavemanagementadmin/logic/leave_balance/cubit/leave_balance_cubit.dart';

import 'package:leavemanagementadmin/model/emp%20_listmodel.dart';
import 'package:leavemanagementadmin/model/leave_balance.dart';
import 'package:leavemanagementadmin/widget/filter.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:leavemanagementadmin/widget/popupAddBal.dart';

import 'package:leavemanagementadmin/widget/popupEditLeaveBal.dart';

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

  bool israngeselected = false;

//Dropdown Label String
  String dropdownbranchlabel = 'Select';
  String dropdownDepartmentlabel = 'Select';
  String dropdownDesignationlabel = 'Select';
  String dropdownLeaveatypelabel = 'Select';

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
    //       // context.read<GetemployeelistCubit>().getemployeelist(
    //       //     datalimit: datalimit,
    //       //     ismoredata: true,
    //       //     branchid: dropdownvalue_branchid,
    //       //     deptid: dropdownvalue_departmentid,
    //       //     desigid: dropdownvalue_designid,
    //       //     rolename: dropdownleavetypevalue);

    //       log('reach buttom');
    //     }
    //   }
    // });
  }

  int? _selectedRadioTile;

  int? selectedRadioTileforleave;
  int? selectedRadioTileforgender;

  void readall() {
    log('reading cubit.......');
    context.read<GetLeaveBalanceCubit>().getleavebalance();
    context.read<GetallleavetypeCubit>().getallleavetype();
  }

  void fetchdata(
    List<LeaveBalanceModel> leaveblclist,
    Map<dynamic, dynamic> leavetypemap,
  ) {
    log('Not empty');

    for (var item in leaveblclist) {
      displayedDataCell.add(
        DataCell(
          SizedBox(
            width: 20,
            child: Center(
              child: Text(
                (leaveblclist.indexOf(item) + 1).toString(),
              ),
            ),
          ),
        ),
      );

      displayedDataCell.add(
        DataCell(
          Center(child: Text(item.employeeName)),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Center(
            child: Text(item.branch),
          ),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Center(child: Text(item.department)),
        ),
      );
      displayedDataCell.add(
        DataCell(
          Center(child: Text(item.designation)),
        ),
      );

      displayedDataCell.add(
        DataCell(Center(child: Text(item.leaveType))),
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
                onPressed: () {
                  empcode.text = item.empCode.toString();
                  _namefieldcontroller.text = item.employeeName;
                  // numbercontroller.text = item.employeePhone;
                  // emailcontroller.text = item.email;
                  // datetime2 =
                  //     "${item.employeeDateOfJoining.year}-${item.employeeDateOfJoining.month}-${item.employeeDateOfJoining.day}";

                  // setState(() {
                  //   dropdownvalue1 =
                  //       designidwithname[item.employeeDesignationId]
                  //           .toString();

                  //   dropdownvalue2 =
                  //       deptnamewithid[item.employeeDepartmentId].toString();
                  //   dropdownvalue3 = item.role;
                  //   dropdownvalue4 =
                  //       branchidwithname[item.employeeBranchId].toString();
                  // });

                  // showDialog(
                  //   context: context,
                  //   builder: (cnt) {
                  //     return BlocConsumer<GetallbranchCubit, GetallbranchState>(
                  //       listener: (context, branchstate) {
                  //         // TODO: implement listener
                  //       },
                  //       builder: (context, branchstate) {
                  //         return StatefulBuilder(builder: (BuildContext context,
                  //             void Function(void Function()) setState) {
                  //           return const EditLeaveBalPopUp();
                  //         });
                  //       },
                  //     );
                  //   },
                  // );
                },
                child: const OnHoverButton2(child: Text("Edit"))),
          ),
        )),
      );
    }
  }

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

  String? dropdownLeavetypeName;
  int? dropdownleavetypevalue;

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

  @override
  Widget build(BuildContext context) {
    String size = MediaQuery.of(context).size.width.toString();

    return BlocConsumer<GetallleavetypeCubit, GetallleavetypeState>(
      listener: (context, allleavetypestate) {},
      builder: (context, allleavetypestate) {
        return BlocConsumer<GetLeaveBalanceCubit, GetLeaveBalanceState>(
          listener: (context, leavestate) {
            fetchdata(leavestate.leavebalancelist, leavestate.leaveidandname!);
          },
          builder: (context, leavestate) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 245, 245, 245),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      child: const Text(
                        'Leave Balance ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: MediaQuery.of(context).size.width > 1040
                          ? const EdgeInsets.only(left: 50, top: 15)
                          : const EdgeInsets.only(left: 10, top: 15),
                      child: InkWell(
                        // onTap: () {
                        //   AddBalPopUp(
                        //     allEmpNameList: [],
                        //     allLeaveType: [],
                        //     empNameWithId: ,
                        //     leavatypenamewithcredit: ,
                        //     leaveTypeWithId: ,);
                        // },
                        child: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          elevation: 15,
                          child: const OnHoverButton(
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
                                    "Add Balance",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
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
                              columnSpacing: 14,
                              empty: isempty
                                  ? const Center(
                                      child: Text(
                                      'NO EMPLOYEE FOUND',
                                      style: TextStyle(fontSize: 25),
                                    ))
                                  : const Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator()),
                                    ),
                              headingRowHeight: 80,
                              scrollController: datatablescrollcontroller,
                              fixedTopRows: 1,
                              dividerThickness: 2,
                              headingRowColor:
                                  //! [checked ✔ ] full header row background
                                  MaterialStateProperty.all(
                                      Colors.grey.withOpacity(0.2)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //! [checked ✔ ] full table background

                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 4,
                                        spreadRadius: 3,
                                        offset: const Offset(0, 3))
                                  ]),
                              headingTextStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              rows: <DataRow>[
                                for (int i = 0;
                                    i < displayedDataCell.length;
                                    i += 8)
                                  DataRow(cells: [
                                    displayedDataCell[i],
                                    displayedDataCell[i + 1],
                                    displayedDataCell[i + 2],
                                    displayedDataCell[i + 3],
                                    displayedDataCell[i + 4],
                                    displayedDataCell[i + 5],
                                    displayedDataCell[i + 6],
                                    displayedDataCell[i + 7]
                                  ])
                              ],
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          'Sl. no. ',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          'Employee Name',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: OnHoverButton(
                                          child: Container(
                                            height: 36,
                                            width: 300,
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: TextField(
                                                onChanged: (value) {
                                                  displayedDataCell.clear();
                                                  if (value.length >= 3) {
                                                    context
                                                        .read<
                                                            GetLeaveBalanceCubit>()
                                                        .getleavebalance(
                                                            name: value);
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
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
                                  label: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Text(
                                          'Branch',
                                        ),
                                      ),
                                      OnHoverButton(
                                        child: Container(
                                          height: 36,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: DropdownSearch<String>(
                                            // selectedItem: dropdownvalue_branchname,
                                            popupProps: PopupProps.menu(
                                              searchFieldProps: const TextFieldProps(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 40))),
                                              constraints: BoxConstraints.tight(
                                                  const Size(250, 250)),
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                            ),
                                            // items: allbranchState
                                            //     .allbranchnamelist,
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText: dropdownbranchlabel,

                                                // labelStyle: TextStyle(
                                                //     color: Colors.grey[
                                                //         700],
                                                //     fontSize:
                                                //         20),

                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                // label: Text(
                                                //   "Select",
                                                //   style: TextStyle(
                                                //       fontSize:
                                                //           14),
                                                // ),
                                              ),
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                // dropdownvalue_branchname =
                                                //     newValue as String;
                                                // dropdownbranchlabel =
                                                //     dropdownvalue_branchname!;
                                              });
                                              // dropdownvalue_branchid = allbranchState
                                              //     .branchidwithname
                                              //     .keys
                                              //     .firstWhere(
                                              //         (k) =>
                                              //             allbranchState.branchidwithname[k] ==
                                              //             dropdownvalue_branchname,
                                              //         orElse: () =>
                                              //             null);

                                              displayedDataCell.clear();
                                              // context
                                              //     .read<GetemployeelistCubit>()
                                              //     .getemployeelist(
                                              //         datalimit: datalimit,
                                              //         ismoredata: true,
                                              //         desigid: dropdownvalue_designid,
                                              //         deptid:
                                              //             dropdownvalue_departmentid,
                                              //         rolename: dropdownleavetypevalue,
                                              //         branchid: dropdownvalue_branchid);
                                              log(dropdownvalue44!.toString());
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Text(
                                          'Department',
                                        ),
                                      ),
                                      OnHoverButton(
                                        child: Container(
                                          height: 36,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: DropdownSearch<String>(
                                            // selectedItem: dropdownvalue_departmentname,
                                            popupProps: PopupProps.menu(
                                              searchFieldProps: const TextFieldProps(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 40))),
                                              constraints: BoxConstraints.tight(
                                                  const Size(250, 250)),
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                            ),
                                            // items: alldeptState
                                            //     .alldeptnamelist,
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText:
                                                    dropdownDepartmentlabel,
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                // label: Text(
                                                //   "Select",
                                                //   style: TextStyle(
                                                //       fontSize:
                                                //           14),
                                                // ),
                                              ),
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                // dropdownvalue_departmentname =
                                                //     newValue as String;
                                                // dropdownDepartmentlabel =
                                                //     dropdownvalue_departmentname!;
                                              });

                                              // dropdownvalue_departmentid = alldeptState
                                              //     .deptidwithname
                                              //     .keys
                                              //     .firstWhere(
                                              //         (k) =>
                                              //             alldeptState.deptidwithname[k] ==
                                              //             dropdownvalue_departmentname,
                                              //         orElse: () =>
                                              //             null);

                                              displayedDataCell.clear();
                                              // context
                                              //     .read<GetemployeelistCubit>()
                                              //     .getemployeelist(
                                              //         datalimit: datalimit,
                                              //         ismoredata: true,
                                              //         desigid: dropdownvalue_designid,
                                              //         deptid:
                                              //             dropdownvalue_departmentid,
                                              //         rolename: dropdownleavetypevalue,
                                              //         branchid: dropdownvalue_branchid);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Text(
                                          'Designation',
                                        ),
                                      ),
                                      OnHoverButton(
                                        child: Container(
                                          height: 36,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: DropdownSearch<String>(
                                            //selectedItem: dropdownvalue_designname,
                                            popupProps: PopupProps.menu(
                                              searchFieldProps: const TextFieldProps(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 40))),
                                              constraints: BoxConstraints.tight(
                                                  const Size(250, 250)),
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                            ),
                                            // items: alldesignstate
                                            //     .alldesignationnamelist,
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText:
                                                    dropdownDesignationlabel,
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                // label: Text(
                                                //   "Select",
                                                //   style: TextStyle(
                                                //       fontSize:
                                                //           14),
                                                // ),
                                              ),
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                // dropdownvalue_designname =
                                                //     newValue as String;
                                                // dropdownDesignationlabel =
                                                //     dropdownvalue_designname!;
                                              });

                                              // dropdownvalue_designid = alldesignstate
                                              //     .designidwithname
                                              //     .keys
                                              //     .firstWhere(
                                              //         (k) =>
                                              //             alldesignstate.designidwithname[k] ==
                                              //             dropdownvalue_designname,
                                              //         orElse: () =>
                                              //             null);

                                              // context
                                              //     .read<GetemployeelistCubit>()
                                              //     .getemployeelist(
                                              //         datalimit: datalimit,
                                              //         ismoredata: true,
                                              //         desigid: dropdownvalue_designid,
                                              //         deptid:
                                              //             dropdownvalue_departmentid,
                                              //         rolename: dropdownleavetypevalue,
                                              //         branchid: dropdownvalue_branchid);
                                              displayedDataCell.clear();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Text(
                                          'Leave Type',
                                        ),
                                      ),
                                      OnHoverButton(
                                        child: Container(
                                          height: 36,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: DropdownSearch<String>(
                                            // selectedItem: dropdownLeavetypeName,
                                            popupProps: PopupProps.menu(
                                              searchFieldProps: const TextFieldProps(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 40))),
                                              constraints: BoxConstraints.tight(
                                                  const Size(250, 250)),
                                              fit: FlexFit.tight,
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                            ),
                                            items: allleavetypestate
                                                .allleavetypenamelist,
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText:
                                                    dropdownLeaveatypelabel,
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                // label: Text(
                                                //   "Select",
                                                //   style: TextStyle(
                                                //       fontSize:
                                                //           14),
                                                // ),
                                              ),
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownLeavetypeName =
                                                    newValue as String;
                                                dropdownLeaveatypelabel =
                                                    dropdownLeavetypeName!;

                                                dropdownleavetypevalue =
                                                    allleavetypestate
                                                            .alleavetypeidwithname[
                                                        dropdownLeavetypeName];
                                              });

                                              log("leave dropdown value : $dropdownleavetypevalue ");
                                              log("leave dropdown map : ${allleavetypestate.alleavetypeidwithname} ");

                                              displayedDataCell.clear();
                                              context
                                                  .read<GetLeaveBalanceCubit>()
                                                  .getleavebalance(
                                                      leave_type_no:
                                                          dropdownleavetypevalue);
                                              // context
                                              //     .read<GetemployeelistCubit>()
                                              //     .getemployeelist(
                                              //         datalimit: datalimit,
                                              //         ismoredata: true,
                                              //         desigid: dropdownvalue_designid,
                                              //         deptid:
                                              //             dropdownvalue_departmentid,
                                              //         rolename: dropdownleavetypevalue,
                                              //         branchid: dropdownvalue_branchid);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          'Avail. Leave Balance',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 6.0),
                                        child: Center(
                                          child: Text(
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
