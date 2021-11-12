import 'package:async_redux/async_redux.dart';
import 'package:classfrase/theme/theme_app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app_state.dart';
import 'routes.dart';
import 'package:themed/themed.dart';

late Store<AppState> store;
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  store = Store<AppState>(initialState: AppState.initialState());
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Themed(
        defaultTheme: orange,
        currentTheme: orange,
        child: MaterialApp(
          title: 'ClassFrase',
          debugShowCheckedModeBanner: false,
          theme: ThemeDataApp().changed,
          scrollBehavior: MyCustomScrollBehavior(),
          navigatorKey: navigatorKey,
          routes: Routes.routes,
          initialRoute: '/',
        ),
      ),
    );
  }
}


/*
theme: ThemeData(
            // colorScheme: ColorScheme.fromSwatch(
            //         // primarySwatch: Colors.blue,
            //         )
            //     .copyWith(
            //   primary: ThemeApp.primary,
            //   onPrimary: ThemeApp.onPrimary,
            //   secondary: ThemeApp.secondary,
            //   onSecondary: ThemeApp.onSecondary,
            //   onBackground: ThemeApp.onBackground,
            //   onSurface: ThemeApp.onSurface,
            // ),
            primaryColor: ThemeApp.primary,
            scaffoldBackgroundColorColor: ThemeApp.scaffoldBackgroundColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: ThemeApp.primary,
              foregroundColor: ThemeApp.onPrimary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: ThemeApp.primary, onPrimary: ThemeApp.onPrimary),
            ),
          ),
          // theme: ThemeData(
          //   primaryColor: ThemeApp.primaryColor,
          //   elevatedButtonTheme: ElevatedButtonThemeData(
          //     style: ElevatedButton.styleFrom(primary: ThemeApp.primaryColor),
          //   ),
          //   textButtonTheme: TextButtonThemeData(
          //     style: TextButton.styleFrom(
          //       primary: Colors.white,
          //     ),
          //   ),
          //   // elevatedButtonTheme: ElevatedButtonThemeData(
          //   //   style: ElevatedButton.styleFrom(
          //   //     primary: ThemeApp.primaryColor,
          //   //     onPrimary: ThemeApp.onPrimaryColor,
          //   //     onSurface: ThemeApp.onSurfaceColor,
          //   //   ),
          //   // ),
          //   dividerColor: Colors.white54,
          //   // buttonTheme: ButtonThemeData(
          //   //   buttonColor: ThemeApp.primaryColor,
          //   // ),
          //   // buttonTheme: ButtonThemeData(
          //   //   buttonColor: ThemeApp.primaryColor, //  <-- dark color
          //   //   textTheme: ButtonTextTheme
          //   //       .primary, //  <-- this auto selects the right color
          //   // ),
          //   // textButtonTheme: TextButtonThemeData(style: ButtonStyle.(backgroundColor:  ThemeApp.onPrimaryColor,)),
          //   scaffoldBackgroundColorColor: ThemeApp.scaffoldBackgroundColorColor,
          //   appBarTheme: AppBarTheme(
          //     color: ThemeApp.primaryColor,
          //     foregroundColor: ThemeApp.onPrimaryColor,
          //     // toolbarTextStyle: TextStyle(
          //     //   color: ThemeApp.onPrimaryColor,
          //     // ),
          //     // titleTextStyle: TextStyle(
          //     //   color: ThemeApp.onPrimaryColor,
          //     // ),
          //   ),
          //   // textTheme: ThemeData.dark().textTheme,
          //   // colorScheme: ColorScheme.fromSwatch(
          //   //         // primarySwatch: Colors.blue,
          //   //         )
          //   //     .copyWith(
          //   //   primary: ThemeApp.primaryColor,
          //   //   onPrimary: ThemeApp.onPrimaryColor,
          //   //   secondary: ThemeApp.secondaryColor,
          //   //   onSecondary: ThemeApp.onSecondaryColor,
          //   //   onBackground: ThemeApp.onBackgroundColor,
          //   //   onSurface: ThemeApp.onSurfaceColor,
          //   // ),
          //   // textTheme: TextTheme(),
          //   // // primaryColorLight: ThemeApp.primaryColor,
          //   // // primaryColorDark: ThemeApp.secondaryColor,
          //   // appBarTheme: AppBarTheme(
          //   //   //color: ThemeApp.primaryColor,
          //   //   backgroundColor: ThemeApp.primaryColor,
          //   //   toolbarTextStyle: TextStyle(
          //   //     color: ThemeApp.onPrimaryColor,
          //   //   ),
          //   //   titleTextStyle: TextStyle(
          //   //     color: ThemeApp.onPrimaryColor,
          //   //   ),
          //   // ),
          //   // floatingActionButtonTheme:
          //   //     FloatingActionButtonThemeData(backgroundColor: ThemeApp.floatingActionButtonColor),
          //   // colorScheme: ColorScheme.fromSwatch(
          //   //   // primarySwatch: ThemeApp.color1,
          //   //   primaryColorDark: ThemeApp.color1,
          //   //   // accentColor: accentColor,
          //   //   cardColor: ThemeApp.color1,
          //   //   backgroundColor: ThemeApp.color1,
          //   //   // errorColor: errorColor,
          //   //   // brightness: _brightness,
          //   // ),
          //   // primarySwatch: ThemeApp.primarySwatch,
          //   // elevatedButtonTheme: ElevatedButtonThemeData(
          //   //   style: ElevatedButton.styleFrom(primary: ThemeApp.floatingActionButtonColor),
          //   // ),
          // ),
          // theme: ThemeData.dark(),
          // theme: ThemeData.light(),
          // theme: example(),
          // theme: ThemeData(
          //   brightness: Brightness.dark,
          //       // iconTheme: IconThemeData(color: mainColor),

          //   // primaryColor: Colors.grey[900]!,
          //   // cardColor: Color.lerp(Colors.orange, Colors.amber, 1.2)
          //   // splashColor: Colors.yellow,
          // ),
          // theme: ThemeData(
          //   // Define the default brightness and colors.
          //   // primaryColor: Colors.orange,
          //   // Define the default font family.
          //   fontFamily: 'Georgia',

          //   // Define the default `TextTheme`. Use this to specify the default
          //   // text styling for headlines, titles, bodies of text, and more.
          //   textTheme: const TextTheme(
          //     headline1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          //     headline6: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
          //     bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          //   ),
          // ),
          // theme: ThemeData(
          //   //2
          //   primaryColor: CustomColors.purple,
          //   scaffoldBackgroundColorColor: Colors.white,
          //   fontFamily: 'Montserrat', //3
          //   buttonTheme: ButtonThemeData(
          //     // 4
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(18.0)),
          //     buttonColor: CustomColors.lightPurple,
          //   ),
          // ),
          // theme: ThemeData(
          //     primaryColor: Colors.grey,
          //     scaffoldBackgroundColorColor: Colors.black,
          //     fontFamily: 'Montserrat',
          //     textTheme: ThemeData.dark().textTheme,
          //     buttonTheme: ButtonThemeData(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0)),
          //       buttonColor: Colors.purple,
          //     )),

*/