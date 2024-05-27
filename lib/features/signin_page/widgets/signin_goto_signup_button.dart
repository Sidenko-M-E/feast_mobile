import 'package:feast_mobile_email/constraints.dart';
import 'package:feast_mobile_email/features/signin_page/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninGoToSignupButton extends StatelessWidget {
  const SigninGoToSignupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<SigninBloc>(context).add(SigninEventGoToSignup());
        },
        child: RichText(
          text: const TextSpan(children: <InlineSpan>[
            TextSpan(
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              text: 'Нет аккаунта?',
            ),
            WidgetSpan(child: SizedBox(width: 10)),
            TextSpan(
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: mainBlue),
              text: 'Зарегистрироваться',
            ),
          ]),
        ));
  }
}
