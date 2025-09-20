import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Components/applogo.dart';
import 'package:my_lab_app/Resources/Components/button.dart';
import 'package:my_lab_app/Resources/Components/text_fields.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';
import 'package:my_lab_app/Resources/Constants/navigators.dart';
import 'package:my_lab_app/Resources/Providers/users_provider.dart';
import 'package:my_lab_app/Views/Auth/register.page.dart';
import 'package:my_lab_app/Views/main.page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
          child: Padding(
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
              'Welcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Sign in to continue',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
            _buildEmailField(),
            SizedBox(height: 16),
            _buildPasswordField(),
            SizedBox(height: 16),
            _buildForgotPassword(),
            SizedBox(height: 24),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormFieldWidget(
      hintText: 'E-mail',
      textColor: AppColors.kBlackColor,
      backColor: AppColors.kTextFormBackColor,
      editCtrller: _emailController,
      inputType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return TextFormFieldWidget(
      hintText: 'Password',
      textColor: AppColors.kBlackColor,
      backColor: AppColors.kTextFormBackColor,
      editCtrller: _passwordController,
      isObsCured: true,
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        callback: () {
          context.read<UserProvider>().login(
            data: {
              "email": _emailController.text.trim(),
              "password": _passwordController.text.trim(),
            },
            callback: () {
              Navigation.pushReplaceNavigate(page: MainPage());
            },
          );
        },
        backColor: AppColors.kPrimaryColor,
        text: 'Login',
        textColor: AppColors.kWhiteColor,
        canSync: true,
      ),
    );
  }

  Widget _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            Navigation.pushNavigate(page: RegisterPage());
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
