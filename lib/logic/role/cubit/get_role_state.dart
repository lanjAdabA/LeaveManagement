part of 'get_role_cubit.dart';

class GetRoleState extends Equatable {
  final Map<dynamic, dynamic> rolenamewithid;
  final List<String> allrolenamelist;
  const GetRoleState({
    required this.allrolenamelist,
    required this.rolenamewithid,
  });

  @override
  List<Object> get props => [rolenamewithid, allrolenamelist];
}
