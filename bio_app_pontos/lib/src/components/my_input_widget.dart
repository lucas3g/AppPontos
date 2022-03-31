import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bio_app_pontos/src/theme/app_theme.dart';

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
  final TextCapitalization textCapitalization;
  final Function()? onTap;
  final void Function()? onEditingComplete;

  const MyInputWidget({
    Key? key,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.inputFormaters,
    this.onFieldSubmitted,
    required this.onChanged,
    required this.textEditingController,
    this.campoVazio,
    required this.formKey,
    this.autovalidateMode,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onEditingComplete,
  }) : super(key: key);

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
        onEditingComplete: widget.onEditingComplete,
        textCapitalization: widget.textCapitalization,
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
          } else if (widget.hintText == 'Celular' &&
              value
                      .replaceAll('(', '')
                      .replaceAll(')', '')
                      .replaceAll(' ', '')
                      .replaceAll('-', '')
                      .length <
                  11) {
            return 'Celular deve conter 11 caracteres';
          } else if (widget.hintText == 'Placa' && value.length < 7) {
            return 'Placa deve conter 7 caracteres';
          } else if (widget.hintText == 'Senha' && value.length < 6) {
            return 'Senha deve conter pelo menos 6 caracteres';
          } else if (widget.hintText == 'Nome Completo' && value.length < 5) {
            return 'Nome deve conter pelo menos 5 caracteres';
          }
          return null;
        },
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          widget.onChanged(value);
          setState(() {});
        },
        onTap: widget.onTap,
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
