import 'package:async_redux/async_redux.dart';
import 'package:classfrase/theme/app_themes.dart';

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

// class CustomColors {
//   static const Color lightPurple = Color(0xFFBB86FA);
//   static const Color purple = Color(0xFF6002EE);
//   static const Color deepPurple = Color(0xFF3900B1);
//   static const Color grey = Color(0xFF848484);
//   static const Color darkGrey = Color(0xFF222222);
//   static const Color black = Color(0xFF141414);
// }

// ThemeData example() {
//   final base = ThemeData(brightness: Brightness.dark);
//   final mainColor = Colors.orange;
//   return base.copyWith(
//     // primaryIconTheme: IconThemeData(color: Colors.orange),
//     iconTheme: IconThemeData(color: mainColor),
//     // cardColor: Color.lerp(mainColor, Colors.white, 0.2),
//     // cardTheme: base.cardTheme.copyWith(
//     //   color: Color.lerp(mainColor, Colors.black, 0.1),
//     //   margin: EdgeInsets.all(20.0),
//     //   elevation: 0.0,
//     //   shape: BeveledRectangleBorder(
//     //       borderRadius: BorderRadius.circular(14.0),
//     //       side: BorderSide(color: Colors.white24, width: 1)),
//     // ),
//   );
// }

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
        defaultTheme: myThemeOrange,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          title: 'ClassFrase',
          theme: ThemeData(
            primaryColor: MyTheme.primaryColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(primary: MyTheme.primaryColor),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ElevatedButton.styleFrom(
            //     primary: MyTheme.primaryColor,
            //     onPrimary: MyTheme.onPrimaryColor,
            //     onSurface: MyTheme.onSurfaceColor,
            //   ),
            // ),
            dividerColor: Colors.white54,
            // buttonTheme: ButtonThemeData(
            //   buttonColor: MyTheme.primaryColor,
            // ),
            // buttonTheme: ButtonThemeData(
            //   buttonColor: MyTheme.primaryColor, //  <-- dark color
            //   textTheme: ButtonTextTheme
            //       .primary, //  <-- this auto selects the right color
            // ),
            // textButtonTheme: TextButtonThemeData(style: ButtonStyle.(backgroundColor:  MyTheme.onPrimaryColor,)),
            scaffoldBackgroundColor: MyTheme.scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(
              color: MyTheme.primaryColor,
              foregroundColor: MyTheme.onPrimaryColor,
              // toolbarTextStyle: TextStyle(
              //   color: MyTheme.onPrimaryColor,
              // ),
              // titleTextStyle: TextStyle(
              //   color: MyTheme.onPrimaryColor,
              // ),
            ),
            // textTheme: ThemeData.dark().textTheme,
            // colorScheme: ColorScheme.fromSwatch(
            //         // primarySwatch: Colors.blue,
            //         )
            //     .copyWith(
            //   primary: MyTheme.primaryColor,
            //   onPrimary: MyTheme.onPrimaryColor,
            //   secondary: MyTheme.secondaryColor,
            //   onSecondary: MyTheme.onSecondaryColor,
            //   onBackground: MyTheme.onBackgroundColor,
            //   onSurface: MyTheme.onSurfaceColor,
            // ),
            // textTheme: TextTheme(),
            // // primaryColorLight: MyTheme.primaryColor,
            // // primaryColorDark: MyTheme.secondaryColor,
            // appBarTheme: AppBarTheme(
            //   //color: MyTheme.primaryColor,
            //   backgroundColor: MyTheme.primaryColor,
            //   toolbarTextStyle: TextStyle(
            //     color: MyTheme.onPrimaryColor,
            //   ),
            //   titleTextStyle: TextStyle(
            //     color: MyTheme.onPrimaryColor,
            //   ),
            // ),
            // floatingActionButtonTheme:
            //     FloatingActionButtonThemeData(backgroundColor: MyTheme.floatingActionButtonColor),
            // colorScheme: ColorScheme.fromSwatch(
            //   // primarySwatch: MyTheme.color1,
            //   primaryColorDark: MyTheme.color1,
            //   // accentColor: accentColor,
            //   cardColor: MyTheme.color1,
            //   backgroundColor: MyTheme.color1,
            //   // errorColor: errorColor,
            //   // brightness: _brightness,
            // ),
            // primarySwatch: MyTheme.primarySwatch,
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ElevatedButton.styleFrom(primary: MyTheme.floatingActionButtonColor),
            // ),
          ),
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
          //   scaffoldBackgroundColor: Colors.white,
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
          //     scaffoldBackgroundColor: Colors.black,
          //     fontFamily: 'Montserrat',
          //     textTheme: ThemeData.dark().textTheme,
          //     buttonTheme: ButtonThemeData(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0)),
          //       buttonColor: Colors.purple,
          //     )),
          navigatorKey: navigatorKey,
          routes: Routes.routes,
          initialRoute: '/',
        ),
      ),
    );
  }
}
