import 'package:feast_mobile_email/features/signup_page/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupEmailInput extends StatefulWidget {
  const SignupEmailInput({super.key, this.errorText});

  final String? errorText;

  @override
  State<SignupEmailInput> createState() => _SignupEmailInputState();
}

class _SignupEmailInputState extends State<SignupEmailInput> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("E-mail",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              )),
          if (widget.errorText != null)
            Text(widget.errorText!,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ))
        ]),
        SizedBox(
          height: 5,
        ),
        Focus(
          child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                filled: true,
                fillColor:
                    widget.errorText != null ? Colors.red[100] : Colors.white,
                hintText: "Введите E-mail",
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          widget.errorText != null ? Colors.red : Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.errorText != null
                            ? Colors.red
                            : Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              onFieldSubmitted: (newValue) {
                text = newValue;
                BlocProvider.of<SignupBloc>(context)
                    .add(SignupEventEmailChanged(email: text));
              }),
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              BlocProvider.of<SignupBloc>(context)
                  .add(SignupEventEmailChanged(email: text));
            }
          },
        ),
      ],
    );
  }
}
