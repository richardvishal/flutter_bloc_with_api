part of 'post_bloc.dart';

@immutable
sealed class PostState {}

sealed class PostActionState extends PostState {}

final class PostInitial extends PostState {}

class PostFetchingLoadingState extends PostState {}

class PostFetchingErrorState extends PostState {}

class PostFetchingSuccessfulState extends PostState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessfulState({required this.posts});
}

class PostAddingSuccessState extends PostActionState {}

class PostAddingErrorState extends PostActionState {}
