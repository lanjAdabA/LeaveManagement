part of 'post_designation_cubit.dart';

enum PostDesignStatus { initial, loading, loaded, error }

abstract class PostDesignationState extends Equatable {
  final PostDesignStatus postDesignStatus;

  const PostDesignationState({required this.postDesignStatus});

  @override
  List<Object> get props => [postDesignStatus];
}

//class PostDesignationInitial extends PostDesignationState {}
