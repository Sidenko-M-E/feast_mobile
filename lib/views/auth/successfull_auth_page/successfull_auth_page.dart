import 'package:flutter/material.dart';

class SuccessfullAuthPage extends StatelessWidget {
  const SuccessfullAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authVM = context.watch<AuthVM>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: null,
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
            ],
          ),
        ),
      ),
    );
  }
}
