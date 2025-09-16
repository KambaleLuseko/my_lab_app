import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/text_fields.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:my_lab_app/Views/Rooms/model/room.model.dart';
import 'package:provider/provider.dart';

class AddNewRoomPage extends StatefulWidget {
  const AddNewRoomPage({super.key});

  @override
  State<AddNewRoomPage> createState() => _AddNewRoomPageState();
}

class _AddNewRoomPageState extends State<AddNewRoomPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  final _openedAtController = TextEditingController();
  final _closedAtController = TextEditingController();

  // Pickers will handle time selection
  TimeOfDay? _selectedOpenedTime;
  TimeOfDay? _selectedClosedTime;

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    _openedAtController.dispose();
    _closedAtController.dispose();
    super.dispose();
  }

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
        });
      } else {
        setState(() {
          _selectedClosedTime = pickedTime;
          _closedAtController.text = formattedTime;
        });
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // All validations passed. Proceed with submission.

      final roomData = {
        'name': _nameController.text,
        'capacity': int.tryParse(_capacityController.text),
        'opened_at': _openedAtController.text.isNotEmpty
            ? _openedAtController.text
            : null,
        'closed_at': _closedAtController.text.isNotEmpty
            ? _closedAtController.text
            : null,
      };
      context.read<RoomProvider>().save(
        data: RoomModel.fromJson(roomData),
        callback: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormFieldWidget(
                editCtrller: _nameController,
                labelText: 'Room Name',
                hintText: "Enter room name",
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                editCtrller: _capacityController,
                labelText: 'Capacity',
                hintText: "eg. 50",
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a capacity';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 1) {
                    return 'Please enter a valid number greater than 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _pickTime(context, true),
                child: AbsorbPointer(
                  child: TextFormFieldWidget(
                    editCtrller: _openedAtController,
                    labelText: 'Opening Time',
                    hintText: "eg: 10:00",
                    backColor: AppColors.kTextFormBackColor,
                    textColor: AppColors.kBlackColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _pickTime(context, false),
                child: AbsorbPointer(
                  child: TextFormFieldWidget(
                    editCtrller: _closedAtController,
                    labelText: 'Closing Time',
                    hintText: "eg: 16:00",
                    backColor: AppColors.kTextFormBackColor,
                    textColor: AppColors.kBlackColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                callback: _submitForm,
                text: "Enregistrer",
                backColor: AppColors.kPrimaryColor,
                textColor: AppColors.kWhiteColor,
                canSync: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
