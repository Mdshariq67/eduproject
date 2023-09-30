import 'package:eduproject/utils/textfield_deco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfieldwithtitle extends StatelessWidget {
  String? initialValue;
  final String? Function(String?)? validator;
  final bool isEditing;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final String title;
  final Size size;
  final TextEditingController? controller;
  final String hint;
  final Widget? suffixIcon;

   Textfieldwithtitle({
    Key? key,
    this.initialValue,
    this.isEditing = false,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.obsecureText = false,
    this.suffixIcon,
    required this.hint,
    required this.size,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                height: 1.4,
                fontSize: 14.0,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 32, 32, 32),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue: initialValue,
            obscureText: obsecureText,
            validator: validator,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14),
            readOnly: !isEditing,
            controller: controller,
            decoration: builInputDecoration(hint, suffixIcon),
          ),
        ],
      ),
    );
  }
}
