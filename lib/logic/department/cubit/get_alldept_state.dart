part of 'get_alldept_cubit.dart';

enum DeptStatus { initial, loading, loaded, error }

class GetAlldeptState extends Equatable {
  final List<AllDeptListModel> alldeptlist;
  final List<String> alldeptnamelist;
  final Map<dynamic, dynamic> deptidwithname;
  final DeptStatus deptStatus;
  const GetAlldeptState(
      {required this.alldeptnamelist,
      required this.deptidwithname,
      required this.alldeptlist,
      required this.deptStatus});

  @override
  List<Object> get props =>
      [alldeptlist, deptidwithname, deptStatus, alldeptnamelist];
}
