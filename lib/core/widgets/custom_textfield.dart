import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Function(String)? onChange;
  final TextEditingController controller;
  final bool obscureText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final String? errorText;
  final Widget? prefixIcon;
  const CustomTextField({
    super.key,
    required this.hint,
    this.onChange,
    this.obscureText = false,
    this.validator,
    required this.controller,
    this.errorText,
    this.readOnly,
    this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  Color labelColor = ColorManager.white;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  String? _validate(String? value) {
    final error = widget.validator != null
        ? widget.validator!(value)
        : (value!.isEmpty ? 'This field is required' : null);
    if (error != null && error.isNotEmpty) {
      setState(() {
        labelColor = Colors.red;
      });
    }
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.font18W400White(color: Color(0xffD3D3D3)),
      obscureText: _obscureText, 
      validator: _validate,
      readOnly: widget.readOnly ?? false,
      onChanged: widget.onChange,
      controller: widget.controller,
      decoration: InputDecoration(
        errorText: widget.errorText,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100.r)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100.r)),
          borderSide: BorderSide(color: ColorManager.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100.r)),
          borderSide: BorderSide(color: ColorManager.white),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,

        hintText: widget.hint,
        hintStyle: const TextStyle(color: ColorManager.white),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: ColorManager.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; 
                  });
                },
              )
            : null, 
      ),
    );
  }
}
