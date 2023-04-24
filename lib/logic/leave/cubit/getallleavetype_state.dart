part of 'getallleavetype_cubit.dart';

class GetallleavetypeState extends Equatable {
  final List<Leaf> alleavetype;
  final Map<dynamic, dynamic> alleavetypeidwithname;
  final List<String> allleavetypenamelist;
  final Map<dynamic, dynamic> alleavetypeidwithnamecopy;
  final List<String> allleavetypenamelistcopy;
  const GetallleavetypeState(
      {required this.alleavetypeidwithnamecopy,
      required this.allleavetypenamelistcopy,
      required this.allleavetypenamelist,
      required this.alleavetypeidwithname,
      required this.alleavetype});

  @override
  List<Object> get props =>
      [alleavetype, alleavetypeidwithname, allleavetypenamelist];
}
