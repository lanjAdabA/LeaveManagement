part of 'postdepartment_cubit.dart';

enum PostDeptStatus { initial, loading, loaded, error }

abstract class PostdepartmentState extends Equatable {
  final PostDeptStatus postdeotStatus;
  //final List<Map<String,dynamic>> allbranchlist;
  const PostdepartmentState({
    required this.postdeotStatus,
    //required this.allbranchlist,
  });

  @override
  List<Object> get props => [
        postdeotStatus,
      ];
}
