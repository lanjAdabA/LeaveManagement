import 'package:equatable/equatable.dart';

enum DeleteDeptStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class DeleteDeptState extends Equatable {
  final DeleteDeptStatus deletedeptStatus;

  const DeleteDeptState({
    required this.deletedeptStatus,
  });

  @override
  List get props => [
        deletedeptStatus,
      ];
}
