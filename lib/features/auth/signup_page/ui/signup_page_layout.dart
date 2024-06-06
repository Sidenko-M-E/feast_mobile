
import 'package:feast_mobile_email/features/auth/signup_page/bloc/signup_bloc.dart';
import 'package:feast_mobile_email/features/signup_page/widgets/signup_email_input.dart';
import 'package:feast_mobile_email/features/auth/signup_page/widgets/signup_goto_signin_button.dart';
import 'package:feast_mobile_email/features/signup_page/widgets/signup_password_input.dart';
import 'package:feast_mobile_email/features/signup_page/widgets/signup_submit_button.dart';
import 'package:feast_mobile_email/features/auth/widgets/auth_name_input.dart';
import 'package:flutter/material.dart';

const Color authBackground = Color.fromARGB(254, 238, 248, 255);

class SignupPageLayout extends StatefulWidget {
  final SignupStateToRebuild widgetState;
  const SignupPageLayout({super.key, required this.widgetState});

  @override
  State<SignupPageLayout> createState() => _SignupPageLayoutState();
}

class _SignupPageLayoutState extends State<SignupPageLayout> {
  @override
  Widget build(BuildContext context) {
    final state = widget.widgetState;
    return Scaffold(
      backgroundColor: authBackground,
      appBar: AppBar(
        backgroundColor: authBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          children: <Widget>[
            Image.asset('assets/png/house_gray.png'),
            SizedBox(height: 30),
            Text(
              'Регистрация',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            SignupNameInput(
              errorText: state.nameError,
            ),
            SizedBox(height: 30),
            SignupEmailInput(
              errorText: state.emailError,
            ),
            SizedBox(height: 30),
            SignupPasswordInput(
              isTextObscured: state.isPasswordObscured,
              errorText: state.passwordError,
            ),
            SignupSubmitButton(isEnabled: state.isSignUpEnabled),
            SizedBox(height: 10),
            SignupGoToSigninButton()
          ],
        ),
      ),
    );
  }
}
