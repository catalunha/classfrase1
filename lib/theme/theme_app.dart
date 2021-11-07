import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class ThemeApp {
  //Color for colorScheme
  static const primary = ColorRef(Colors.white, id: "primary");
  static const onPrimary = ColorRef(Colors.white, id: "onPrimary");
  static const primaryVariant = ColorRef(Colors.white, id: "primaryVariant");
  static const secondary = ColorRef(Colors.white, id: "secondary");
  static const onSecondary = ColorRef(Colors.white, id: "onSecondary");
  static const secondaryVariant =
      ColorRef(Colors.white, id: "secondaryVariant");
  static const background = ColorRef(Colors.white, id: "background");
  static const onBackground = ColorRef(Colors.white, id: "onBackground");
  static const surface = ColorRef(Colors.white, id: "surface");
  static const onSurface = ColorRef(Colors.white, id: "onSurface");
  static const error = ColorRef(Colors.white, id: "error");
  static const onError = ColorRef(Colors.pink, id: "onError");
  //Color for Screen
  static const scaffoldBackgroundColorColor =
      ColorRef(Colors.white, id: "scaffoldBackgroundColorColor");
  static const appBarBackgroundColor =
      ColorRef(Colors.white, id: "appBarBackgroundColor");

  //Color for specific WidgetTheme ou WidgetThemeData
  static const cardColor = ColorRef(Colors.white, id: "cardColor");

  //Color for specific moment
  static const backgroundText = ColorRef(Colors.white, id: 'backgroundText');
  static const backgroundPhrase =
      ColorRef(Colors.white, id: 'backgroundPhrase');
  static const backgroundSelected =
      ColorRef(Colors.white, id: 'backgroundSelected');
  static const highlightWord = ColorRef(Colors.white, id: 'highlightWord');

  //Color for especific icon and text
  static const icon01Color = ColorRef(Colors.white, id: "icon01Color");
  static const icon02Color = ColorRef(Colors.white, id: "icon02Color");
  static const text01Color = ColorRef(Colors.white, id: "text01Color");
  static const text02Color = ColorRef(Colors.white, id: "text02Color");
}

Map<ThemeRef, Object> orange = {
  //Color for colorScheme
  ThemeApp.primary: Colors.orange,
  ThemeApp.onPrimary: Colors.black,
  ThemeApp.primaryVariant: Colors.red,
  ThemeApp.secondary: Colors.orange,
  ThemeApp.onSecondary: Colors.black,
  ThemeApp.secondaryVariant: Colors.red,
  ThemeApp.background: Colors.red,
  ThemeApp.onBackground: Colors.black,
  ThemeApp.surface: Colors.red,
  ThemeApp.onSurface: Colors.red,
  ThemeApp.error: Colors.red,
  ThemeApp.onError: Colors.red,
  //Color for Screen
  ThemeApp.scaffoldBackgroundColorColor: Colors.white,
  ThemeApp.appBarBackgroundColor: Colors.orange,
  //Color for specific WidgetTheme ou WidgetThemeData
  ThemeApp.cardColor: Colors.white,
  //Color for specific moment
  ThemeApp.backgroundText: Colors.grey.shade300,
  ThemeApp.backgroundPhrase: Colors.orange.shade100,
  ThemeApp.backgroundSelected: Colors.yellow,
  ThemeApp.highlightWord: Colors.orange.shade900,
  //Color for especific icon and text
  ThemeApp.icon01Color: Colors.orange,
  ThemeApp.icon02Color: Colors.red,
  ThemeApp.text01Color: Colors.black,
  ThemeApp.text02Color: Colors.red,
};

class ThemeDataApp {
  // MaterialColor myColorSwatch = MaterialColorRef(myColorSwatch);
  ThemeData get changed {
    ColorScheme colorScheme = ThemeData().colorScheme.copyWith(
          primary: ThemeApp.primary,
          onPrimary: ThemeApp.onPrimary,
          secondary: ThemeApp.secondary,
          onSecondary: ThemeApp.onSecondary,
          onBackground: ThemeApp.onBackground,
          onSurface: ThemeApp.onSurface,
        );
    TextTheme textTheme = const TextTheme(
        // headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
        // headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
        // headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
        // headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
        // headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        // headline6: TextStyle(
        //   fontSize: 20.0,
        // ), //fontFamily: 'Georgia'
        // subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        // subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        // bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
        // button: TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
        // caption: TextStyle(fontSize: 12.0, fontFamily: 'Georgia'),
        // overline: TextStyle(fontSize: 10.0, fontFamily: 'Georgia'),
        );

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    var themeDataUpdated = ThemeData.from(
            textTheme: textTheme, colorScheme: colorScheme)
        // We can also add on some extra properties that ColorScheme seems to miss
        .copyWith(
      scaffoldBackgroundColor: ThemeApp.scaffoldBackgroundColorColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeApp.primary,
        foregroundColor: ThemeApp.onPrimary,
      ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //       primary: ThemeApp.primary, onPrimary: ThemeApp.onPrimary),
      // ),
      // cardTheme: CardTheme(
      //   color: ThemeApp.cardColor,
      //   // shadowColor: ThemeApp.appBar,
      // ),
      // textTheme: TextTheme(
      //   bodyText1: TextStyle(color: Colors.white),
      // ),
      // scaffoldBackgroundColor: ThemeApp.scaffoldBackgroundColor,
      // cardColor: ThemeApp.cardColor,
      // textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //         foregroundColor:
      //             MaterialStateProperty.all<Color>(ThemeApp.onBackground))),
      iconTheme: IconThemeData(color: Colors.grey.shade800),
    );

    /// Return the themeData which MaterialApp can now use
    return themeDataUpdated;
  }
}

Map<ThemeRef, Object> dark = {
//Color for colorScheme
  ThemeApp.primary: Colors.lime,
  ThemeApp.onPrimary: Colors.lime,
  ThemeApp.primaryVariant: Colors.lime,
  ThemeApp.secondary: Colors.lime,
  ThemeApp.onSecondary: Colors.lime,
  ThemeApp.secondaryVariant: Colors.lime,
  ThemeApp.background: Colors.lime,
  ThemeApp.onBackground: Colors.lime,
  ThemeApp.surface: Colors.lime,
  ThemeApp.onSurface: Colors.lime,
  ThemeApp.error: Colors.lime,
  ThemeApp.onError: Colors.lime,
  //Color for Screen
  ThemeApp.scaffoldBackgroundColorColor: Colors.lime,
  ThemeApp.appBarBackgroundColor: Colors.lime,
  //Color for specific WidgetTheme ou WidgetThemeData
  ThemeApp.cardColor: Colors.lime,
  //Color for specific moment
  ThemeApp.backgroundText: Colors.lime,
  ThemeApp.backgroundPhrase: Colors.lime,
  ThemeApp.backgroundSelected: Colors.lime,
  ThemeApp.highlightWord: Colors.lime,
  //Color for especific icon and text
  ThemeApp.icon01Color: Colors.lime,
  ThemeApp.icon02Color: Colors.lime,
  ThemeApp.text01Color: Colors.lime,
  ThemeApp.text02Color: Colors.lime,
};
