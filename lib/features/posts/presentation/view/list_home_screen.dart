import 'package:art2/features/posts/presentation/pages/post_details_screen.dart';
import 'package:art2/features/posts/presentation/pages/update_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:art2/features/posts/domain/entities/post.dart';
import 'package:sizer/sizer.dart';

import '../widgets/item_post.dart';

class ListHomeScreen extends StatelessWidget {
  final List<Post> posts;
  const ListHomeScreen({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(1.h),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return PostDetailsScreen(posts: posts[index]);
              }));
            },
            child: ItemPost(post: posts[index]));
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: posts.length,
    );
  }
}
