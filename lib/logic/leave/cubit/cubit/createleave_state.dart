part of 'createleave_cubit.dart';

enum CreateLeaveStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class CreateleaveState extends Equatable {
  final CreateLeaveStatus empstatus;

  const CreateleaveState({
    required this.empstatus,
  });

  @override
  List get props => [
        empstatus,
      ];
}
