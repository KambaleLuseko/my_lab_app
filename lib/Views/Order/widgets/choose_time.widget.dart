import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/text_fields.dart';
import 'package:my_lab_app/Resources/Components/texts.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

class ChooseAccessTimeWidget extends StatefulWidget {
  ChooseAccessTimeWidget({super.key, this.startTime = '', this.endTime = ''});
  String startTime, endTime;
  @override
  State<ChooseAccessTimeWidget> createState() => _ChooseAccessTimeWidgetState();
}

class _ChooseAccessTimeWidgetState extends State<ChooseAccessTimeWidget> {
  @override
  void initState() {
    super.initState();
    _openedAtController.text = widget.startTime;
    _closedAtController.text = widget.endTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidgets.textBold(
            title: "Crenau de travail",
            fontSize: 18,
            textColor: AppColors.kBlackColor,
          ),

          const SizedBox(height: 24),
          TextWidgets.textNormal(
            maxLines: 3,
            title:
                "Choisissez l'heure à laquelle vous souhaitez commencer à travailler",
            fontSize: 14,
            textColor: AppColors.kBlackColor,
          ),
          GestureDetector(
            onTap: () => _pickTime(context, true),
            child: AbsorbPointer(
              child: TextFormFieldWidget(
                editCtrller: _openedAtController,
                labelText: 'Debut',
                hintText: "eg: 10:00",
                isEnabled: false,
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextWidgets.textNormal(
            maxLines: 3,
            title:
                "Choisissez l'heure à laquelle vous souhaitez finir à travailler",
            fontSize: 14,
            textColor: AppColors.kBlackColor,
          ),
          GestureDetector(
            onTap: () => _pickTime(context, false),
            child: AbsorbPointer(
              child: TextFormFieldWidget(
                editCtrller: _closedAtController,
                labelText: 'Fin',
                hintText: "eg: 16:00",
                isEnabled: false,
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final _openedAtController = TextEditingController();
  final _closedAtController = TextEditingController();

  // Pickers will handle time selection
  TimeOfDay? _selectedOpenedTime;
  TimeOfDay? _selectedClosedTime;

  Future<void> _pickTime(BuildContext context, bool isOpenedAt) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      context: context,
      initialTime: isOpenedAt
          ? _selectedOpenedTime ?? TimeOfDay.now()
          : _selectedClosedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final MaterialLocalizations localizations = MaterialLocalizations.of(
        context,
      );

      // Explicitly format the picked time into a 24-hour string
      final String formattedTime = localizations.formatTimeOfDay(
        pickedTime,
        alwaysUse24HourFormat: true,
      );

      if (isOpenedAt) {
        setState(() {
          _selectedOpenedTime = pickedTime;
          _openedAtController.text = formattedTime;
          widget.startTime = formattedTime;
        });
      } else {
        setState(() {
          _selectedClosedTime = pickedTime;
          _closedAtController.text = formattedTime;
          widget.endTime = formattedTime;
        });
      }
    }
  }
}
