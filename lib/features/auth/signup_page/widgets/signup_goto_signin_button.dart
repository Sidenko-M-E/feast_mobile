import 'package:feast_mobile_email/constraints.dart';
import 'package:flutter/material.dart';

class SignupGoToSigninButton extends StatelessWidget {
  const SignupGoToSigninButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
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
