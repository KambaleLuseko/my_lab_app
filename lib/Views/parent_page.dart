import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/dialogs.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class ParentPage extends StatefulWidget {
  final String title;
  final Widget listWidget;
  final Widget? newItem;
  final Function? callback;
  final bool? hasTopTitle;
  const ParentPage({
    super.key,
    required this.title,
    required this.listWidget,
    this.hasTopTitle = true,
    this.newItem,
    this.callback,
  });

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  bool addingNewItem = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: widget.newItem == null
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'new-item-action',
                  label: TextWidgets.text300(
                    title: context.watch<AppStateProvider>().isAsync == true
                        ? ''
                        : 'Ajouter',
                    fontSize: 16,
                    textColor: AppColors.kWhiteColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: AppColors.kPrimaryColor,
                  onPressed: () {
                    if (context.read<AppStateProvider>().isAsync == true) {
                      return;
                    }
                    if (widget.newItem != null) {
                      Dialogs.showModal(
                        hasScroll: true,
                        child: widget.newItem!,
                        title: widget.title,
                      );
                    }
                  },
                  icon: Icon(
                    context.watch<AppStateProvider>().isAsync == true
                        ? Icons.sync
                        : addingNewItem == false
                        ? Icons.add
                        : Icons.close,
                    color: AppColors.kWhiteColor,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.hasTopTitle == true)
              Container(
                decoration: BoxDecoration(color: AppColors.kWhiteColor),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(),
                          TextWidgets.textBold(
                            title: 'Nos ${widget.title.toLowerCase()}',
                            fontSize: 18,
                            textColor: AppColors.kBlackColor,
                          ),
                          TextWidgets.text300(
                            title: 'Liste de nos ${widget.title.toLowerCase()}',
                            fontSize: 14,
                            textColor: AppColors.kBlackColor,
                          ),
                        ],
                      ),
                    ),
                    IconButtonWidget(
                      backColor: AppColors.kTransparentColor,
                      textColor: AppColors.kBlackColor,
                      callback: () {
                        if (widget.callback != null) {
                          widget.callback!();
                        }
                      },
                      icon: Icons.autorenew,
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 8),
                child: widget.listWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
