part of 'check_empcode_cubit.dart';

class CheckEmpcodeState extends Equatable {
  final String isexist;
  const CheckEmpcodeState({required this.isexist});

  @override
  List<Object> get props => [isexist];
}
