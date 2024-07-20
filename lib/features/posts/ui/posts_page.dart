import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_with_api/features/posts/bloc/post_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  PostBloc postBloc = PostBloc();

  @override
  void initState() {
    // TODO: implement initState
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          postBloc.add(PostAddEvent());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Posts Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (PostFetchingLoadingState):
              return const Center(
                child: CircularProgressIndicator(),
              );
            case const (PostFetchingSuccessfulState):
              final successState = state as PostFetchingSuccessfulState;
              return ListView.builder(
                itemCount: successState.posts.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(successState.posts[index].title),
                        Text(successState.posts[index].body)
                      ],
                    ),
                  );
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
