import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/text_fields.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Views/RoomManager/add_manager.page.dart';
import 'package:my_lab_app/Views/Rooms/controller/room.provider.dart';
import 'package:provider/provider.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _roomController = TextEditingController();

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
                labelText: 'Designation',
                hintText: "Designation",
                backColor: AppColors.kTextFormBackColor,
                textColor: AppColors.kBlackColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                editCtrller: _descriptionController,
                labelText: 'Description',
                hintText: "Description",
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
              // ItemSelectorWidget(title: "Laboratoire", data: context.read<RoomProvider>().offlineData, callback: callback)
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
