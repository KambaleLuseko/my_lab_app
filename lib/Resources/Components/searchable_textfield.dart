import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import 'dialogs.dart';
import 'empty_model.dart';
import 'search_textfield.dart';

// ignore_for_file: must_be_immutable

class SearchableTextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final Color textColor;
  final Color backColor;
  final Color? overlayColor;
  final bool? isEnabled;
  final bool? isObsCured;
  final TextEditingController editCtrller;
  int? maxLines = 1;
  int maxLength = 255;
  Function callback;
  List data;
  final String displayColumn;
  String? indexColumn,
      secondDisplayColumn,
      joinColumnPatern,
      errorText = "Aucune donnée trouvée",
      labelText;
  List<String> complementData;

  SearchableTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.textColor,
    required this.backColor,
    required this.editCtrller,
    this.overlayColor,
    TextInputType? inputType,
    maxLength,
    this.maxLines,
    this.isEnabled,
    this.isObsCured,
    required this.callback,
    required this.data,
    required this.displayColumn,
    this.secondDisplayColumn,
    this.complementData = const [],
    this.joinColumnPatern,
    this.indexColumn,
    this.errorText,
  });

  @override
  State<SearchableTextFormFieldWidget> createState() =>
      _SearchableTextFormFieldWidgetState();
}

