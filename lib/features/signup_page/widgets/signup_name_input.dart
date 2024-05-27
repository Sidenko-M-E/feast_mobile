import 'package:feast_mobile_email/features/signup_page/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupNameInput extends StatefulWidget {
  const SignupNameInput({super.key, this.errorText});

  final String? errorText;

  @override
  State<SignupNameInput> createState() => _SignupNameInputState();
}

class _SignupNameInputState extends State<SignupNameInput> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Как к вам обращаться?",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12)),
          if (widget.errorText != null)
            Text(widget.errorText!,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 12))
        ]),
        SizedBox(
          height: 5,
        ),
        Focus(
          child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              maxLength: 256,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                filled: true,
                fillColor:
                    widget.errorText != null ? Colors.red[100] : Colors.white,
                hintText: "Введите ваше имя",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                counterStyle: TextStyle(fontSize: 0),
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
                    .add(SignupEventNameChanged(name: text));
              }),
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              BlocProvider.of<SignupBloc>(context).add(SignupEventNameChanged(name: text));
            }
          },
        ),
      ],
    );
  }
}
