import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/utilities/pref_utils.dart';

class TZTextField extends StatefulWidget {
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final String? hintText, errorText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  //final bool isEnabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const TZTextField(
      {this.onChanged,
      required this.hintText,
      required this.errorText,
      required this.controller,
      this.validator,
      this.onSaved,
      this.textInputType,
      //this.focusNode,
      this.textInputAction,
      //this.isEnabled,
      this.maxLength,
      this.inputFormatters,
      super.key});

  @override
  State<TZTextField> createState() => _TZTextFieldState();
}

class _TZTextFieldState extends State<TZTextField> {
  final FocusNode _textFieldFocus = FocusNode();
  Color _color =
      PrefUtils.getUserThemePreference() == true ? kLightBlack : kMainColorFade;

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = PrefUtils.getUserThemePreference() == true ? kBlack : kWhite;
        });
      } else {
        setState(() {
          _color = PrefUtils.getUserThemePreference() == true
              ? kLightBlack
              : kMainColorFade;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      width: double.infinity,
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        cursorColor: kMainColorDark,
        keyboardType: widget.textInputType,
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validator,
        onSaved: widget.onSaved,
        focusNode: _textFieldFocus,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          labelText: widget.hintText,
          labelStyle: const TextStyle(fontSize: kFontSS, color: kGrey),
          errorStyle: kErrorTextStyle,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
          
          // filled: true,
          fillColor: _color,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}

class TZPasswordField extends StatefulWidget {
  final bool? obscureText;
  final String? hintText, helperText, errorText;
//FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const TZPasswordField(
      {this.obscureText,
      this.hintText,
      this.helperText,
      this.onChanged,
      this.errorText,
      this.controller,
      this.textInputAction,
      super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BPPasswordField createState() => _BPPasswordField();
}

class _BPPasswordField extends State<TZPasswordField> {
  bool obscureText = true;
  final FocusNode _textFieldFocus = FocusNode();
  Color _color =
      PrefUtils.getUserThemePreference() == true ? kLightBlack : kMainColorFade;

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = PrefUtils.getUserThemePreference() == true ? kBlack : kWhite;
        });
      } else {
        setState(() {
          _color = PrefUtils.getUserThemePreference() == true
              ? kLightBlack
              : kMainColorFade;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      width: double.infinity,
      //height: kPaddingFF,
      child: TextFormField(
        focusNode: _textFieldFocus,
        obscureText: obscureText,
        onChanged: widget.onChanged,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelText: widget.hintText,
            labelStyle: const TextStyle(fontSize: kFontSS, color: kGrey),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: kMainColorDark,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: kRed,
                width: 1.5,
              ),
            ),
            errorText: widget.errorText,
            errorStyle: kErrorTextStyle,
            // filled: true,
            fillColor: _color,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? IconlyLight.hide : IconlyBold.show,
                size: 20,
                color: kDeepGrey,
              ),
            )),
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}
