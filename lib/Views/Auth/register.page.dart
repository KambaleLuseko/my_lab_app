import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/applogo.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/dropdown_button.dart';
import 'package:my_lab_app/Resources/Components/text_fields.dart';
import 'package:my_lab_app/Resources/Constants/app_providers.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Constants/responsive.dart';
import 'package:my_lab_app/Resources/Models/user.model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullnameCtrller = TextEditingController(),
      _phoneCtrller = TextEditingController(),
          // _usernameCtrller = TextEditingController(),
          _passwordCtrller =
          TextEditingController(),
      _emailCtrller = TextEditingController(),
      _promotionCtrller = TextEditingController(),
      _anneeAcademiqueCtrller = TextEditingController(),
      _addressCtrller = TextEditingController();
  String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.kPrimaryColor, AppColors.kAccentColor],
          ),
        ),
        child: Center(
          child: Container(
            width: Responsive.isMobile(context) ? double.maxFinite : 600,
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  SizedBox(height: 40),
                  _buildLoginCard(),
                  SizedBox(height: 20),
                  _buildSignUpText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: AppLogo(size: Size(80, 80)),
    );
  }

  Widget _buildLoginCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Register',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Create your account for free',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
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
              items: ['Etudiant', 'Visiteur', 'Groupe'],
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
              hintText: category?.toLowerCase() == 'etudiant'
                  ? 'Annee academique'
                  : 'Nombre des personnes',
              editCtrller: _anneeAcademiqueCtrller,
              textColor: AppColors.kBlackColor,
              maxLines: 1,
            ),
            TextFormFieldWidget(
              backColor: AppColors.kTextFormBackColor,
              hintText: 'Mot de passe *',
              editCtrller: _passwordCtrller,
              inputType: TextInputType.text,
              textColor: AppColors.kBlackColor,
              isObsCured: true,
              maxLines: 1,
            ),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        callback: () {
          UserModel data = UserModel.fromJson({
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
            data: data,
            callback: () {
              Navigator.pop(context);
            },
          );
        },
        backColor: AppColors.kPrimaryColor,
        text: 'Register',
        textColor: AppColors.kWhiteColor,
        canSync: true,
      ),
    );
  }

  Widget _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Have an account? ", style: TextStyle(color: Colors.white70)),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Sign in',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
