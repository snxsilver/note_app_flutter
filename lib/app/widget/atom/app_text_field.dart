import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/app_text_style.dart';

enum AppTextFieldType {
  text,
  password,
  datePicker,
}

class AppTextField extends StatefulWidget {
  final AppTextFieldType type;
  final TextEditingController? controller;
  final String? labelText;
  final Function(String)? onChanged;
  final double iconsSize;
  final bool isHasError;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool rounded;
  final String? hintText;
  final double borderRadius;

  const AppTextField({
    super.key,
    this.type = AppTextFieldType.text,
    this.labelText,
    this.onChanged,
    this.iconsSize = 14,
    this.isHasError = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.rounded = true,
    this.hintText,
    this.borderRadius = 6,
    this.controller,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  Color _iconsColor = AppColors.blackLv5;
  Color _borderColor = AppColors.blackLv7;

  bool _obsecureText = false;

  void onChanged(value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // _obsecureText = widget.type == AppTextFieldType.password ? true : false;

    _controller = widget.controller ?? TextEditingController();

    _obsecureText = widget.type == AppTextFieldType.password;

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget(),
        widget.type == AppTextFieldType.datePicker ? datePicker() : textField(),
      ],
    );
  }

  Widget labelWidget() {
    if (widget.labelText == null || widget.labelText == '') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        widget.labelText!,
        style: AppTextStyle.bodyMedium(
          fontWeight: AppFontWeight.regular,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget textVisibilityIconButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obsecureText = !_obsecureText;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          _obsecureText
              ? Icons.visibility_off_rounded
              : Icons.remove_red_eye_rounded,
          color: _iconsColor,
          size: widget.iconsSize,
        ),
      ),
    );
  }

  TextStyle textFieldTextStyle() {
    return AppTextStyle.bodyMedium(
      fontWeight: AppFontWeight.regular,
      color: widget.isHasError ? AppColors.error : AppColors.black,
    );
  }

  int? textFieldMaxLines() {
    if (widget.type == AppTextFieldType.password) {
      return 1;
    }

    if (widget.rounded && (widget.minLines ?? 0) <= 1) {
      return 1;
    }

    return widget.maxLines;
  }

  Widget? suffixIconWidget() {
    if (widget.type == AppTextFieldType.password) {
      return textVisibilityIconButton();
    }
    return null;
  }

  Widget textField() {
    return TextField(
      focusNode: _focusNode,
      controller: _controller,
      onChanged: (value) => onChanged(value),
      style: textFieldTextStyle(),
      cursorColor: AppColors.blackLv1,
      cursorWidth: 1.5,
      obscureText: _obsecureText,
      minLines: widget.minLines,
      maxLines: textFieldMaxLines(),
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        // counterText: widget.showCounter ? null : '',
        isDense: true,
        filled: true,
        fillColor: AppColors.white,
        // prefixIcon: widget.prefixWidget ?? prefixIconWidget(),
        suffixIcon: suffixIconWidget(),
        hintText: widget.hintText,
        hintStyle: AppTextStyle.bodyMedium(
          fontWeight: AppFontWeight.regular,
          color: widget.isHasError ? AppColors.redLv5 : AppColors.blackLv5,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.primary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.error,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.error,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: _borderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: _borderColor,
          ),
        ),
      ),
    );
  }

  Widget datePicker() {
    return TextFormField(
      onTap: () {
        // print("text: ${_controller.text}");
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        ).then((value) {
          if (value != null) {
            _controller.text =
                DateFormat("EEEE, d MMMM yyyy", "id_ID").format(value);
            setState(() {});
            // onChanged(value);
          }
        });
        // print(_controller.text);
      },
      controller: _controller,
      maxLines: null,
      readOnly: true,
      // enabled: false,
      keyboardType: TextInputType.text,
      autocorrect: false,
      decoration: InputDecoration(
        // counterText: widget.showCounter ? null : '',
        isDense: true,
        filled: true,
        fillColor: AppColors.white,
        // prefixIcon: widget.prefixWidget ?? prefixIconWidget(),
        suffixIcon: suffixIconWidget(),
        hintText: widget.hintText,
        hintStyle: AppTextStyle.bodyMedium(
          fontWeight: AppFontWeight.regular,
          color: widget.isHasError ? AppColors.redLv5 : AppColors.blackLv5,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.primary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.error,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.error,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: _borderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.rounded && (widget.minLines ?? 0) <= 1
                ? 100
                : widget.borderRadius),
          ),
          borderSide: BorderSide(
            width: 1,
            color: _borderColor,
          ),
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
      // initialValue:
      //     controller.completionDate.value.toString(),
    );
  }
}
