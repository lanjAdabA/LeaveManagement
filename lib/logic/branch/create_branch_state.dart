import 'package:equatable/equatable.dart';

enum BranchStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class BranchState extends Equatable {
  final BranchStatus branchStatus;

  const BranchState({
    required this.branchStatus,
  });

  @override
  List get props => [
        branchStatus,
      ];
}
