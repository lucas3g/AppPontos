import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?)? onFieldSubmitted;
  final Function(String?) onChanged;
  final TextEditingController textEditingController;
  final String? campoVazio;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode? autovalidateMode;
  const MyInputWidget(
      {Key? key,
      required this.focusNode,
      this.keyboardType = TextInputType.text,
      required this.hintText,
      this.obscureText = false,
      this.suffixIcon,
      this.inputFormaters,
      this.onFieldSubmitted,
      this.maxLength,
      this.campoVazio,
      required this.formKey,
      required this.textEditingController,
      required this.onChanged,
      this.autovalidateMode})
      : super(key: key);

  @override
  State<MyInputWidget> createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode != null
          ? widget.autovalidateMode
          : AutovalidateMode.disabled,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.campoVazio;
          } else if (widget.hintText == 'CPF' && !CPFValidator.isValid(value)) {
            return 'CPF Inválido';
          } else if (widget.hintText == 'E-Mail' &&
              !RegExp(
                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
              ).hasMatch(value)) {
            return 'E-Mail Inválido';
          }
          return null;
        },
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          widget.onChanged(value);
          setState(() {});
        },
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormaters,
        onFieldSubmitted: widget.onFieldSubmitted,
        maxLength: widget.maxLength,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          label: Text(widget.hintText),
          suffixIcon: widget.suffixIcon,
          filled: true,
          isDense: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: widget.textEditingController.text.isNotEmpty
                  ? AppTheme.colors.primary
                  : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
