import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({Key? key,
    this.hintText,
    this.text,
    this.keyboardType,
    required this.onChanged,
    this.obscureText =false
  }) : super(key: key);

  String? hintText;
  final TextInputType? keyboardType;
  String? text;
  Function(String?) onChanged;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(45),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          cursorColor: Colors.blue,
          keyboardType: keyboardType,
          obscureText:obscureText!,
          validator: (data) {
            if (data!.isEmpty) {
              return 'field is required';
            }
          },
          onChanged: onChanged,

        ),
      ),
    );
  }
}