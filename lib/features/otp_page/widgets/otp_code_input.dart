import 'package:feast_mobile_email/constraints.dart';
import 'package:feast_mobile_email/features/otp_page/bloc/otp_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCodeInput extends StatelessWidget {
  const OtpCodeInput({
    super.key, 

    this.errorText
  });

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Код",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              )),
          if (errorText != null)
            Text(errorText!,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 12))
        ]),
        const SizedBox(
          height: 5,
        ),
        PinCodeTextField(
          length: 4,
          onCompleted: (value) {
            BlocProvider.of<OtpBloc>(context).add(OtpCodeComplete(newValue: value));
          },
          onChanged: (value) {
            BlocProvider.of<OtpBloc>(context).add(OtpCodeChanged(newValue: value));
          },
          appContext: context,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          animationType: AnimationType.none,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          errorTextSpace: 0,
          enableActiveFill: true,
          showCursor: false,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(15),
            fieldWidth: 80,
            borderWidth: 0.5,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            activeColor: Colors.grey[200],
            selectedColor: mainBlue,
            inactiveColor: Colors.grey[200],
          ),
        )
      ],
    );
  }
}
