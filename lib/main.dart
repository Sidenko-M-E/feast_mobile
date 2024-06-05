import 'package:feast_mobile_email/events_view_model.dart';
import 'package:feast_mobile_email/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

TextTheme textTheme = TextTheme(
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ));