class _SearchableTextFormFieldWidgetState
    extends State<SearchableTextFormFieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isEnabled == false) return;
        Dialogs.showChoiceDialog(
          title: 'Rechercher',
          content: SearchDataListWidget(
            backColor: widget.backColor,
            textColor: widget.textColor,
            data: widget.data,
            callback: (value) {
              List complement = [];
              if (widget.complementData.isNotEmpty) {
                (value as Map).forEach((key, val) {
                  if (widget.complementData
                      .map((e) => e.toLowerCase())
                      .contains(key.toString().toLowerCase())) {
                    complement.add(value[key]);
                  }
                });
              }
              widget.editCtrller.text =
                  "${value[widget.displayColumn]} ${widget.secondDisplayColumn != null ? " - ${value[widget.secondDisplayColumn]}" : ''} ${widget.complementData.isNotEmpty ? " - ${complement.join(widget.joinColumnPatern ?? '-')}" : ''}";
              widget.callback(value);
              Navigator.pop(context);
            },
            displayColumn: widget.displayColumn,
            secondDisplayColumn: widget.secondDisplayColumn,
            complementData: widget.complementData,
            joinColumnPatern: widget.joinColumnPatern,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   widget.hintText,
            //   style: TextStyle(color: widget.textColor.withOpacity(0.6)),
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: widget.backColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFieldTapRegion(
                child: TextFormField(
                  maxLines: 1,
                  enabled: false, //widget.isEnabled,
                  style: TextStyle(color: widget.textColor),
                  textAlign: TextAlign.left,
                  controller: widget.editCtrller,
                  decoration: InputDecoration(
                    label: TextWidgets.text300(
                      title: widget.labelText ?? widget.hintText,
                      fontSize: 12,
                      textColor: widget.textColor,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: widget.textColor.withOpacity(0.5),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.textColor, width: 1),
                    ),
                    disabledBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.textColor, width: 3),
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

class SearchDataListWidget extends StatefulWidget {
  final List data;
  final Function callback;
  final String displayColumn;
  final String? secondDisplayColumn, alternativeValue, joinColumnPatern;
  final Color? textColor, backColor;
  final List<String> complementData;
  const SearchDataListWidget({
    super.key,
    required this.data,
    required this.callback,
    required this.displayColumn,
    this.alternativeValue,
    this.secondDisplayColumn,
    this.joinColumnPatern,
    this.complementData = const [],
    this.textColor = Colors.white,
    this.backColor = Colors.black12,
  });

  @override
  State<SearchDataListWidget> createState() => _SearchDataListWidgetState();
}

class _SearchDataListWidgetState extends State<SearchDataListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      searchedData = widget.data;
      setState(() {});
      _searchCtrller.addListener(() {
        if (_searchCtrller.text.isEmpty) {
          searchedData = widget.data;
        } else {
          searchedData =
              widget.data.where((element) {
                if (widget.secondDisplayColumn != null) {
                  return element[widget.displayColumn]
                          .toString()
                          .toLowerCase()
                          .contains(_searchCtrller.text.toLowerCase().trim()) ||
                      element[widget.secondDisplayColumn!]
                          .toString()
                          .toLowerCase()
                          .contains(_searchCtrller.text.toLowerCase().trim());
                } else {
                  return element[widget.displayColumn]
                      .toString()
                      .toLowerCase()
                      .contains(_searchCtrller.text.toLowerCase().trim());
                }
              }).toList();
        }
        setState(() {});
      });
    });
  }

  final ScrollController _scrollCtrller = ScrollController(
    keepScrollOffset: false,
  );
  final TextEditingController _searchCtrller = TextEditingController();
  List searchedData = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchTextFormFieldWidgetWithCallback(
          hintText: 'Recherchez',
          textColor: widget.textColor!,
          backColor: widget.backColor!,
          editCtrller: _searchCtrller,
          maxLines: 1,
          callback: (value) {
            if (_searchCtrller.text.isEmpty) {
              searchedData = widget.data;
            } else {
              searchedData =
                  widget.data.where((element) {
                    return element[widget.displayColumn]
                        .toString()
                        .toLowerCase()
                        .contains(_searchCtrller.text.trim().toLowerCase());
                  }).toList();
            }
            setState(() {});
          },
        ),
        const SizedBox(height: 16),
        widget.data.isNotEmpty
            ? Flexible(
              child: ListView.builder(
                controller: _scrollCtrller,
                shrinkWrap: true,
                itemCount: searchedData.length,
                itemBuilder: (context, int index) {
                  List complement = [];
                  (searchedData[index] as Map).forEach((key, val) {
                    if (widget.complementData
                        .map((e) => e.toLowerCase())
                        .contains(key.toString().toLowerCase())) {
                      complement.add(searchedData[index][key]);
                    }
                  });
                  return Container(
                    margin: const EdgeInsets.only(right: 0, top: 4),
                    child: GestureDetector(
                      onTapUp: ((det) {
                        widget.callback(searchedData[index]);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: widget.backColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                        child: ListTile(
                          dense: false,
                          contentPadding: EdgeInsets.zero,
                          minVerticalPadding: 0,
                          title: TextWidgets.textBold(
                            title: searchedData[index][widget.displayColumn],
                            fontSize: 14,
                            textColor: widget.textColor!,
                          ),
                          subtitle:
                              widget.secondDisplayColumn != null &&
                                      widget.secondDisplayColumn!.isNotEmpty
                                  ? TextWidgets.text300(
                                    title:
                                        (searchedData[index][widget
                                                    .secondDisplayColumn]
                                                ?.toString() ??
                                            '') +
                                        (widget.complementData.isNotEmpty
                                            ? " (${complement.join(widget.joinColumnPatern ?? '- ')})"
                                            : ''),
                                    fontSize: 14,
                                    textColor: widget.textColor!,
                                  )
                                  : widget.complementData.isNotEmpty
                                  ? TextWidgets.text300(
                                    title: complement.join(
                                      widget.joinColumnPatern ?? '- ',
                                    ),
                                    fontSize: 14,
                                    textColor: widget.textColor!,
                                  )
                                  : null,
                        ),
                        //  TextWidgets.text300(
                        //     maxLines: 3,
                        //     title:
                        //         "${searchedData[index][widget.displayColumn]}\n${widget.secondDisplayColumn != null ? "${searchedData[index][widget.secondDisplayColumn]}" : ''}",
                        //     fontSize: 14,
                        //     textColor: widget.textColor!),
                      ),
                    ),
                  );
                },
              ),
            )
            : EmptyModel(
              color: widget.textColor!,
              text: 'Aucune donnee trouvee',
            ),
      ],
    );
  }
}
