import 'package:art2/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:art2/features/posts/presentation/pages/add_post_screen.dart';
import 'package:art2/features/posts/presentation/view/list_home_screen.dart';
import 'package:art2/features/posts/presentation/view/loading_screen.dart';
import 'package:art2/features/posts/presentation/widgets/item_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> onFresh(context) async {
      return BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 1, 38, 69),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddPostScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 38, 69),
        centerTitle: true,
        title: const Text("Posts"),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingScreen();
          } else if (state is SuccessPostsState) {
            return RefreshIndicator(
              onRefresh: () => onFresh(context),
              child: ListHomeScreen(posts: state.posts),
            );
          } else if (state is ErrorPostsState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
