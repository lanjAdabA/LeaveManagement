part of 'add_leave_balance_cubit.dart';

enum AddLeaveBalanceStatus { initial, loading, loaded, error }

class AddLeaveBalanceState extends Equatable {
  final AddLeaveBalanceStatus empstatus;

  const AddLeaveBalanceState({
    required this.empstatus,
  });

  @override
  List get props => [
        empstatus,
      ];
}
