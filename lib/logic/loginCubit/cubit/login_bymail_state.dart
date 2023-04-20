part of 'login_bymail_cubit.dart';

enum SendingotpStatusformail { initial, loading, loaded, error }

class LoginBymailState extends Equatable {
  final bool issend;

  const LoginBymailState({
    required this.issend,
  });

  @override
  List get props => [issend];
}
