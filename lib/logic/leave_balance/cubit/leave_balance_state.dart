part of 'leave_balance_cubit.dart';

enum GetLeaveBalanceStatus { initial, loading, loaded, error }

class GetLeaveBalanceState extends Equatable {
  final List<LeaveBalanceModel> leavebalancelist;
  final List<dynamic>? branchnamelist;
  final List<dynamic>? deptnamelist;
  final List<dynamic>? designnamelist;
  final List<String>? leavetypelist;
  final Map<dynamic, dynamic>? leaveidandname;

  const GetLeaveBalanceState({
    required this.leavebalancelist,
    this.branchnamelist,
    this.deptnamelist,
    this.designnamelist,
    this.leavetypelist,
    this.leaveidandname,
  });

  @override
  List<dynamic> get props => [
        leavebalancelist,
        branchnamelist,
        deptnamelist,
        designnamelist,
        leavetypelist,
        leaveidandname
      ];
}
