import 'package:equatable/equatable.dart';

enum UpdateDeptStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class UpdateDeptState extends Equatable {
  final UpdateDeptStatus updatedeptStatus;

  const UpdateDeptState({
    required this.updatedeptStatus,
  });

  @override
  List get props => [
        updatedeptStatus,
      ];
}
