part of 'getemployeelist_cubit.dart';

abstract class PostState {}

class PostLoadingState extends PostState {
  final String loading;

  PostLoadingState(this.loading);
}

class PostinitialState extends PostState {
  final String initial;

  PostinitialState(this.initial);
}

class PostLoadedState extends PostState {
  final bool isloading;
  final List<Employee> allemployeelist;
  final bool isempty;

  PostLoadedState(
      {required this.isempty,
      required this.isloading,
      required this.allemployeelist});
}

class PostErrorState extends PostState {
  final String error;
  PostErrorState(this.error);
}
