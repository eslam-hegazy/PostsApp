import 'package:art2/features/posts/presentation/pages/home_scree.dart';
import 'package:art2/features/posts/presentation/pages/update_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:art2/features/posts/domain/entities/post.dart';
import 'package:art2/features/posts/presentation/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:art2/features/posts/presentation/widgets/defaultTextForm.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post posts;
  PostDetailsScreen({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 38, 69),
        centerTitle: true,
        title: Text(
          "Post Details",
        ),
      ),
      body: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
        builder: (context, state) {
          if (state is LoadingAddPostState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(3.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    posts.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.h),
                    child: const Divider(),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    posts.body,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.h),
                    child: const Divider(),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 1, 38, 69),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return UpDatePostScreen(post: posts);
                          }));
                        },
                        icon: const Icon(Icons.edit),
                        label: Text(
                          "Edit",
                          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.redAccent),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                "Are You Sure ?",
                                style: GoogleFonts.abel(),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<AddDeleteUpdateBloc>(
                                            context)
                                        .add(
                                      DeletePostEvent(postId: posts.id!),
                                    );
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (_) {
                                      return const HomeScreen();
                                    }), (route) => false);
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        label: Text(
                          "Remove",
                          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is SuccessDeletePostState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is ErrorDeletePostState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
