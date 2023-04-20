part of 'login_verifybymail_cubit.dart';

enum VerifyStatusformail { initial, loading, loaded, error }

class LoginVerifybymailState extends Equatable {
  final VerifyStatusformail status;

  const LoginVerifybymailState({required this.status});

  @override
  List get props => [
        status,
      ];
}
