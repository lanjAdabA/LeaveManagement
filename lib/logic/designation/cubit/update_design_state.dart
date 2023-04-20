import 'package:equatable/equatable.dart';

enum UpdateDesignStatus { initial, loading, loaded, error }

// enum VerifyStatusformail { initial, loading, loaded, error }

class UpdateDesignState extends Equatable {
  final UpdateDesignStatus updatedesignStatus;

  const UpdateDesignState({
    required this.updatedesignStatus,
  });

  @override
  List get props => [
        updatedesignStatus,
      ];
}
