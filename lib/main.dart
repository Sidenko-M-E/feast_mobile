import 'package:feast_mobile_email/view_models/auth_view_model.dart';
import 'package:feast_mobile_email/view_models/events_view_model.dart';
import 'package:feast_mobile_email/routes/routes.dart';
import 'package:feast_mobile_email/view_models/otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'text_theme.dart';

void main() {
  runApp(FeastMobileApp());
}

class FeastMobileApp extends StatelessWidget {
  const FeastMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventViewModel()),
        ChangeNotifierProvider(create: (_) => AuthVM()),
        ChangeNotifierProvider(create: (_) => OtpVM()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('ru'),
        ],
        theme:
            ThemeData(platform: TargetPlatform.android, textTheme: textTheme),
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
      ),
    );
  }
}
