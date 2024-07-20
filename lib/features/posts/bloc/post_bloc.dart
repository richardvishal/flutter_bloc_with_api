import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_with_api/features/posts/models/post_data_ui_model.dart';
import 'package:flutter_bloc_with_api/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
    emit(PostFetchingSuccessfulState(posts: posts));
    print(posts);
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostState> emit) async{
    bool success = await PostsRepo.addPost();
    print(success);
    if(success){
      emit(PostAddingSuccessState());
    }
    else{
      emit(PostAddingErrorState());
    }
  }
}
