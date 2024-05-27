import 'package:feast_mobile_email/features/signin_page/ui/signin_page_state_manager.dart';
import 'package:feast_mobile_email/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(FeastMobileApp());
}

class FeastMobileApp extends StatelessWidget {
  const FeastMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HttpService(),
      child: MaterialApp(
        theme: ThemeData(platform: TargetPlatform.android),
        debugShowCheckedModeBanner: false,
        home: SigninPage(),
      ),
    );
  }
}
