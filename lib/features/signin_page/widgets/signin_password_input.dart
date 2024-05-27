import 'package:feast_mobile_email/features/signin_page/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPasswordInput extends StatefulWidget {
  const SigninPasswordInput(
      {super.key, this.errorText, required this.isTextObscured});

  final String? errorText;
  final bool isTextObscured;

  @override
  State<SigninPasswordInput> createState() => _SigninPasswordInputState();
}

class _SigninPasswordInputState extends State<SigninPasswordInput> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Пароль",
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
            maxLength: 32,
            obscureText: widget.isTextObscured,
            decoration: InputDecoration(
              counterStyle: TextStyle(fontSize: 0),
              contentPadding: EdgeInsets.all(12),
              filled: true,
              fillColor:
                  widget.errorText != null ? Colors.red[100] : Colors.white,
              hintText: "Введите пароль",
              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              suffixIcon: IconButton(
                icon: widget.isTextObscured
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: () => BlocProvider.of<SigninBloc>(context)
                    .add(SigninEventPasswordVisibilityChanged()),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        widget.errorText != null ? Colors.red : Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          widget.errorText != null ? Colors.red : Colors.blue),
                  borderRadius: BorderRadius.circular(20)),
            ),
            onChanged: (newValue) {
              text = newValue;
              BlocProvider.of<SigninBloc>(context)
                  .add(SigninEventPasswordChanged(password: text));
            },
            onFieldSubmitted: (newValue) {
              text = newValue;
              BlocProvider.of<SigninBloc>(context)
                  .add(SigninEventPasswordChanged(password: text));
            },
          ),
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              BlocProvider.of<SigninBloc>(context)
                  .add(SigninEventPasswordChanged(password: text));
            }
          },
        ),
      ],
    );
  }
}
