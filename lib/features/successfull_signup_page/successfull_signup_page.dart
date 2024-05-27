import 'package:feast_mobile_email/constraints.dart';
import 'package:feast_mobile_email/models/user.dart';
import 'package:flutter/material.dart';

class SuccessfullSignUpPage extends StatelessWidget {
  const SuccessfullSignUpPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: authBackground,
      appBar: AppBar(
        backgroundColor: authBackground,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // TODO Навигация на страницу со списком событий
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Image.asset('assets/png/house_color.png'),
            SizedBox(height: 30),
            Text(
              'Вы успешно зарегистрированы',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  //TODO Навигация на страницу со списком событий
                },
                child: const Text('Продолжить'))
          ],
        ),
      ),
    );
  }
}
