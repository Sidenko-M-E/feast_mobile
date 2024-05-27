import 'package:feast_mobile_email/features/otp_page/bloc/otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpSignUpButton extends StatelessWidget {
  const OtpSignUpButton({super.key, required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          foregroundColor: enabled ? Colors.white : Colors.grey[700],
          backgroundColor: enabled ? Colors.blue : Colors.grey[400],
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          if (enabled)
            BlocProvider.of<OtpBloc>(context).add(OtpSignUpButtonClicked());
        },
        child: const Text('Отправить'));
  }
}
