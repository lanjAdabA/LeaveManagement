part of 'login_byphone_cubit.dart';

enum Status2 { initial, loading, loaded, error }

class LoginByphoneState extends Equatable {
  final Status2 status;
  const LoginByphoneState({required this.status});

  @override
  List get props => [status];
}
