import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

class SearchTextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final Color textColor;
  final Color backColor;
  final bool? isEnabled;
  final bool? isObsCured;
  final TextEditingController editCtrller;
  final TextInputType? inputType;
  final int? maxLines, maxLength;
  const SearchTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.textColor,
    required this.backColor,
    required this.editCtrller,
    this.isEnabled,
    this.isObsCured,
    required this.maxLines,
    this.maxLength,
    this.inputType = TextInputType.text,
  });

  @override
  State<SearchTextFormFieldWidget> createState() =>
      _SearchTextFormFieldWidgetState();
}

class _SearchTextFormFieldWidgetState extends State<SearchTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.backColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              maxLines: widget.maxLines,
              minLines: 1,
              style: TextStyle(color: widget.textColor),
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
              decoration: InputDecoration.collapsed(
                enabled: widget.isEnabled ?? true,
                // contentPadding:
                //     const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: widget.textColor.withOpacity(0.5)),
                border: InputBorder.none,
                // focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextFormFieldWidgetWithCallback extends StatefulWidget {
  final String hintText;
  final Color textColor;
  final Color backColor;
  final bool? isEnabled;
  final bool? isObsCured;
  final TextEditingController editCtrller;
  final TextInputType? inputType;
  final int? maxLines, maxLength;
  final Function? callback;
  const SearchTextFormFieldWidgetWithCallback({
    super.key,
    required this.hintText,
    required this.textColor,
    required this.backColor,
    required this.editCtrller,
    this.inputType = TextInputType.text,
    this.maxLength,
    this.isEnabled,
    this.isObsCured,
    this.maxLines = 1,
    this.callback,
  });

  @override
  State<SearchTextFormFieldWidgetWithCallback> createState() =>
      _SearchTextFormFieldWidgetWithCallbackState();
}

class _SearchTextFormFieldWidgetWithCallbackState
    extends State<SearchTextFormFieldWidgetWithCallback> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: widget.backColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      if (value.trim().isEmpty) return;
                      if (widget.callback != null) {
                        widget.callback!(value);
                      }
                    },
                    maxLines: widget.maxLines,
                    style: TextStyle(color: widget.textColor),
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
                    decoration: InputDecoration.collapsed(
                      enabled: widget.isEnabled ?? true,
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: widget.textColor.withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.callback != null)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.editCtrller.text.trim().isEmpty) return;
                        widget.callback!(widget.editCtrller.text.trim());
                      },
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        color: AppColors.kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search,
                            size: 20,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
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
