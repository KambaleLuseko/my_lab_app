import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/responsive.dart';

class ListItemModel {
  final String title, value;
  final Widget? icon;
  final Color? textColor;
  ListItemModel({
    required this.title,
    required this.value,
    this.icon,
    this.textColor,
  });

  static fromJSON(json) {
    return ListItemModel(
      title: json['title']?.toString() ?? "",
      value: json['value']?.toString() ?? "",
      icon: json['icon'] ?? Container(),
      textColor: json['color'] ?? Colors.black,
    );
  }
}

class ListItem extends StatefulWidget {
  Color? backColor = AppColors.kTextFormBackColor;
  Color? textColor = AppColors.kPrimaryColor;
  final String title, subtitle;
  final List<ListItemModel>? detailsFields;
  final ListItemModel? middleFields;
  final ListItemModel? submiddleFields;
  final IconData? icon, updateIcon, deleteIcon;
  bool? hasUpdate = false, hasDelete = false, keepMidleFields = false;
  Function(Map)? updateCallback, deleteCallback, onTap;
  final Map? data;
  final Widget? leading;
  ListItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.backColor,
    this.textColor,
    this.middleFields,
    this.submiddleFields,
    this.detailsFields,
    this.hasUpdate = false,
    this.hasDelete = false,
    this.keepMidleFields = false,
    this.icon,
    this.updateIcon = Icons.border_color,
    this.deleteIcon = Icons.delete,
    this.updateCallback,
    this.deleteCallback,
    this.onTap,
    this.data,
    this.leading,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  void initState() {
    super.initState();
  }

  bool displayDetails = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          widget.detailsFields == null ||
              widget.detailsFields!.isEmpty && widget.onTap != null
          ? () {
              widget.onTap!(widget.data ?? {});
            }
          : widget.detailsFields == null || widget.detailsFields!.isEmpty
          ? null
          : () {
              setState(() {
                if (widget.detailsFields == null ||
                    widget.detailsFields!.isEmpty) {
                  return;
                }
                displayDetails = !displayDetails;
              });
            },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8),
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: widget.backColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (widget.backColor != AppColors.kTransparentColor &&
                (widget.detailsFields ?? []).isNotEmpty)
              BoxShadow(
                offset: Offset(0, displayDetails == true ? 1 : 0),
                color: widget.backColor?.withOpacity(0.5) ?? Colors.transparent,
                blurRadius: displayDetails == true ? 2.0 : 0,
                spreadRadius: 0,
              ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.backColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.icon != null)
                    Card(
                      color: widget.textColor!.withOpacity(0.1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          widget.icon,
                          size: 32,
                          color: widget.textColor!,
                        ),
                      ),
                    ),
                  if (widget.leading != null && widget.icon == null)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: widget.leading!,
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidgets.textBold(
                                  title: widget.title.toString(),
                                  fontSize: 14,
                                  textColor: widget.textColor!,
                                ),
                                const SizedBox(height: 8),
                                TextWidgets.text300(
                                  maxLines: 2,
                                  title: widget.subtitle.toString(),
                                  fontSize: 14,
                                  textColor: widget.textColor!,
                                ),
                              ],
                            ),
                          ),
                          if ((widget.middleFields != null &&
                                  Responsive.isWeb(context)) ||
                              (widget.keepMidleFields == true &&
                                  widget.middleFields != null))
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                DetailItem(
                                  hasSubtitle: false,
                                  data: widget.middleFields,
                                  backColor: widget.backColor,
                                  textColor: widget.textColor,
                                ),
                                if (widget.submiddleFields != null)
                                  TextWidgets.text300(
                                    title: widget.submiddleFields!.value,
                                    fontSize: 12,
                                    textColor:
                                        widget.submiddleFields!.textColor ??
                                        Colors.black,
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.hasUpdate == true || widget.hasDelete == true)
                    const SizedBox(width: 8),
                  if (widget.hasUpdate == true || widget.hasDelete == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.hasUpdate == true)
                            GestureDetector(
                              onTap: () {
                                if (widget.data == null ||
                                    widget.updateCallback == null) {
                                  return;
                                }
                                widget.updateCallback!(widget.data!);
                              },
                              child: Icon(
                                widget.updateIcon!,
                                color: widget.textColor,
                              ),
                            ),
                          if (widget.hasDelete == true)
                            const SizedBox(width: 10),
                          if (widget.hasDelete == true)
                            GestureDetector(
                              onTap: () {
                                if (widget.data == null ||
                                    widget.deleteCallback == null) {
                                  return;
                                }
                                widget.deleteCallback!(widget.data!);
                              },
                              child: Icon(
                                widget.deleteIcon!,
                                color: AppColors.kRedColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
              if (displayDetails == true &&
                  widget.detailsFields != null &&
                  widget.detailsFields!.isNotEmpty)
                Divider(color: AppColors.kBlackColor, thickness: 1.0),
              Visibility(
                visible: displayDetails,
                child: Wrap(
                  // alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      widget.detailsFields!.length,
                      (index) => DetailItem(
                        hasSubtitle: true,
                        data: widget.detailsFields![index],
                        textColor: widget.textColor!,
                        backColor: widget.backColor!,
                      ),
                    ),
                    widget.middleFields != null &&
                            widget.middleFields != null &&
                            Responsive.isMobile(context) &&
                            widget.keepMidleFields == false
                        ? DetailItem(
                            hasSubtitle: true,
                            data: widget.middleFields,
                            textColor: widget.textColor!,
                            backColor: widget.backColor!,
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final ListItemModel? data;
  final Color? textColor, backColor;
  final bool? hasSubtitle;

  const DetailItem({
    super.key,
    required this.data,
    this.textColor = Colors.black,
    this.backColor = Colors.white,
    this.hasSubtitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: backColor!,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (data != null && data?.icon != null) data!.icon!,
            if (data != null && data?.icon != null) const SizedBox(width: 8),
            if (hasSubtitle == false)
              Flexible(
                child: TextWidgets.textNormal(
                  title: data?.value ?? "",
                  fontSize: 14,
                  textColor: textColor!,
                ),
              ),
            if (hasSubtitle == true)
              Flexible(
                child: TextWidgets.textWithLabel(
                  title: data?.title ?? '',
                  value: data?.value ?? '',
                  fontSize: 14,
                  maxLines: 3,
                  textColor: textColor!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
