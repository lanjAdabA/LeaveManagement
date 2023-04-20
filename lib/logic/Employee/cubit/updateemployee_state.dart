part of 'updateemployee_cubit.dart';

enum UpdateEmployeeStatus { initial, loading, loaded, error }

class UpdateemployeeState extends Equatable {
  final UpdateEmployeeStatus empstatus;

  const UpdateemployeeState({
    required this.empstatus,
  });

  @override
  List get props => [
        empstatus,
      ];
}
