import 'package:feast_mobile_email/constraints.dart';
import 'package:feast_mobile_email/features/auth/otp_page/bloc/otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpRequestCodeButton extends StatelessWidget {
  const OtpRequestCodeButton({
    super.key,
    required this.secondsLeft,
  });

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (secondsLeft == 0)
            BlocProvider.of<OtpBloc>(context).add(OtpRequestNewCode());
        },
        child: secondsLeft == 0
            ? RichText(
                text: const TextSpan(
                style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w500, 
                    color: mainBlue
                  ),
                text: 'Отправить код ещё раз',
              ))
            : RichText(
                text: TextSpan(
                style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w700, 
                    color: Colors.grey
                  ),
                text: 'Отправить код ещё раз (${secondsLeft.toString()})',
              )));
  }
}
