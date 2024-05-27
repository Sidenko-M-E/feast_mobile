import 'package:feast_mobile_email/constraints.dart';
import 'package:feast_mobile_email/features/signup_page/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupGoToSigninButton extends StatelessWidget {
  const SignupGoToSigninButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<SignupBloc>(context).add(SignupEventGoToSignin());
        },
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: mainBlue,
            ),
            text: 'У меня уже есть аккаунт',
          ),
        ));
  }
}
