import 'package:equatable/equatable.dart';

enum DeleteDesignStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class DeleteDesignState extends Equatable {
  final DeleteDesignStatus deletedesignStatus;

  const DeleteDesignState({
    required this.deletedesignStatus,
  });

  @override
  List get props => [
        deletedesignStatus,
      ];
}
