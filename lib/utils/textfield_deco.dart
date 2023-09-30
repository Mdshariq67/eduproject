import 'package:eduproject/utils/colors.dart';
import 'package:flutter/material.dart';

InputDecoration builInputDecoration(String hintText, Widget? suffixIcon) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    isDense: true,
    filled: true,
    fillColor: EduProColors.bgcolor,
    hintText: hintText,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: EduProColors.bgcolor, width: 1.5)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: EduProColors.bgcolor,
        width: 1.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: EduProColors.bgcolor,
        width: 1.5,
      ),
    ),
  );
}
