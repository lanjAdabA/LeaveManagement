part of 'leave_report_cubit.dart';

enum GetLeaveStatus { initial, loading, loaded, error }

class GetLeaveReportState extends Equatable {
  final List<LeaveReportModel> leavereportlist;

  const GetLeaveReportState({required this.leavereportlist});

  @override
  List<Object> get props => [
        leavereportlist,
      ];
}
