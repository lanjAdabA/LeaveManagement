part of 'getallbranch_cubit.dart';

class GetallbranchState extends Equatable {
  final List<AllBranchList> allbranchlist;
  final Map<dynamic, dynamic> branchidwithname;
  final List<String> allbranchnamelist;

  const GetallbranchState(
      {required this.allbranchnamelist,
      required this.branchidwithname,
      required this.allbranchlist});

  @override
  List<Object> get props =>
      [allbranchlist, branchidwithname, allbranchnamelist];
}
