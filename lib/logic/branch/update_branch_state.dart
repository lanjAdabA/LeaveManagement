import 'package:equatable/equatable.dart';

enum UpdateBranchStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class UpdateBranchState extends Equatable {
  final UpdateBranchStatus updatebranchStatus;

  const UpdateBranchState({
    required this.updatebranchStatus,
  });

  @override
  List get props => [
        updatebranchStatus,
      ];
}
