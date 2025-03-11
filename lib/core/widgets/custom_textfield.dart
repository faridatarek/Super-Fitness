import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/utils/color_manager.dart';
import '../../utils/text_style.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Function(String)? onChange;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final String? errorText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.hint,
    this.onChange,
    this.obscureText = false,
    this.validator,
    required this.controller,
    this.errorText,
    this.readOnly = false,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  String? _validate(String? value) {
    return widget.validator?.call(value) ??
        (value?.isEmpty ?? true ? 'This field is required' : null);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      style: AppTextStyles.font18W400White(
          color: const Color(0xffD3D3D3), fontSize: 14),
      obscureText: _obscureText,
      validator: _validate,
      readOnly: widget.readOnly,
      onChanged: widget.onChange,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        errorText: widget.errorText,
        errorStyle: TextStyle(fontSize: 12.sp),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: const BorderSide(color: ColorManager.white, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: const BorderSide(color: ColorManager.white, width: 1.5),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.hint,
        hintStyle: AppTextStyles.font18W400White(fontSize: 14),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: widget.prefixIcon,
              )
            : null,
        suffixIcon: widget.obscureText && !widget.readOnly
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: ColorManager.white,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : null,
      ),
    );
  }
}
