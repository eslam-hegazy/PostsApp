import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class DefaultTextForm extends StatelessWidget {
  const DefaultTextForm({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.error,
    required this.numLine,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String error;
  final int numLine;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: numLine,
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
        ),
      ),
    );
  }
}
