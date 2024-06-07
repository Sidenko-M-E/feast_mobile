import 'package:feast_mobile_email/constraints.dart';
import 'package:flutter/material.dart';
// import 'package:feast_mobile_email/view_models/auth_view_model.dart';
// import 'package:provider/provider.dart';

class SuccessfullAuthPage extends StatelessWidget {
  const SuccessfullAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authVM = context.watch<AuthVM>();
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
              'Вы успешно вошли в систему',
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
