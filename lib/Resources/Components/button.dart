import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:provider/provider.dart';

import '../Providers/app_state_provider.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.backColor,
    required this.textColor,
    required this.callback,
    this.size = 250,
    this.icon,
    this.canSync = false,
  });

  final String text;
  final Color backColor;
  final Color textColor;
  final Function callback;
  final double? size;
  final IconData? icon;
  final bool? canSync;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isButtonHovered = false;

  // double width = 250;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appStateProvider, _) {
        // if (appStateProvider.isAsync == true && widget.canSync == true) {
        //   width = 40;
        //   setState(() {});
        // }
        return GestureDetector(
          onTap: () {
            if (context.read<AppStateProvider>().isAsync == false) {
              widget.callback();
            }
            // widget.callback();
          },
          child: MouseRegion(
            onHover: (value) => setState(() {
              isButtonHovered = true;
            }),
            onEnter: (value) => setState(() {
              isButtonHovered = true;
            }),
            onExit: (value) => setState(() {
              isButtonHovered = false;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              width: 250,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isButtonHovered
                    ? widget.backColor.withOpacity(0.9)
                    : widget.backColor,
                borderRadius: BorderRadius.circular(64),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null && appStateProvider.isAsync == false)
                    Icon(widget.icon, color: widget.textColor),
                  if (widget.icon != null && appStateProvider.isAsync == false)
                    const SizedBox(width: 8),
                  Flexible(
                    child: widget.canSync == null || widget.canSync == false
                        ? FittedBox(
                            child: Text(
                              widget.text,
                              style: TextStyle(
                                color: isButtonHovered
                                    ? widget.textColor.withOpacity(0.5)
                                    : widget.textColor,
                              ),
                            ),
                          )
                        : appStateProvider.isAsync == false &&
                              (widget.canSync != null && widget.canSync == true)
                        ? FittedBox(
                            child: Text(
                              widget.text,
                              style: TextStyle(
                                color: isButtonHovered
                                    ? widget.textColor.withOpacity(0.5)
                                    : widget.textColor,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.textColor,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class IconButtonWidget extends StatefulWidget {
  const IconButtonWidget({
    super.key,
    required this.backColor,
    this.secondBackColor,
    required this.textColor,
    required this.callback,
    this.size,
    required this.icon,
    this.isBordered = false,
  });

  final Color backColor;
  final Color? secondBackColor;
  final Color textColor;
  final Function callback;
  final double? size;
  final IconData icon;
  final bool? isBordered;

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.callback();
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              widget.isBordered == true
                  ? AppColors.kTransparentColor
                  : widget.backColor,
              widget.isBordered == true
                  ? AppColors.kTransparentColor
                  : widget.secondBackColor ?? widget.backColor,
            ],
          ),
          // color: widget.isBordered == true && isButtonHovered == false
          //     ? Colors.transparent
          //     : isButtonHovered
          //         ? widget.backColor.withOpacity(0.9)
          //         : widget.backColor,
          border: widget.isBordered == true
              ? Border.all(color: widget.backColor, width: 1)
              : null,
          borderRadius: BorderRadius.circular(120),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Icon(
            key: ValueKey<Color>(widget.textColor),
            widget.icon,
            size: widget.size ?? 24,
            color: widget.isBordered == true
                ? widget.backColor
                : widget.textColor,
          ),
        ),
      ),
    );
  }
}
