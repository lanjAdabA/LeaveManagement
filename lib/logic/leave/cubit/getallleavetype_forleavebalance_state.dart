part of 'getallleavetype_forleavebalance_cubit.dart';

class GetallleavetypeForleavebalanceState extends Equatable {
  final Map<dynamic, dynamic> alleavetypeidwithname;
  final Map<dynamic, dynamic> alleavetypenamewithcredit;
  final List<String> allleavetypenamelist;
  const GetallleavetypeForleavebalanceState({
    required this.alleavetypenamewithcredit,
    required this.allleavetypenamelist,
    required this.alleavetypeidwithname,
  });

  @override
  List<Object> get props => [alleavetypeidwithname, allleavetypenamelist];
}
