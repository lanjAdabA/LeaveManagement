part of 'create_employee_cubit.dart';

enum CreateEmployeeStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class CreateEmployeeState extends Equatable {
  final CreateEmployeeStatus empstatus;

  const CreateEmployeeState({
    required this.empstatus,
  });

  @override
  List get props => [
        empstatus,
      ];
}
