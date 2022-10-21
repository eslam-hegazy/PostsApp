import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/post.dart';

class ItemPost extends StatelessWidget {
  const ItemPost({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        post.title,
        style: GoogleFonts.acme(),
      ),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 1, 38, 69),
        child: Text(post.id.toString()),
      ),
      subtitle: Text(post.body),
    );
  }
}
