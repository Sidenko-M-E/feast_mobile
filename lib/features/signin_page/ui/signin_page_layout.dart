import 'package:feast_mobile_email/features/signin_page/bloc/signin_bloc.dart';
import 'package:feast_mobile_email/features/signin_page/widgets/signin_email_input.dart';
import 'package:feast_mobile_email/features/signin_page/widgets/signin_goto_signup_button.dart';
import 'package:feast_mobile_email/features/signin_page/widgets/signin_password_input.dart';
import 'package:feast_mobile_email/features/signin_page/widgets/signin_sumbit_button.dart';
import 'package:flutter/material.dart';

const Color authBackground = Color.fromARGB(254, 238, 248, 255);

class SigninPageLayout extends StatefulWidget {
  final SigninStateToRebuild state;
  const SigninPageLayout({super.key, required this.state});

  @override
  State<SigninPageLayout> createState() => _SigninPageLayoutState();
}

class _SigninPageLayoutState extends State<SigninPageLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: authBackground,
      appBar: AppBar(
        backgroundColor: authBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: <Widget>[
                Image.asset('assets/png/house_gray.png'),
                SizedBox(height: 30),
                Text(
                  'Авторизация',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                SigninEmailInput(
                  errorText: widget.state.emailError,
                ),
                SizedBox(height: 30),
                SigninPasswordInput(
                  isTextObscured: widget.state.isPasswordObscured,
                  errorText: widget.state.passwordError,
                ),
                Expanded(child: Container()),
                SigninSubmitButton(isEnabled: widget.state.isSigninEnabled),
                SizedBox(height: 10),
                SigninGoToSignupButton()
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
