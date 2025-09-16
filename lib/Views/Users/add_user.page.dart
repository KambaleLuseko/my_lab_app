import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../Resources/Components/button.dart';
import '../../Resources/Components/dropdown_button.dart';
import '../../Resources/Components/text_fields.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/app_providers.dart';
import '../../Resources/Constants/enums.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Models/user.model.dart';
import '../../Resources/Providers/users_provider.dart';

class AddUserPage extends StatefulWidget {
  final UserModel? data;
  final EnumActions? action;
  const AddUserPage({super.key, this.data, this.action = EnumActions.save});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _fullnameCtrller = TextEditingController(),
      _phoneCtrller = TextEditingController(),
          // _usernameCtrller = TextEditingController(),
          _passwordCtrller =
          TextEditingController(),
      _emailCtrller = TextEditingController(),
      _promotionCtrller = TextEditingController(),
      _anneeAcademiqueCtrller = TextEditingController(),
      _addressCtrller = TextEditingController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.action == EnumActions.update) {
        _fullnameCtrller.text = widget.data!.name!.trim();
        _phoneCtrller.text = widget.data!.phone?.trim() ?? '';
        // _usernameCtrller.text = widget.data!.username.toString().trim();
        // _passwordCtrller.text = widget.data!.password.toString().trim();
        _emailCtrller.text = widget.data!.email.toString().trim();
        _promotionCtrller.text = widget.data!.promotion.toString().trim();
        _anneeAcademiqueCtrller.text = widget.data!.anneeAcademique
            .toString()
            .trim();
        _addressCtrller.text = widget.data!.address?.toString().trim() ?? '';
        category = widget.data!.role.toString().trim().split('/').firstOrNull;
      }
      if (UserProvider.role == UserRolesEnum.root) {
        userTypes = ([
          'Founder',
          // "Supervisor",
        ]);
      }
      // if (context.read<UserProvider>().userLogged?.user.niveau?.toLowerCase() ==
      //     'admin') {
      //   userTypes = (["Asset"]);
      // }
      // if (context.read<UserProvider>().userLogged?.user.niveau?.toLowerCase() ==
      //     'founder') {
      //   userTypes = (["Admin", "Asset"]);
      // }
      userTypes = ['Admin', 'Agent', 'Etudiant', 'Root'];
      setState(() {});
    });
  }

  List<String> userTypes = [];

  String? category;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              TextWidgets.textBold(
                title:
                    "${widget.action == EnumActions.save
                        ? 'Enregistrer'
                        : widget.action == EnumActions.update
                        ? "Modifier"
                        : "Supprimer"} un utilisateur",
                fontSize: 18,
                textColor: AppColors.kBlackColor,
              ),
              TextWidgets.text300(
                title: "Tous les champs marqués (*) sont obligatoires",
                fontSize: 12,
                textColor: AppColors.kRedColor,
              ),
              CustomDropdownButton(
                displayLabel: false,
                backColor: AppColors.kTextFormBackColor,
                value: category?.toString(),
                textColor: AppColors.kBlackColor,
                dropdownColor: AppColors.kScaffoldColor,
                hintText: "Categorie",
                callBack: (value) {
                  category = value;
                  setState(() {});
                },
                items: userTypes,
              ),
              // if (context
              //             .read<UserProvider>()
              //             .userLogged!
              //             .user
              //             .niveau
              //             ?.toLowerCase() ==
              //         'root' &&
              //     (category?.toLowerCase() == 'admin' ||
              //         category?.toLowerCase() == 'founder'))
              TextFormFieldWidget(
                backColor: AppColors.kTextFormBackColor,
                hintText: 'Nom *',
                editCtrller: _fullnameCtrller,
                textColor: AppColors.kBlackColor,
                maxLines: 1,
              ),
              TextFormFieldWidget(
                backColor: AppColors.kTextFormBackColor,
                hintText: 'Contact *',
                editCtrller: _phoneCtrller,
                inputType: TextInputType.phone,
                textColor: AppColors.kBlackColor,
                maxLines: 1,
              ),
              TextFormFieldWidget(
                backColor: AppColors.kTextFormBackColor,
                hintText: 'Adresse',
                editCtrller: _addressCtrller,
                inputType: TextInputType.text,
                textColor: AppColors.kBlackColor,
                maxLines: 1,
              ),
              TextFormFieldWidget(
                backColor: AppColors.kTextFormBackColor,
                hintText: 'E-mail',
                editCtrller: _emailCtrller,
                inputType: TextInputType.emailAddress,
                textColor: AppColors.kBlackColor,
                maxLines: 1,
              ),
              TextFormFieldWidget(
                backColor: AppColors.kTextFormBackColor,
                hintText: 'Promotion',
                editCtrller: _promotionCtrller,
                textColor: AppColors.kBlackColor,
                maxLines: 1,
              ),
              TextFormFieldWidget(
                backColor: AppColors.kTextFormBackColor,
                hintText: 'Annee academique',
                editCtrller: _anneeAcademiqueCtrller,
                textColor: AppColors.kBlackColor,
                maxLines: 1,
              ),
              // TextFormFieldWidget(
              //     backColor: AppColors.kTextFormBackColor,
              //     hintText: 'Username *',
              //     editCtrller: _usernameCtrller,
              //     inputType: TextInputType.text,
              //     textColor: AppColors.kBlackColor,
              //     maxLines: 1),
              if (widget.action != EnumActions.update)
                TextFormFieldWidget(
                  backColor: AppColors.kTextFormBackColor,
                  hintText: 'Mot de passe *',
                  editCtrller: _passwordCtrller,
                  inputType: TextInputType.text,
                  textColor: AppColors.kBlackColor,
                  isObsCured: true,
                  maxLines: 1,
                ),
              CustomButton(
                backColor: AppColors.kSecondaryColor,
                text: widget.action == EnumActions.save
                    ? 'Enregistrer'
                    : widget.action == EnumActions.update
                    ? "Modifier"
                    : "Supprimer",
                textColor: AppColors.kBlackColor,
                canSync: true,
                callback: () {
                  if ((category?.toLowerCase() != 'root' &&
                      category?.toLowerCase() == 'supervisor')) {}
                  UserModel data = UserModel.fromJson({
                    if (widget.action == EnumActions.update)
                      "id": widget.data?.id?.toString(),
                    "uuid": widget.data?.uuid?.toString(),
                    "name": _fullnameCtrller.text.trim(),
                    "phone": _phoneCtrller.text.trim(),
                    "email": _emailCtrller.text.trim(),
                    "address": _addressCtrller.text.trim(),
                    "promotion": _promotionCtrller.text.trim(),
                    "password": _passwordCtrller.text.trim(),
                    "annee_academique": _anneeAcademiqueCtrller.text.trim(),
                    'statut': "Active",
                    "role": category,
                  });
                  AppProviders.usersProvider.save(
                    action: widget.action,
                    data: data,
                    callback: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
