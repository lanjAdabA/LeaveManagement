import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteInitial());
}
