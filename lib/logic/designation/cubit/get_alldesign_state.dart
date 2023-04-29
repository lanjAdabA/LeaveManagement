part of 'get_alldesign_cubit.dart';

class GetAlldesignState extends Equatable {
  final List<AllDesignModel> alldesignlist;
  final Map<dynamic, dynamic> designidwithname;
  final List<String> alldesignationnamelist;
  final List<String> alldesignationnamelist_noall;
  const GetAlldesignState(
      {required this.alldesignationnamelist_noall,
      required this.alldesignationnamelist,
      required this.designidwithname,
      required this.alldesignlist});

  @override
  List<Object> get props => [
        alldesignlist,
        designidwithname,
        alldesignationnamelist,
        alldesignationnamelist_noall
      ];
}
