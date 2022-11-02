import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/resources/colors_manager.dart';

class MyTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool isPassword;
  final Function(String value)? onChanged;
  final Function()? onTap;
  final bool isEnabled;
  final bool readOnly;
  final int? maxLines;
  final TextCapitalization? capitalization;
  final String? prefixIcon;
  final InputDecoration? decoration;
  final Widget? suffixIcon;
  final int? maxLength;

  const MyTextField(
      {super.key,
      this.hintText,
      this.decoration,
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.readOnly = false,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onChanged,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.maxLength});

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 19.sp, horizontal: 31.sp),
      child: TextField(
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        onTap: widget.onTap,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        cursorColor: Colors.blue,
        textCapitalization: widget.capitalization ?? TextCapitalization.none,
        enabled: widget.isEnabled,
        autofocus: false,
        obscureText: widget.isPassword,
        decoration: widget.decoration ??
            InputDecoration(
                contentPadding: EdgeInsets.all(13.sp),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.textLightGrey),
                isDense: true,
                fillColor: const Color(0xFFF7F7F7),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50))),
        onChanged: widget.onChanged,
      ),
    );
  }
}
