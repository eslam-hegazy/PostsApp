import 'package:art2/features/posts/presentation/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:art2/features/posts/presentation/widgets/defaultTextForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:art2/features/posts/domain/entities/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddPostScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 38, 69),
        centerTitle: true,
        title: Text("Add Post"),
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
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12.h),
                      DefaultTextForm(
                        controller: titleController,
                        hintText: "title",
                        error: "Please Enter Title",
                        numLine: 1,
                      ),
                      SizedBox(height: 3.h),
                      DefaultTextForm(
                        controller: bodyController,
                        hintText: "Body",
                        error: "Please Enter Body",
                        numLine: 8,
                      ),
                      SizedBox(height: 1.h),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 1, 38, 69),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final postData = Post(
                              title: titleController.text,
                              body: bodyController.text,
                            );
                            BlocProvider.of<AddDeleteUpdateBloc>(context).add(
                              AddPostEvent(post: postData),
                            );
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: Text("Add"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is SuccessAddPostState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is ErrorAddPostState) {
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
