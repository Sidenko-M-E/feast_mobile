import 'package:feast_mobile_email/features/signin_page/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninSubmitButton extends StatelessWidget {
  const SigninSubmitButton({super.key, required this.isEnabled});

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          foregroundColor: isEnabled ? Colors.white : Colors.grey[700],
          backgroundColor: isEnabled ? Colors.blue : Colors.grey[400],
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          if (isEnabled)
            BlocProvider.of<SigninBloc>(context).add(SigninEventSubmitButtonClicked());
        },
        child: const Text('Войти'));
  }
}
