import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

import '../../Resources/Components/texts.dart';
import 'decorated_container.dart';

filterButton({
  required String title,
  required bool isActive,
  Color? backColor,
  Color? textColor = Colors.white,
  FlexFit? flexFit = FlexFit.tight,
  required var callback,
}) {
  backColor ??= AppColors.kScaffoldColor;
  return Flexible(
    fit: flexFit!,
    child: GestureDetector(
      onTap: callback,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        color: isActive ? AppColors.kPrimaryColor : backColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TextWidgets.textNormal(
            title: title,
            fontSize: 14,
            textColor: isActive ? textColor! : textColor!.withOpacity(0.5),
          ),
        ),
      ),
    ),
  );
}

class TabFilterWidget extends StatefulWidget {
  Function callback;
  final List<String> titles;
  Color backColor, textColor;
  FlexFit? flexFit;
  TabFilterWidget({
    super.key,
    required this.callback,
    required this.titles,
    this.flexFit = FlexFit.tight,
    this.backColor = Colors.black,
    this.textColor = Colors.white,
  });

  @override
  State<TabFilterWidget> createState() => _TabFilterWidgetState();
}

class _TabFilterWidgetState extends State<TabFilterWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentFilter = widget.titles[0];
      setState(() {});
      widget.callback(currentFilter);
    });
  }

  String currentFilter = "";
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: widget.backColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.titles.length, (index) {
            return filterButton(
              flexFit: widget.flexFit ?? FlexFit.loose,
              backColor: widget.backColor,
              title: widget.titles[index],
              isActive: currentFilter == widget.titles[index],
              callback: () {
                setState(() {
                  currentFilter = widget.titles[index];
                  widget.callback(currentFilter);
                  setState(() {});
                });
              },
            );
          }),
        ),
      ),
    );
  }
}

groupFiltersWidget({
  required String title,
  required List<String> data,
  String? active = 'tous',
  Function(String)? callback,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 8),
      const Divider(thickness: 1),
      const Row(),
      TextWidgets.textBold(
        title: title,
        fontSize: 16,
        textColor: AppColors.kBlackColor,
      ),
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: AppColors.kWhiteColor),
        child: Wrap(
          runSpacing: 8,
          children: [
            ...List.generate(
              data.length,
              (index) => ChipFilterWidget(
                active: active?.toLowerCase() == data[index].toLowerCase(),
                title: data[index],
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
                callback: (value) {
                  if (callback != null) callback(value);
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
