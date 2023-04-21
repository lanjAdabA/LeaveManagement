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
import 'package:leavemanagementadmin/logic/leave/cubit/cubit/createleave_cubit.dart';
import 'package:leavemanagementadmin/logic/leave/cubit/getallleavetype_cubit.dart';
import 'package:leavemanagementadmin/logic/role/cubit/get_role_cubit.dart';
import 'package:leavemanagementadmin/model/emp%20_listmodel.dart';
import 'package:leavemanagementadmin/widget/filter.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../logic/Employee/cubit/updateemployee_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Employee> employees = <Employee>[];
  DateTime? updatetime;
  bool isactive = false;
  String fillname = "";

  TextEditingController leaveappliedforcontroller = TextEditingController();
  TextEditingController leavereasoncontroller = TextEditingController();
  DateTime? initialdate = DateTime(2023);
  Widget _dataofbirth(String dob, String labeltext) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DateTimeField(
              controller: TextEditingController(text: dob),
              decoration: InputDecoration(
                labelText: labeltext,
              ),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                        context: context,
                        initialDate: initialdate!,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025),
                        helpText: "SELECT DATE OF JOINING",
                        cancelText: "CANCEL",
                        confirmText: "OK",
                        fieldHintText: "DATE/MONTH/YEAR",
                        fieldLabelText: "ENTER DATE OF JOINING",
                        errorFormatText: "Enter a Valid Date",
                        errorInvalidText: "Date Out of Range")
                    .then((value) {
                  setState(() {
                    datetime = "${value!.year}-${value.month}-${value.day}";
                    startdate = "${value.year}-${value.month}-${value.day}";
                    enddate = "${value.year}-${value.month}-${value.day}";
                    datetime2 = "${value.year}-${value.month}-${value.day}";
                    updatetime = value;
                  });
                  log(datetime);

                  return value;
                });
              },
            ),
          ),
        ]);
  }

  bool? ismoreloading;
  int datalimit = 15;
  ScrollController datatablescrollcontroller = ScrollController();
  @override
  void initState() {
    super.initState();

    context.read<GetallbranchCubit>().getallbranch();
    context.read<GetAlldeptCubit>().getalldept();
    context.read<GetAlldesignCubit>().getalldesign();
    context.read<GetRoleCubit>().getallrole();
    context
        .read<GetemployeelistCubit>()
        .getemployeelist(datalimit: datalimit, ismoredata: true);
    context.read<GetallleavetypeCubit>().getallleavetype();

    // readall();

    _selectedRadioTile = 1;
    selectedRadioTileforleave = 1;
    datatablescrollcontroller.addListener(() {
      if (datatablescrollcontroller.position.pixels ==
          datatablescrollcontroller.position.maxScrollExtent) {
        if (ismoreloading == false) {
          log('Item reach its limit');
        } else {
          setState(() {
            datalimit = datalimit + 15;
          });
          displayedDataCell.clear();
          context.read<GetemployeelistCubit>().getemployeelist(
              datalimit: datalimit,
              ismoredata: true,
              branchid: dropdownvalue44,
              deptid: dropdownvalue22,
              desigid: dropdownvalue11,
              rolename: dropdownvalue33);

          log('reach buttom');
        }
      }
    });
  }

  int? _selectedRadioTile;

  int? selectedRadioTileforleave;

  void readall() {
    log('reading cubit.......');
  }

  void fetchdata(
      {required List<Employee> allemplist,
      required Map<dynamic, dynamic> branchidwithname,
      required Map<dynamic, dynamic> deptnamewithid,
      required Map<dynamic, dynamic> designidwithname}) {
    log('Not empty');

    for (var item in allemplist) {
      // log("All emplist : $allemplist");
      if (branchidwithname.isNotEmpty &&
          deptnamewithid.isNotEmpty &&
          designidwithname.isNotEmpty) {
        //log("Display datacell $displayedDataCell");

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
            Center(
              child: Text(item.employeeIsActive == "1" ? 'Active' : "Inactive"),
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
                child: Text(
                    designidwithname[item.employeeDesignationId].toString())),
          ),
        );

        displayedDataCell.add(
          DataCell(
            Center(
                child:
                    Text(deptnamewithid[item.employeeDepartmentId].toString())),
          ),
        );

        displayedDataCell.add(
          DataCell(Center(child: Text(item.role))),
        );
        displayedDataCell.add(
          DataCell(
            Center(
              child: Text(
                branchidwithname[item.employeeBranchId].toString(),
              ),
            ),
          ),
        );

        displayedDataCell.add(
          DataCell(FittedBox(
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      empcode.text = item.employeeEmpCode.toString();
                      _namefieldcontroller.text = item.employeeName;
                      numbercontroller.text = item.employeePhone;
                      emailcontroller.text = item.email;
                      datetime2 =
                          "${item.employeeDateOfJoining.year}-${item.employeeDateOfJoining.month}-${item.employeeDateOfJoining.day}";

                      setState(() {
                        dropdownvalue1 =
                            designidwithname[item.employeeDesignationId]
                                .toString();

                        dropdownvalue2 =
                            deptnamewithid[item.employeeDepartmentId]
                                .toString();
                        dropdownvalue3 = item.role;
                        dropdownvalue4 =
                            branchidwithname[item.employeeBranchId].toString();
                      });

                      showDialog(
                        context: context,
                        builder: (cnt) {
                          return BlocConsumer<GetallbranchCubit,
                              GetallbranchState>(
                            listener: (context, branchstate) {
                              // TODO: implement listener
                            },
                            builder: (context, branchstate) {
                              return BlocConsumer<GetAlldeptCubit,
                                  GetAlldeptState>(
                                listener: (context, deptstate) {
                                  // TODO: implement listener
                                },
                                builder: (context, deptstate) {
                                  return BlocConsumer<GetAlldesignCubit,
                                      GetAlldesignState>(
                                    listener: (context, designstate) {
                                      // TODO: implement listener
                                    },
                                    builder: (context, designstate) {
                                      return BlocConsumer<GetRoleCubit,
                                          GetRoleState>(
                                        listener: (context, rolestate) {
                                          // TODO: implement listener
                                        },
                                        builder: (context, rolestate) {
                                          return BlocConsumer<
                                              CheckemailexistCubit,
                                              CheckemailexistState>(
                                            listener: (context, emailcheck) {
                                              // TODO: implement listener
                                            },
                                            builder: (context, emailcheck) {
                                              return BlocConsumer<
                                                  CheckEmpcodeCubit,
                                                  CheckEmpcodeState>(
                                                listener: (context,
                                                    checkempStatefinal) {
                                                  // TODO: implement listener
                                                },
                                                builder: (context,
                                                    checkempStatefinal) {
                                                  return StatefulBuilder(
                                                      builder: (BuildContext
                                                              context,
                                                          void Function(
                                                                  void
                                                                      Function())
                                                              setState) {
                                                    return AlertDialog(
                                                      actions: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          300],
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(() {
                                                                    _namefieldcontroller
                                                                        .clear();
                                                                    datetime2 =
                                                                        '';

                                                                    dropdownvalue1 =
                                                                        null;
                                                                    dropdownvalue2 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueGrey),
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    dropdownvalue11 = designstate
                                                                        .designidwithname
                                                                        .keys
                                                                        .firstWhere(
                                                                            (k) =>
                                                                                designstate.designidwithname[k] ==
                                                                                dropdownvalue1,
                                                                            orElse: () =>
                                                                                null);
                                                                    dropdownvalue22 = deptstate
                                                                        .deptidwithname
                                                                        .keys
                                                                        .firstWhere(
                                                                            (k) =>
                                                                                deptstate.deptidwithname[k] ==
                                                                                dropdownvalue2,
                                                                            orElse: () =>
                                                                                null);
                                                                    dropdownvalue33 =
                                                                        rolestate
                                                                            .rolenamewithid[dropdownvalue3];
                                                                    dropdownvalue44 = branchstate
                                                                        .branchidwithname
                                                                        .keys
                                                                        .firstWhere(
                                                                            (k) =>
                                                                                branchstate.branchidwithname[k] ==
                                                                                dropdownvalue4,
                                                                            orElse: () =>
                                                                                null);
                                                                    context.read<UpdateemployeeCubit>().updateemployee(
                                                                        id: item
                                                                            .employeeId,
                                                                        empname:
                                                                            _namefieldcontroller
                                                                                .text,
                                                                        empcode:
                                                                            int.parse(empcode
                                                                                .text),
                                                                        phonenumber:
                                                                            numbercontroller
                                                                                .text,
                                                                        deptid:
                                                                            dropdownvalue22!,
                                                                        designid:
                                                                            dropdownvalue11!,
                                                                        branchid:
                                                                            dropdownvalue44!,
                                                                        roleid:
                                                                            dropdownvalue33!,
                                                                        dateofjoining:
                                                                            datetime2,
                                                                        emptype:
                                                                            _selectedRadioTile
                                                                                .toString(),
                                                                        email: emailcontroller
                                                                            .text);

                                                                    EasyLoading
                                                                        .dismiss();
                                                                    context
                                                                        .router
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              13),
                                                                    ),
                                                                    elevation:
                                                                        15,
                                                                    child: const CardWidget(
                                                                        color: Colors.green,
                                                                        width: 70,
                                                                        height: 30,
                                                                        borderRadius: 5,
                                                                        child: Center(
                                                                          child:
                                                                              Text(
                                                                            'Update',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        )),
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                      title: const Text(
                                                        "Update Employee",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Form(
                                                          child: SizedBox(
                                                            width: 300,
                                                            height: 600,
                                                            child: Column(
                                                              children: [
                                                                TextFormField(
                                                                    onChanged:
                                                                        (value) {
                                                                      context
                                                                          .read<
                                                                              CheckEmpcodeCubit>()
                                                                          .checkempcode(
                                                                              value);
                                                                    },
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    controller:
                                                                        empcode,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      suffix: checkempStatefinal.isexist.isEmpty ||
                                                                              empcode.value.text.isEmpty
                                                                          ? const SizedBox()
                                                                          : checkempStatefinal.isexist == 'false'
                                                                              ? Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: const [
                                                                                    Text(
                                                                                      'available',
                                                                                      style: TextStyle(color: Colors.green),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 3,
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.green,
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              : Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: const [
                                                                                    Text(
                                                                                      'already exist',
                                                                                      style: TextStyle(color: Colors.red),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 3,
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.error,
                                                                                      color: Colors.red,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                      hintStyle: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              212,
                                                                              211,
                                                                              211)),
                                                                      hintText:
                                                                          'Employee Code',
                                                                    )),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),

                                                                TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        _namefieldcontroller,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      hintStyle: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              212,
                                                                              211,
                                                                              211)),
                                                                      hintText:
                                                                          'Name',
                                                                    )),
                                                                // _dataofbirth(datetime2),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextFormField(
                                                                    onChanged:
                                                                        (value) {
                                                                      context
                                                                          .read<
                                                                              CheckemailexistCubit>()
                                                                          .checkemailexist(
                                                                              value);
                                                                    },
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        emailcontroller,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      suffix: emailcheck.isexist.isEmpty ||
                                                                              emailcontroller.value.text.isEmpty
                                                                          ? const SizedBox()
                                                                          : emailcheck.isexist == 'false'
                                                                              ? Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: const [
                                                                                    Text(
                                                                                      'available',
                                                                                      style: TextStyle(color: Colors.green),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 3,
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.green,
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              : emailcheck.isexist == 'invalid'
                                                                                  ? Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: const [
                                                                                        Text(
                                                                                          'invalid email',
                                                                                          style: TextStyle(color: Colors.red),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 3,
                                                                                        ),
                                                                                        Icon(
                                                                                          Icons.error,
                                                                                          color: Colors.red,
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  : Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: const [
                                                                                        Text(
                                                                                          'already exist',
                                                                                          style: TextStyle(color: Colors.red),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 3,
                                                                                        ),
                                                                                        Icon(
                                                                                          Icons.error,
                                                                                          color: Colors.red,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                      hintStyle: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              212,
                                                                              211,
                                                                              211)),
                                                                      hintText:
                                                                          'Email',
                                                                    )),
                                                                _dataofbirth(
                                                                    datetime2,
                                                                    'Date Of Joining'),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        numbercontroller,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      hintStyle: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              212,
                                                                              211,
                                                                              211)),
                                                                      hintText:
                                                                          'Phone Number',
                                                                    )),

                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'Employee Type :'),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          RadioListTile(
                                                                        contentPadding:
                                                                            EdgeInsets.zero,
                                                                        title: const Text(
                                                                            'Employee'),
                                                                        value:
                                                                            1,
                                                                        groupValue:
                                                                            _selectedRadioTile,
                                                                        onChanged:
                                                                            (val) {
                                                                          print(
                                                                              'Selected value: $val');
                                                                          log(val
                                                                              .toString());
                                                                          setState(
                                                                              () {
                                                                            _selectedRadioTile =
                                                                                val;
                                                                          });
                                                                        },
                                                                        activeColor:
                                                                            Colors.green,
                                                                        selected:
                                                                            _selectedRadioTile ==
                                                                                1,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          RadioListTile(
                                                                        contentPadding:
                                                                            EdgeInsets.zero,
                                                                        title: const Text(
                                                                            'Probation Period'),
                                                                        value:
                                                                            2,
                                                                        groupValue:
                                                                            _selectedRadioTile,
                                                                        onChanged:
                                                                            (val) {
                                                                          print(
                                                                              'Selected value: $val');
                                                                          setState(
                                                                              () {
                                                                            _selectedRadioTile =
                                                                                val;
                                                                          });
                                                                        },
                                                                        activeColor:
                                                                            Colors.green,
                                                                        selected:
                                                                            _selectedRadioTile ==
                                                                                2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          13),
                                                                  decoration: BoxDecoration(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          240,
                                                                          237,
                                                                          237),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      border: Border.all(
                                                                          color: const Color.fromARGB(
                                                                              255,
                                                                              225,
                                                                              222,
                                                                              222))),
                                                                  child:
                                                                      DropdownSearch<
                                                                          String>(
                                                                    selectedItem:
                                                                        dropdownvalue1,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              constraints: BoxConstraints(maxHeight: 40))),
                                                                      constraints:
                                                                          BoxConstraints.tight(const Size(
                                                                              250,
                                                                              250)),
                                                                      showSearchBox:
                                                                          true,
                                                                      showSelectedItems:
                                                                          true,
                                                                    ),
                                                                    items: designstate
                                                                        .alldesignationnamelist,
                                                                    dropdownDecoratorProps:
                                                                        const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        border:
                                                                            InputBorder.none,
                                                                        labelText:
                                                                            "Designation :",
                                                                        hintText:
                                                                            "Select Your Designation",
                                                                      ),
                                                                    ),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownvalue1 =
                                                                            newValue
                                                                                as String;
                                                                      });

                                                                      dropdownvalue11 = designstate
                                                                          .designidwithname
                                                                          .keys
                                                                          .firstWhere(
                                                                              (k) => designstate.designidwithname[k] == dropdownvalue1,
                                                                              orElse: () => null);
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          13),
                                                                  decoration: BoxDecoration(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          240,
                                                                          237,
                                                                          237),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      border: Border.all(
                                                                          color: const Color.fromARGB(
                                                                              255,
                                                                              225,
                                                                              222,
                                                                              222))),
                                                                  child:
                                                                      DropdownSearch<
                                                                          String>(
                                                                    selectedItem:
                                                                        dropdownvalue2,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              constraints: BoxConstraints(maxHeight: 40))),
                                                                      constraints:
                                                                          BoxConstraints.tight(const Size(
                                                                              250,
                                                                              250)),
                                                                      showSearchBox:
                                                                          true,
                                                                      showSelectedItems:
                                                                          true,
                                                                    ),
                                                                    items: deptstate
                                                                        .alldeptnamelist,
                                                                    dropdownDecoratorProps:
                                                                        const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        border:
                                                                            InputBorder.none,
                                                                        labelText:
                                                                            "Department :",
                                                                        hintText:
                                                                            "Select Your Department",
                                                                      ),
                                                                    ),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownvalue2 =
                                                                            newValue
                                                                                as String;
                                                                      });

                                                                      dropdownvalue22 = deptstate
                                                                          .deptidwithname
                                                                          .keys
                                                                          .firstWhere(
                                                                              (k) => deptstate.deptidwithname[k] == dropdownvalue2,
                                                                              orElse: () => null);
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          13),
                                                                  decoration: BoxDecoration(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          240,
                                                                          237,
                                                                          237),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      border: Border.all(
                                                                          color: const Color.fromARGB(
                                                                              255,
                                                                              225,
                                                                              222,
                                                                              222))),
                                                                  child:
                                                                      DropdownSearch<
                                                                          String>(
                                                                    selectedItem:
                                                                        dropdownvalue3,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              constraints: BoxConstraints(maxHeight: 40))),
                                                                      constraints:
                                                                          BoxConstraints.tight(const Size(
                                                                              250,
                                                                              250)),
                                                                      showSearchBox:
                                                                          true,
                                                                      showSelectedItems:
                                                                          true,
                                                                    ),
                                                                    items: rolestate
                                                                        .allrolenamelist,
                                                                    dropdownDecoratorProps:
                                                                        const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        border:
                                                                            InputBorder.none,
                                                                        labelText:
                                                                            "Role :",
                                                                        hintText:
                                                                            "Select Your Role",
                                                                      ),
                                                                    ),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownvalue3 =
                                                                            newValue
                                                                                as String;
                                                                      });
                                                                      dropdownvalue33 =
                                                                          rolestate
                                                                              .rolenamewithid[dropdownvalue3];
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          13),
                                                                  decoration: BoxDecoration(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          240,
                                                                          237,
                                                                          237),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      border: Border.all(
                                                                          color: const Color.fromARGB(
                                                                              255,
                                                                              225,
                                                                              222,
                                                                              222))),
                                                                  child:
                                                                      DropdownSearch<
                                                                          String>(
                                                                    selectedItem:
                                                                        dropdownvalue4,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              constraints: BoxConstraints(maxHeight: 40))),
                                                                      constraints:
                                                                          BoxConstraints.tight(const Size(
                                                                              250,
                                                                              250)),
                                                                      showSearchBox:
                                                                          true,
                                                                      showSelectedItems:
                                                                          true,
                                                                    ),
                                                                    items: branchstate
                                                                        .allbranchnamelist,
                                                                    dropdownDecoratorProps:
                                                                        const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        border:
                                                                            InputBorder.none,
                                                                        labelText:
                                                                            "Branch :",
                                                                        hintText:
                                                                            "Select Your Branch",
                                                                      ),
                                                                    ),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownvalue4 =
                                                                            newValue
                                                                                as String;
                                                                      });
                                                                      dropdownvalue44 = branchstate
                                                                          .branchidwithname
                                                                          .keys
                                                                          .firstWhere(
                                                                              (k) => branchstate.branchidwithname[k] == dropdownvalue4,
                                                                              orElse: () => null);
                                                                      log(dropdownvalue44!
                                                                          .toString());
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                        },
                      );
                    },
                    child: const OnHoverButton2(child: Icon(Icons.edit))),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      context.read<GetallleavetypeCubit>().getallleavetype();
                      setState(() {
                        leaveappliedforcontroller.text = item.employeeName;
                      });
                      showDialog(
                        context: context,
                        builder: (cnt) {
                          return BlocConsumer<CreateleaveCubit,
                              CreateLeaveStatus>(
                            listener: (context, createleavestatus) {
                              switch (createleavestatus) {
                                case CreateLeaveStatus.initial:
                                  // TODO: Handle this case.
                                  break;
                                case CreateLeaveStatus.loading:
                                  EasyLoading.show(status: 'Please Wait..');
                                  break;
                                case CreateLeaveStatus.loaded:
                                  EasyLoading.showToast(
                                      'Successfully Added Leave');
                                  break;
                                case CreateLeaveStatus.error:
                                  // TODO: Handle this case.
                                  break;
                              }
                            },
                            builder: (context, createleavestatus) {
                              return BlocConsumer<GetallleavetypeCubit,
                                  GetallleavetypeState>(
                                listener: (context, allleavetypestate) {
                                  // TODO: implement listener
                                },
                                builder: (context, allleavetypestate) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return AlertDialog(
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
                                                    setState(() {
                                                      _namefieldcontroller
                                                          .clear();
                                                      datetime2 = '';

                                                      dropdownvalue1 = null;
                                                      dropdownvalue2 = null;
                                                    });
                                                  },
                                                  child: const Text(
                                                    "CANCEL",
                                                    style: TextStyle(
                                                        color: Colors.blueGrey),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.green),
                                                    onPressed: () async {
                                                      EasyLoading.show(
                                                          status: 'Adding..');
                                                      if (_namefieldcontroller
                                                              .text.isEmpty ||
                                                          dropdownvalue11 ==
                                                              null ||
                                                          dropdownvalue22 ==
                                                              null ||
                                                          datetime.isEmpty) {
                                                        EasyLoading.dismiss();
                                                        context.router.pop();
                                                        CustomSnackBar(
                                                            context,
                                                            const Text(
                                                              'All Fields Are Mandatory',
                                                            ),
                                                            Colors.red);
                                                      } else {}
                                                    },
                                                    child: const Text("ADD")),
                                              )
                                            ],
                                          ),
                                        ],
                                        title: const Text(
                                          "Add new Leave",
                                        ),
                                        content: SingleChildScrollView(
                                          child: Form(
                                            child: SizedBox(
                                              width: 300,
                                              height: 460,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          leaveappliedforcontroller,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Leave Applied For :',
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 13),
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 240, 237, 237),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                225,
                                                                222,
                                                                222))),
                                                    child:
                                                        DropdownSearch<String>(
                                                      popupProps:
                                                          PopupProps.menu(
                                                        searchFieldProps: const TextFieldProps(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                constraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            40))),
                                                        constraints:
                                                            BoxConstraints
                                                                .tight(
                                                                    const Size(
                                                                        250,
                                                                        250)),
                                                        showSearchBox: true,
                                                        showSelectedItems: true,
                                                      ),
                                                      items: allleavetypestate
                                                          .allleavetypenamelist,
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          hintStyle: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                          border:
                                                              InputBorder.none,
                                                          labelText:
                                                              "Leave Type :",
                                                          hintText:
                                                              "Choose Leave Type",
                                                        ),
                                                      ),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          leavetypedropdown =
                                                              newValue
                                                                  as String;
                                                        });
                                                        leavetypedropdownid = allleavetypestate
                                                            .alleavetypeidwithname
                                                            .keys
                                                            .firstWhere(
                                                                (k) =>
                                                                    allleavetypestate
                                                                            .alleavetypeidwithname[
                                                                        k] ==
                                                                    leavetypedropdown,
                                                                orElse: () =>
                                                                    null);
                                                        log(dropdownvalue44!
                                                            .toString());
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  _dataofbirth(
                                                      datetime2, 'From Date :'),
                                                  _dataofbirth(
                                                      datetime2, 'To Date :'),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          leavereasoncontroller,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Reason For Leave',
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Half Day : "),
                                                      Switch(
                                                        value: isactive,
                                                        activeColor: const Color
                                                                .fromARGB(
                                                            255, 72, 217, 77),
                                                        onChanged:
                                                            (bool value) {
                                                          setState(() {
                                                            isactive = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  isactive
                                                      ? Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  RadioListTile(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                title: const Text(
                                                                    'First Half'),
                                                                value: 1,
                                                                groupValue:
                                                                    selectedRadioTileforleave,
                                                                onChanged:
                                                                    (val) {
                                                                  print(
                                                                      'Selected value: $val');
                                                                  log(val
                                                                      .toString());
                                                                  setState(() {
                                                                    selectedRadioTileforleave =
                                                                        val;
                                                                  });
                                                                },
                                                                activeColor:
                                                                    Colors
                                                                        .green,
                                                                selected:
                                                                    selectedRadioTileforleave ==
                                                                        1,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  RadioListTile(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                title: const Text(
                                                                    'Second Half'),
                                                                value: 2,
                                                                groupValue:
                                                                    selectedRadioTileforleave,
                                                                onChanged:
                                                                    (val) {
                                                                  print(
                                                                      'Selected value: $val');
                                                                  setState(() {
                                                                    selectedRadioTileforleave =
                                                                        val;
                                                                  });
                                                                },
                                                                activeColor:
                                                                    Colors
                                                                        .green,
                                                                selected:
                                                                    selectedRadioTileforleave ==
                                                                        2,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
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
                    child: const OnHoverButton2(child: Text('Add Leave')))
              ],
            ),
          )),
        );
      }
    }
  }

  String? dropdownvalue_designname;
  int? dropdownvalue_designid;
  int? dropdownvalue_departmentid;
  String? dropdownvalue_departmentname;
  String? dropdownvalue_rolename;
  int? dropdownvalue_roleid;
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

  String datetime2 = '';
  String datetime3 = '';
  String datetime4 = '';

  var format = DateFormat("dd-MM-yyyy");

  List<String> all_desid = [];
  List<String> all_depid = [];
  List<String> all_des = [];
  List<String> all_dep = [];
  List<String> all_role = [];
  List<String> all_roleid = [];

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
                        return BlocConsumer<GetemployeelistCubit, PostState>(
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
                            // if (allbranchState.branchidwithname.isEmpty) {
                            //   context.read<GetallbranchCubit>().getallbranch();
                            // } else if (alldeptState.deptidwithname.isEmpty) {
                            //   context.read<GetAlldeptCubit>().getalldept();
                            // } else if (alldesignstate
                            //     .designidwithname.isEmpty) {
                            //   context.read<GetAlldesignCubit>().getalldesign();
                            // } else {
                            //   context.read<GetallbranchCubit>().getallbranch();
                            //   context.read<GetAlldeptCubit>().getalldept();
                            //   context.read<GetAlldesignCubit>().getalldesign();
                            // }
                            fetchdata(
                                allemplist: getempoyeestate.allemployeelist,
                                branchidwithname:
                                    allbranchState.branchidwithname,
                                deptnamewithid: alldeptState.deptidwithname,
                                designidwithname:
                                    alldesignstate.designidwithname);
                          }
                        }, builder: (context, getempoyeestate) {
                          return BlocConsumer<CreateEmployeeCubit,
                              CreateEmployeeStatus>(
                            listener: (context, state) {
                              switch (state) {
                                case CreateEmployeeStatus.initial:
                                  break;
                                case CreateEmployeeStatus.loading:
                                  EasyLoading.show(status: 'Adding Employee..');
                                  break;
                                case CreateEmployeeStatus.loaded:
                                  EasyLoading.showToast('Added Successfully')
                                      .whenComplete(() {
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
                                    context
                                        .read<GetemployeelistCubit>()
                                        .getemployeelist(
                                            datalimit: datalimit,
                                            ismoredata: true);
                                  });

                                  break;
                                case CreateEmployeeStatus.error:
                                  EasyLoading.showError('Error');
                                  break;
                              }
                            },
                            builder: (context, state) {
                              log(checkempState.isexist);
                              return Scaffold(
                                backgroundColor:
                                    const Color.fromARGB(255, 245, 245, 245),
                                body: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Padding(
                                        padding:
                                            MediaQuery.of(context).size.width >
                                                    1040
                                                ? const EdgeInsets.only(
                                                    left: 50,
                                                  )
                                                : const EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                        child: const Text(
                                          'Employee ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            MediaQuery.of(context).size.width >
                                                    1040
                                                ? const EdgeInsets.only(
                                                    left: 50, top: 15)
                                                : const EdgeInsets.only(
                                                    left: 10, top: 15),
                                        child: InkWell(
                                            onTap: () {
                                              _namefieldcontroller.clear();
                                              usernamecontroller.clear();
                                              emailcontroller.clear();
                                              numbercontroller.clear();
                                              empcode.clear();
                                              setState(() {
                                                datetime2 = '';
                                              });
                                              dropdownvalue1 = null;
                                              dropdownvalue2 = null;
                                              dropdownvalue3 = null;
                                              dropdownvalue4 = null;
                                              showDialog(
                                                context: context,
                                                builder: (cnt) {
                                                  log('From Showdialog :${checkempState.isexist}');
                                                  return BlocConsumer<
                                                      CheckemailexistCubit,
                                                      CheckemailexistState>(
                                                    listener:
                                                        (context, emailcheck) {
                                                      // TODO: implement listener
                                                    },
                                                    builder:
                                                        (context, emailcheck) {
                                                      return BlocConsumer<
                                                          CheckEmpcodeCubit,
                                                          CheckEmpcodeState>(
                                                        listener: (context,
                                                            checkempStatefinal) {
                                                          // TODO: implement listener
                                                        },
                                                        builder: (context,
                                                            checkempStatefinal) {
                                                          return StatefulBuilder(
                                                              builder: (BuildContext
                                                                      context,
                                                                  void Function(
                                                                          void
                                                                              Function())
                                                                      setState) {
                                                            return AlertDialog(
                                                              actions: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.grey[300],
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {
                                                                            _namefieldcontroller.clear();
                                                                            datetime2 =
                                                                                '';

                                                                            dropdownvalue1 =
                                                                                null;
                                                                            dropdownvalue2 =
                                                                                null;
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Cancel",
                                                                          style:
                                                                              TextStyle(color: Colors.blueGrey),
                                                                        )),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10),
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            if (_namefieldcontroller.text.isEmpty ||
                                                                                empcode.text.isEmpty ||
                                                                                emailcontroller.text.isEmpty ||
                                                                                empcode.text.isEmpty) {
                                                                              CustomSnackBar(
                                                                                  context,
                                                                                  const Text(
                                                                                    'All Fields Are Mandatory',
                                                                                  ),
                                                                                  Colors.red);
                                                                            } else {
                                                                              context.read<CreateEmployeeCubit>().createemployee(empname: _namefieldcontroller.text, empusername: usernamecontroller.text, email: emailcontroller.text, empcode: int.parse(empcode.text), phonenumber: numbercontroller.text, deptid: dropdownvalue22!, designid: dropdownvalue11!, branchid: dropdownvalue44!, roleid: dropdownvalue33!, dateofjoining: datetime, emptype: _selectedRadioTile.toString());

                                                                              EasyLoading.dismiss();
                                                                              context.router.pop();
                                                                            }
                                                                          },
                                                                          child: Material(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(13),
                                                                            ),
                                                                            elevation:
                                                                                15,
                                                                            child: const CardWidget(
                                                                                color: Colors.green,
                                                                                width: 70,
                                                                                height: 30,
                                                                                borderRadius: 5,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    'Add',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                )),
                                                                          )),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                              title: const Text(
                                                                "Add new Employee",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Form(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 300,
                                                                    height: 652,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        TextFormField(
                                                                            onChanged:
                                                                                (value) {
                                                                              context.read<CheckEmpcodeCubit>().checkempcode(value);
                                                                            },
                                                                            keyboardType: TextInputType
                                                                                .number,
                                                                            controller:
                                                                                empcode,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              suffix: checkempStatefinal.isexist.isEmpty || empcode.value.text.isEmpty
                                                                                  ? const SizedBox()
                                                                                  : checkempStatefinal.isexist == 'false'
                                                                                      ? Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: const [
                                                                                            Text(
                                                                                              'available',
                                                                                              style: TextStyle(color: Colors.green),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 3,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.check,
                                                                                              color: Colors.green,
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      : Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: const [
                                                                                            Text(
                                                                                              'already exist',
                                                                                              style: TextStyle(color: Colors.red),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 3,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.error,
                                                                                              color: Colors.red,
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                              hintStyle: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 212, 211, 211)),
                                                                              hintText: 'Employee Code',
                                                                            )),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                            keyboardType: TextInputType
                                                                                .text,
                                                                            controller:
                                                                                usernamecontroller,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              hintStyle: TextStyle(fontSize: 15, color: Color.fromARGB(255, 212, 211, 211)),
                                                                              hintText: 'Username',
                                                                            )),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                            keyboardType: TextInputType
                                                                                .text,
                                                                            controller:
                                                                                _namefieldcontroller,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              hintStyle: TextStyle(fontSize: 15, color: Color.fromARGB(255, 212, 211, 211)),
                                                                              hintText: 'Name',
                                                                            )),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                            onChanged:
                                                                                (value) {
                                                                              context.read<CheckemailexistCubit>().checkemailexist(value);
                                                                            },
                                                                            keyboardType: TextInputType
                                                                                .text,
                                                                            controller:
                                                                                emailcontroller,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              suffix: emailcheck.isexist.isEmpty || emailcontroller.value.text.isEmpty
                                                                                  ? const SizedBox()
                                                                                  : emailcheck.isexist == 'false'
                                                                                      ? Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: const [
                                                                                            Text(
                                                                                              'available',
                                                                                              style: TextStyle(color: Colors.green),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 3,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.check,
                                                                                              color: Colors.green,
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      : emailcheck.isexist == 'invalid'
                                                                                          ? Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: const [
                                                                                                Text(
                                                                                                  'invalid email',
                                                                                                  style: TextStyle(color: Colors.red),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 3,
                                                                                                ),
                                                                                                Icon(
                                                                                                  Icons.error,
                                                                                                  color: Colors.red,
                                                                                                )
                                                                                              ],
                                                                                            )
                                                                                          : Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: const [
                                                                                                Text(
                                                                                                  'already exist',
                                                                                                  style: TextStyle(color: Colors.red),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 3,
                                                                                                ),
                                                                                                Icon(
                                                                                                  Icons.error,
                                                                                                  color: Colors.red,
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                              hintStyle: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 212, 211, 211)),
                                                                              hintText: 'Email',
                                                                            )),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                            keyboardType: TextInputType
                                                                                .text,
                                                                            controller:
                                                                                numbercontroller,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              hintStyle: TextStyle(fontSize: 15, color: Color.fromARGB(255, 212, 211, 211)),
                                                                              hintText: 'Phone Number',
                                                                            )),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        _dataofbirth(
                                                                            datetime2,
                                                                            'Date Of Joining'),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        const Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text('Employee Type :'),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: RadioListTile(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                title: const Text('Employee'),
                                                                                value: 1,
                                                                                groupValue: _selectedRadioTile,
                                                                                onChanged: (val) {
                                                                                  print('Selected value: $val');
                                                                                  log(val.toString());
                                                                                  setState(() {
                                                                                    _selectedRadioTile = val;
                                                                                  });
                                                                                },
                                                                                activeColor: Colors.green,
                                                                                selected: _selectedRadioTile == 1,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: RadioListTile(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                title: const Text('Probation Period'),
                                                                                value: 2,
                                                                                groupValue: _selectedRadioTile,
                                                                                onChanged: (val) {
                                                                                  print('Selected value: $val');
                                                                                  setState(() {
                                                                                    _selectedRadioTile = val;
                                                                                  });
                                                                                },
                                                                                activeColor: Colors.green,
                                                                                selected: _selectedRadioTile == 2,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 13),
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 240, 237, 237),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))),
                                                                          child:
                                                                              DropdownSearch<String>(
                                                                            popupProps:
                                                                                PopupProps.menu(
                                                                              searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                              constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                              showSearchBox: true,
                                                                              showSelectedItems: true,
                                                                            ),
                                                                            items:
                                                                                alldesignstate.alldesignationnamelist,
                                                                            dropdownDecoratorProps:
                                                                                const DropDownDecoratorProps(
                                                                              dropdownSearchDecoration: InputDecoration(
                                                                                hintStyle: TextStyle(
                                                                                  fontSize: 15,
                                                                                ),
                                                                                border: InputBorder.none,
                                                                                labelText: "Designation :",
                                                                                hintText: "Select Your Designation",
                                                                              ),
                                                                            ),
                                                                            onChanged:
                                                                                (String? newValue) {
                                                                              setState(() {
                                                                                dropdownvalue1 = newValue as String;
                                                                              });

                                                                              dropdownvalue11 = alldesignstate.designidwithname.keys.firstWhere((k) => alldesignstate.designidwithname[k] == dropdownvalue1, orElse: () => null);
                                                                            },
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 13),
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 240, 237, 237),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))),
                                                                          child:
                                                                              DropdownSearch<String>(
                                                                            popupProps:
                                                                                PopupProps.menu(
                                                                              searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                              constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                              showSearchBox: true,
                                                                              showSelectedItems: true,
                                                                            ),
                                                                            items:
                                                                                alldeptState.alldeptnamelist,
                                                                            dropdownDecoratorProps:
                                                                                const DropDownDecoratorProps(
                                                                              dropdownSearchDecoration: InputDecoration(
                                                                                hintStyle: TextStyle(
                                                                                  fontSize: 15,
                                                                                ),
                                                                                border: InputBorder.none,
                                                                                labelText: "Department :",
                                                                                hintText: "Select Your Department",
                                                                              ),
                                                                            ),
                                                                            onChanged:
                                                                                (String? newValue) {
                                                                              setState(() {
                                                                                dropdownvalue2 = newValue as String;
                                                                              });

                                                                              dropdownvalue22 = alldeptState.deptidwithname.keys.firstWhere((k) => alldeptState.deptidwithname[k] == dropdownvalue2, orElse: () => null);
                                                                            },
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 13),
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 240, 237, 237),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))),
                                                                          child:
                                                                              DropdownSearch<String>(
                                                                            popupProps:
                                                                                PopupProps.menu(
                                                                              searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                              constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                              showSearchBox: true,
                                                                              showSelectedItems: true,
                                                                            ),
                                                                            items:
                                                                                allrolename,
                                                                            dropdownDecoratorProps:
                                                                                const DropDownDecoratorProps(
                                                                              dropdownSearchDecoration: InputDecoration(
                                                                                hintStyle: TextStyle(
                                                                                  fontSize: 15,
                                                                                ),
                                                                                border: InputBorder.none,
                                                                                labelText: "Role :",
                                                                                hintText: "Select Your Role",
                                                                              ),
                                                                            ),
                                                                            onChanged:
                                                                                (String? newValue) {
                                                                              setState(() {
                                                                                dropdownvalue3 = newValue as String;
                                                                              });
                                                                              dropdownvalue33 = roleidwithname[dropdownvalue3];
                                                                            },
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 13),
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 240, 237, 237),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))),
                                                                          child:
                                                                              DropdownSearch<String>(
                                                                            popupProps:
                                                                                PopupProps.menu(
                                                                              searchFieldProps: const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                              constraints: BoxConstraints.tight(const Size(250, 250)),
                                                                              showSearchBox: true,
                                                                              showSelectedItems: true,
                                                                            ),
                                                                            items:
                                                                                allbranchState.allbranchnamelist,
                                                                            dropdownDecoratorProps:
                                                                                const DropDownDecoratorProps(
                                                                              dropdownSearchDecoration: InputDecoration(
                                                                                hintStyle: TextStyle(
                                                                                  fontSize: 15,
                                                                                ),
                                                                                border: InputBorder.none,
                                                                                labelText: "Branch :",
                                                                                hintText: "Select Your Branch",
                                                                              ),
                                                                            ),
                                                                            onChanged:
                                                                                (String? newValue) {
                                                                              setState(() {
                                                                                dropdownvalue4 = newValue as String;
                                                                              });
                                                                              dropdownvalue44 = allbranchState.branchidwithname.keys.firstWhere((k) => allbranchState.branchidwithname[k] == dropdownvalue4, orElse: () => null);
                                                                              log(dropdownvalue44!.toString());
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Material(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                              ),
                                              elevation: 15,
                                              child: const OnHoverButton(
                                                child: CardWidget(
                                                    gradient: [
                                                      Color.fromARGB(
                                                          255, 211, 32, 39),
                                                      Color.fromARGB(
                                                          255, 164, 92, 95)
                                                    ],
                                                    width: 120,
                                                    height: 40,
                                                    borderRadius: 13,
                                                    child: Center(
                                                      child: Text(
                                                        'Add Employee',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    1040
                                                ? const EdgeInsets.only(
                                                    left: 50,
                                                    right: 50,
                                                    top: 20)
                                                : const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 20),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: DataTable2(
                                                columnSpacing: 14,
                                                empty: isempty
                                                    ? const Center(
                                                        child: Text(
                                                        'NO EMPLOYEE FOUND',
                                                        style: TextStyle(
                                                            fontSize: 25),
                                                      ))
                                                    : const Center(
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child:
                                                                CircularProgressIndicator()),
                                                      ),
                                                headingRowHeight: 80,
                                                scrollController:
                                                    datatablescrollcontroller,
                                                fixedTopRows: 1,
                                                dividerThickness: 2,
                                                headingRowColor:
                                                    //! [checked ✔ ] full header row background
                                                    MaterialStateProperty.all(
                                                        Colors.grey
                                                            .withOpacity(0.2)),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    //! [checked ✔ ] full table background

                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 4,
                                                          spreadRadius: 3,
                                                          offset: const Offset(
                                                              0, 3))
                                                    ]),
                                                headingTextStyle:
                                                    const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                rows: <DataRow>[
                                                  for (int i = 0;
                                                      i <
                                                          displayedDataCell
                                                              .length;
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0),
                                                          child: Text(
                                                            'Sl.no',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0),
                                                          child: Text(
                                                            'Employee Status',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Column(
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0),
                                                          child: Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            'Employee Name',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 8),
                                                          child: OnHoverButton(
                                                            child: Container(
                                                              height: 38,
                                                              width: 300,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey)),
                                                              child: TextField(
                                                                onChanged:
                                                                    (value) {
                                                                  displayedDataCell
                                                                      .clear();
                                                                  if (value
                                                                          .length >=
                                                                      3) {
                                                                    context.read<GetemployeelistCubit>().getemployeelist(
                                                                        name:
                                                                            value,
                                                                        datalimit:
                                                                            datalimit,
                                                                        ismoredata:
                                                                            true,
                                                                        desigid:
                                                                            dropdownvalue11,
                                                                        deptid:
                                                                            dropdownvalue22,
                                                                        rolename:
                                                                            dropdownvalue33,
                                                                        branchid:
                                                                            dropdownvalue44);
                                                                  }
                                                                },
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      " Search       🔍",
                                                                  border:
                                                                      InputBorder
                                                                          .none,
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0,
                                                                  bottom: 8),
                                                          child: Text(
                                                            'Designation',
                                                          ),
                                                        ),
                                                        OnHoverButton(
                                                          child: Container(
                                                            height: 40,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        13),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child:
                                                                DropdownSearch<
                                                                    String>(
                                                              selectedItem:
                                                                  dropdownvalue_designname,
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                searchFieldProps: const TextFieldProps(
                                                                    decoration: InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        constraints:
                                                                            BoxConstraints(maxHeight: 40))),
                                                                constraints:
                                                                    BoxConstraints.tight(
                                                                        const Size(
                                                                            250,
                                                                            250)),
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              items: alldesignstate
                                                                  .alldesignationnamelist,
                                                              dropdownDecoratorProps:
                                                                  const DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Choose Designation",
                                                                ),
                                                              ),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownvalue_designname =
                                                                      newValue
                                                                          as String;
                                                                });

                                                                dropdownvalue_designid = alldesignstate
                                                                    .designidwithname
                                                                    .keys
                                                                    .firstWhere(
                                                                        (k) =>
                                                                            alldesignstate.designidwithname[k] ==
                                                                            dropdownvalue_designname,
                                                                        orElse: () =>
                                                                            null);

                                                                context.read<GetemployeelistCubit>().getemployeelist(
                                                                    datalimit:
                                                                        datalimit,
                                                                    ismoredata:
                                                                        true,
                                                                    desigid:
                                                                        dropdownvalue_designid,
                                                                    deptid:
                                                                        dropdownvalue_departmentid,
                                                                    rolename:
                                                                        dropdownvalue_roleid,
                                                                    branchid:
                                                                        dropdownvalue_branchid);
                                                                displayedDataCell
                                                                    .clear();
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0,
                                                                  bottom: 8),
                                                          child: Text(
                                                            'Department',
                                                          ),
                                                        ),
                                                        OnHoverButton(
                                                          child: Container(
                                                            height: 40,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        13),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child:
                                                                DropdownSearch<
                                                                    String>(
                                                              selectedItem:
                                                                  dropdownvalue_departmentname,
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                searchFieldProps: const TextFieldProps(
                                                                    decoration: InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        constraints:
                                                                            BoxConstraints(maxHeight: 40))),
                                                                constraints:
                                                                    BoxConstraints.tight(
                                                                        const Size(
                                                                            250,
                                                                            250)),
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              items: alldeptState
                                                                  .alldeptnamelist,
                                                              dropdownDecoratorProps:
                                                                  const DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Choose  Department",
                                                                ),
                                                              ),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownvalue_departmentname =
                                                                      newValue
                                                                          as String;
                                                                });

                                                                dropdownvalue_departmentid = alldeptState
                                                                    .deptidwithname
                                                                    .keys
                                                                    .firstWhere(
                                                                        (k) =>
                                                                            alldeptState.deptidwithname[k] ==
                                                                            dropdownvalue_departmentname,
                                                                        orElse: () =>
                                                                            null);

                                                                displayedDataCell
                                                                    .clear();
                                                                context.read<GetemployeelistCubit>().getemployeelist(
                                                                    datalimit:
                                                                        datalimit,
                                                                    ismoredata:
                                                                        true,
                                                                    desigid:
                                                                        dropdownvalue_designid,
                                                                    deptid:
                                                                        dropdownvalue_departmentid,
                                                                    rolename:
                                                                        dropdownvalue_roleid,
                                                                    branchid:
                                                                        dropdownvalue_branchid);
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0,
                                                                  bottom: 8),
                                                          child: Text(
                                                            'Role',
                                                          ),
                                                        ),
                                                        OnHoverButton(
                                                          child: Container(
                                                            height: 40,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        13),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child:
                                                                DropdownSearch<
                                                                    String>(
                                                              selectedItem:
                                                                  dropdownvalue_rolename,
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                searchFieldProps: const TextFieldProps(
                                                                    decoration: InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        constraints:
                                                                            BoxConstraints(maxHeight: 40))),
                                                                constraints:
                                                                    BoxConstraints.tight(
                                                                        const Size(
                                                                            250,
                                                                            250)),
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              items:
                                                                  allrolename,
                                                              dropdownDecoratorProps:
                                                                  const DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Choose  Role",
                                                                ),
                                                              ),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownvalue_rolename =
                                                                      newValue
                                                                          as String;
                                                                });

                                                                dropdownvalue_roleid =
                                                                    roleidwithname[
                                                                        dropdownvalue_rolename];

                                                                displayedDataCell
                                                                    .clear();
                                                                context.read<GetemployeelistCubit>().getemployeelist(
                                                                    datalimit:
                                                                        datalimit,
                                                                    ismoredata:
                                                                        true,
                                                                    desigid:
                                                                        dropdownvalue_designid,
                                                                    deptid:
                                                                        dropdownvalue_departmentid,
                                                                    rolename:
                                                                        dropdownvalue_roleid,
                                                                    branchid:
                                                                        dropdownvalue_branchid);
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0,
                                                                  bottom: 8),
                                                          child: Text(
                                                            'Branch',
                                                          ),
                                                        ),
                                                        OnHoverButton(
                                                          child: Container(
                                                            height: 40,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        13),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child:
                                                                DropdownSearch<
                                                                    String>(
                                                              selectedItem:
                                                                  dropdownvalue_branchname,
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                searchFieldProps: const TextFieldProps(
                                                                    decoration: InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        constraints:
                                                                            BoxConstraints(maxHeight: 40))),
                                                                constraints:
                                                                    BoxConstraints.tight(
                                                                        const Size(
                                                                            250,
                                                                            250)),
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              items: allbranchState
                                                                  .allbranchnamelist,
                                                              dropdownDecoratorProps:
                                                                  const DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Choose  Branch",
                                                                ),
                                                              ),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownvalue_branchname =
                                                                      newValue
                                                                          as String;
                                                                });
                                                                dropdownvalue_branchid = allbranchState
                                                                    .branchidwithname
                                                                    .keys
                                                                    .firstWhere(
                                                                        (k) =>
                                                                            allbranchState.branchidwithname[k] ==
                                                                            dropdownvalue_branchname,
                                                                        orElse: () =>
                                                                            null);

                                                                displayedDataCell
                                                                    .clear();
                                                                context.read<GetemployeelistCubit>().getemployeelist(
                                                                    datalimit:
                                                                        datalimit,
                                                                    ismoredata:
                                                                        true,
                                                                    desigid:
                                                                        dropdownvalue_designid,
                                                                    deptid:
                                                                        dropdownvalue_departmentid,
                                                                    rolename:
                                                                        dropdownvalue_roleid,
                                                                    branchid:
                                                                        dropdownvalue_branchid);
                                                                log(dropdownvalue44!
                                                                    .toString());
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 14.0),
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
