import 'package:cashpoint/src/helper/map_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cashpoint/src/UI/Intro/splash.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalizationDelegate.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await localization.init();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {


  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapHelper()),
      ],
      child: MaterialApp(
          locale: Locale(localization.currentLanguage),
          supportedLocales: localization.supportedLocales(),
          localizationsDelegates: [
            AppLocalizationDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        debugShowCheckedModeBanner: false,
        title: 'كاش بوينت',
        key: key ,

        home: SplashScreen(),

      ),
    )
    ;


  }}
