import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscuretextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  TodoListField(
      {super.key,
      required this.label,
      this.suffixIconButton,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.focusNode})
      : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado em conjunto com siffixIconButton'),
        obscuretextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscuretextVN,
      builder: (_, obscuretextValue, child) {
        return TextFormField(
          focusNode: focusNode,
          validator: validator,
          controller: controller,
          obscureText: obscuretextValue,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          obscuretextVN.value = !obscuretextValue;
                        },
                        icon: Icon(!obscuretextValue
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye_sharp),
                      )
                    : null),
          ),
        );
      },
    );
  }
}
