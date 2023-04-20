part of 'getallleavetype_cubit.dart';

class GetallleavetypeState extends Equatable {
  final List<Leaf> alleavetype;
  final Map<dynamic, dynamic> alleavetypeidwithname;
  final List<String> allleavetypenamelist;
  const GetallleavetypeState(
      {required this.allleavetypenamelist,
      required this.alleavetypeidwithname,
      required this.alleavetype});

  @override
  List<Object> get props =>
      [alleavetype, alleavetypeidwithname, allleavetypenamelist];
}
