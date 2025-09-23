import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Resources/Components/texts.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final Color textColor;
  final Color backColor;
  final bool? isEnabled;
  bool? isObsCured;
  final TextEditingController? editCtrller;
  final int? maxLines, maxLength;
  final TextInputType? inputType;
  final bool? isBordered;
  final String? Function(String?)? validator;
  TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.textColor,
    required this.backColor,
    this.editCtrller,
    this.labelText,
    this.inputType = TextInputType.text,
    this.maxLength,
    this.maxLines = 1,
    this.isEnabled,
    this.isObsCured = false,
    this.isBordered = false,
    this.validator,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    // widget.editCtrller?.dispose();
    super.dispose();
  }

  FocusNode focusNode = FocusNode();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    // if (focusNode.hasFocus == true) {
    //   setState(() {});
    // } else {
    //   setState(() {});
    // }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: double.maxFinite,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: focusNode.hasFocus
              ? widget.textColor.withAlpha(32)
              : widget.backColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextFormField(
                validator: widget.validator,
                enabled: widget.isEnabled != null ? widget.isEnabled! : true,
                obscureText: widget.isObsCured == false
                    ? false
                    : showPassword == true
                    ? false
                    : true,
                maxLines: widget.maxLines,
                focusNode: focusNode,
                style: TextStyle(color: widget.textColor),
                textAlign: TextAlign.left,
                controller: widget.editCtrller,
                keyboardType: widget.inputType,
                textCapitalization:
                    widget.inputType == TextInputType.emailAddress ||
                        widget.inputType == TextInputType.visiblePassword ||
                        widget.inputType == TextInputType.none
                    ? TextCapitalization.none
                    : widget.inputType == TextInputType.streetAddress
                    ? TextCapitalization.words
                    : TextCapitalization.sentences,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: widget.textColor.withOpacity(0.5),
                    fontSize: 12,
                  ),
                  label: TextWidgets.text300(
                    title: widget.labelText ?? widget.hintText,
                    fontSize: 12,
                    textColor: widget.textColor.withOpacity(1),
                  ),
                  enabledBorder: widget.isBordered == true
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.textColor.withOpacity(0.2),
                            width: 1,
                          ),
                        )
                      : InputBorder.none,
                  border: widget.isBordered == true
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.textColor,
                            width: 1,
                          ),
                        )
                      : InputBorder.none,
                  focusedBorder: widget.isBordered == true
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.textColor,
                            width: 1,
                          ),
                        )
                      : InputBorder.none,
                  // hintText: widget.hintText,
                  // hintStyle:
                  //     TextStyle(color: widget.textColor.withOpacity(0.5))
                ),
              ),
            ),
            if (widget.isObsCured == true)
              Positioned(
                top: 0,
                bottom: 0,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    showPassword = !showPassword;
                    setState(() {});
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: widget.textColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        showPassword == true
                            ? Icons.vpn_key_rounded
                            : Icons.remove_red_eye,
                        color: widget.textColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PhoneFieldWidget extends StatefulWidget {
  final String hintText;
  final Color textColor;
  final Color backColor;
  final bool? isEnabled;
  final bool? isObsCured;
  final TextEditingController editCtrller;
  TextInputType inputType = TextInputType.text;
  int maxLines = 1;
  int? maxLength;
  final String? Function(String?)? validator;
  Function callback;

  PhoneFieldWidget({
    super.key,
    required this.hintText,
    required this.textColor,
    required this.backColor,
    required this.editCtrller,
    TextInputType? inputType,
    maxLength,
    this.isEnabled,
    this.isObsCured,
    required this.maxLines,
    this.validator,
    required this.callback,
  });

  @override
  State<PhoneFieldWidget> createState() => _PhoneFieldWidgetState();
}

class _PhoneFieldWidgetState extends State<PhoneFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: TextStyle(color: widget.textColor.withOpacity(0.7)),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: widget.backColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Container(
                //   // width: 80,
                //   child: CountryCodePicker(
                //     onChanged: (e) {
                //       widget.callback(e);
                //     },
                //     padding: const EdgeInsets.all(0),
                //     initialSelection: 'CD',
                //     showCountryOnly: true,
                //     hideMainText: true,
                //     showDropDownButton: true,
                //     showOnlyCountryWhenClosed: false,
                //     favorite: ['+243', 'CD'],
                //     flagDecoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(7),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: widget.maxLines,
                      style: TextStyle(
                        color: widget.textColor,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                      controller: widget.editCtrller,
                      keyboardType: widget.inputType,
                      maxLength: widget.maxLength,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      obscureText: widget.isObsCured ?? false,
                      inputFormatters: [
                        widget.inputType == TextInputType.number ||
                                widget.inputType == TextInputType.phone
                            ? FilteringTextInputFormatter.digitsOnly
                            : FilteringTextInputFormatter.deny(RegExp('[]')),
                      ],
                      decoration: InputDecoration(
                        enabled: widget.isEnabled ?? true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: widget.textColor.withOpacity(0.5),
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      // validator: widget.validator,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
