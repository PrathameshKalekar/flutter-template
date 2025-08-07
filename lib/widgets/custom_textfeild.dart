import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../core/theme/app_theme.dart';

enum CustomTextFieldType {
  text,
  email,
  password,
  phone,
  otp,
  dropdown,
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final CustomTextFieldType type;
  final List<String>? dropdownItems;
  final String? selectedDropdownValue;
  final Function(String?)? onDropdownChanged;
  final bool isEnabled;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.validator,
    this.type = CustomTextFieldType.text,
    this.dropdownItems,
    this.selectedDropdownValue,
    this.onDropdownChanged,
    this.isEnabled = true,
    this.maxLength,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  bool _obscureText = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.obscureText;
    
    if (widget.type == CustomTextFieldType.password) {
      _obscureText = true;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case CustomTextFieldType.otp:
        return _buildOtpField();
      case CustomTextFieldType.dropdown:
        return _buildDropdownField();
      default:
        return _buildTextField();
    }
  }

  Widget _buildTextField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: TextFormField(
        controller: _controller,
        validator: widget.validator,
        enabled: widget.isEnabled,
        maxLength: widget.maxLength,
        keyboardType: _getKeyboardType(),
        textCapitalization: _getTextCapitalization(),
        textInputAction: _getTextInputAction(),
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onSubmitted,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        inputFormatters: _getInputFormatters(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: _buildSuffixIcon(),
          filled: true,
          fillColor: widget.isEnabled ? Colors.white : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: primaryColor,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red[300]!,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red[400]!,
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          counterText: '',
        ),
      ),
    );
  }

  Widget _buildOtpField() {
    return PinFieldAutoFill(
      decoration: BoxLooseDecoration(
        strokeColorBuilder: FixedColorBuilder(_isFocused ? primaryColor : Colors.grey[300]!),
        strokeWidth: _isFocused ? 1.5 : 1,
        radius: const Radius.circular(8),
        gapSpace: 12,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bgColorBuilder: FixedColorBuilder(Colors.white),
      ),
      currentCode: _controller.text,
      onCodeChanged: (code) {
        _controller.text = code ?? '';
        widget.onChanged?.call(code ?? '');
      },
      onCodeSubmitted: (code) {
        widget.onChanged?.call(code);
        widget.onSubmitted?.call(code);
      },
      codeLength: 6,
    );
  }

  Widget _buildDropdownField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isEnabled ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isFocused ? primaryColor : Colors.grey[300]!,
            width: _isFocused ? 1.5 : 1,
          ),
        ),
        child: DropdownButtonFormField<String>(
          value: widget.selectedDropdownValue,
          onChanged: widget.isEnabled ? widget.onDropdownChanged : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixIcon: widget.prefixIcon,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: widget.dropdownItems?.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList() ?? [],
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: _isFocused ? primaryColor : Colors.grey[400],
          ),
          dropdownColor: Colors.white,
          style: TextStyle(
            color: widget.isEnabled ? Colors.black : Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.type == CustomTextFieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey[600],
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }

  TextInputType _getKeyboardType() {
    // For multi-line text fields, use multiline keyboard
    if (widget.maxLines != null && widget.maxLines! > 1) {
      return TextInputType.multiline;
    }
    
    switch (widget.type) {
      case CustomTextFieldType.email:
        return TextInputType.emailAddress;
      case CustomTextFieldType.phone:
        return TextInputType.phone;
      case CustomTextFieldType.password:
        return TextInputType.visiblePassword;
      default:
        return widget.keyboardType ?? TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.type) {
      case CustomTextFieldType.phone:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ];
      case CustomTextFieldType.email:
        return [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ];
      default:
        return null;
    }
  }

  TextCapitalization _getTextCapitalization() {
    switch (widget.type) {
      case CustomTextFieldType.email:
        return TextCapitalization.none; // Email should be lowercase
      case CustomTextFieldType.password:
        return TextCapitalization.none; // Password should be lowercase
      case CustomTextFieldType.phone:
        return TextCapitalization.none; // Phone should be lowercase
      case CustomTextFieldType.otp:
        return TextCapitalization.none; // OTP should be lowercase
      case CustomTextFieldType.text:
        return widget.textCapitalization; // Use custom or default
      default:
        return widget.textCapitalization;
    }
  }

  TextInputAction _getTextInputAction() {
    // For multi-line text fields, use newline action
    if (widget.maxLines != null && widget.maxLines! > 1) {
      return TextInputAction.newline;
    }
    
    switch (widget.type) {
      case CustomTextFieldType.email:
        return TextInputAction.next; // Move to next field
      case CustomTextFieldType.password:
        return TextInputAction.done; // Done for password
      case CustomTextFieldType.phone:
        return TextInputAction.next; // Move to next field
      case CustomTextFieldType.otp:
        return TextInputAction.done; // Done for OTP
      case CustomTextFieldType.text:
        return widget.textInputAction ?? TextInputAction.next;
      default:
        return widget.textInputAction ?? TextInputAction.next;
    }
  }
}