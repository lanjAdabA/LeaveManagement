import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:leavemanagementadmin/logic/Authflow/auth_flow_cubit.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/check_empcode_cubit.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/checkemailexist_cubit.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/create_employee_cubit.dart';
import 'package:leavemanagementadmin/logic/Employee/cubit/updateemployee_cubit.dart';
import 'package:leavemanagementadmin/logic/branch/create_branch_state.dart';
import 'package:leavemanagementadmin/logic/branch/delete_branch_cubit.dart';
import 'package:leavemanagementadmin/logic/department/cubit/delete_dept_cubit.dart';
import 'package:leavemanagementadmin/logic/department/cubit/delete_dept_state.dart';
import 'package:leavemanagementadmin/logic/department/cubit/get_alldept_cubit.dart';
import 'package:leavemanagementadmin/logic/department/cubit/postdepartment_cubit.dart';
import 'package:leavemanagementadmin/logic/department/cubit/update_dept.state.dart';
import 'package:leavemanagementadmin/logic/department/cubit/update_dept_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/delete_design_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/delete_design_state.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/get_alldesign_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/post_designation_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/update_design_cubit.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/update_design_state.dart';
import 'package:leavemanagementadmin/logic/leave/cubit/cubit/createleave_cubit.dart';
import 'package:leavemanagementadmin/logic/leave/cubit/getallleavetype_cubit.dart';

import 'package:leavemanagementadmin/logic/loginCubit/cubit/login_bymail_cubit.dart';
import 'package:leavemanagementadmin/logic/loginCubit/cubit/login_byphone_cubit.dart';
import 'package:leavemanagementadmin/logic/loginCubit/cubit/login_verifybymail_cubit.dart';
import 'package:leavemanagementadmin/logic/role/cubit/get_role_cubit.dart';

import '../logic/Employee/cubit/getemployeelist_cubit.dart';
import '../logic/branch/create_branch_cubit.dart';
import '../logic/branch/getallbranch_cubit.dart';
import '../logic/branch/update_branch_cubit.dart';
import '../logic/branch/update_branch_state.dart';

class MultiproviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiproviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              LoginBymailCubit(SendingotpStatusformail.initial)),
      BlocProvider(create: (context) => LoginByphoneCubit(Status2.initial)),
      BlocProvider(
          create: (context) =>
              LoginVerifybymailCubit(VerifyStatusformail.initial)),
      BlocProvider(
        create: (context) => AuthFlowCubit(),
      ),
      BlocProvider(create: (context) => BranchCubit(BranchStatus.initial)),
      BlocProvider(
          create: (context) => PostdepartmentCubit(PostDeptStatus.initial)),
      BlocProvider(
          create: (context) => PostDesignationCubit(PostDesignStatus.initial)),
      BlocProvider(
          create: (context) => UpdateBranchCubit(UpdateBranchStatus.initial)),
      BlocProvider(
          create: (context) => UpdateDeptCubit(UpdateDeptStatus.initial)),
      BlocProvider(
          create: (context) => UpdateDesignCubit(UpdateDesignStatus.initial)),
      BlocProvider(
        create: (context) => GetemployeelistCubit(),
      ),
      BlocProvider(
        create: (context) => GetallbranchCubit(),
      ),
      BlocProvider(
        create: (context) => GetAlldeptCubit(),
      ),
      BlocProvider(
        create: (context) => GetAlldesignCubit(),
      ),
      BlocProvider(
          create: (context) =>
              CreateEmployeeCubit(CreateEmployeeStatus.initial)),
      BlocProvider(create: (context) => DeleteBranchCubit()),
      BlocProvider(
          create: (context) => DeleteDesignCubit(DeleteDesignStatus.initial)),
      BlocProvider(
          create: (context) => DeleteDeptCubit(DeleteDeptStatus.initial)),
      BlocProvider(create: (context) => GetRoleCubit()),
      BlocProvider(create: (context) => CheckEmpcodeCubit()),
      BlocProvider(create: (context) => CheckemailexistCubit()),
      BlocProvider(
          create: (context) =>
              UpdateemployeeCubit(UpdateEmployeeStatus.initial)),
      BlocProvider(create: (context) => GetallleavetypeCubit()),
      BlocProvider(
          create: (context) => CreateleaveCubit(CreateLeaveStatus.initial)),
    ], child: child);
  }
}
