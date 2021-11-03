import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
  //Color for Basic Theme
  // static const primarySwatch = ColorRef(Colors.green);
  static const primaryColor = ColorRef(Colors.orange);
  static const onPrimaryColor = ColorRef(Colors.black, id: 'onPrimaryColor');
  static const secondaryColor = ColorRef(Colors.amber);
  static const onSecondaryColor =
      ColorRef(Colors.black, id: 'onSecondaryColor');
  static const onBackgroundColor =
      ColorRef(Colors.black, id: 'onBackgroundColor');
  static const onSurfaceColor = ColorRef(Colors.black, id: 'onSurfaceColor');
  static const appBarColor = ColorRef(Colors.blue);
  static const scaffoldBackgroundColor = ColorRef(Colors.cyan);
  static const floatingActionButtonColor = ColorRef(Colors.deepOrange);

  static const mainStyle = TextStyleRef(
    TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: MyTheme.primaryColor),
  );
  //Color for specific Widget
  static const iconAddOrEdit = ColorRef(Colors.orange, id: 'fieldAddOrEdit');
  static const backgroundTitle = ColorRef(Colors.orange, id: 'backgroundTitle');
  static const backgroundPhrase =
      ColorRef(Colors.orange, id: 'backgroundPhrase');
  static const highlightWord = ColorRef(Colors.orange, id: 'highlightWord');
  static const backgroundSelected =
      ColorRef(Colors.yellow, id: 'backgroundSelected');
}

Map<ThemeRef, Object> myThemeOrange = {
  // MyTheme.primarySwatch: Colors.orange.shade900,
  MyTheme.primaryColor: Colors.orange.shade600,
  MyTheme.onPrimaryColor: Colors.black,
  MyTheme.secondaryColor: Colors.orange.shade500,
  MyTheme.onSecondaryColor: Colors.black,
  MyTheme.onBackgroundColor: Colors.black,
  MyTheme.onSurfaceColor: Colors.black,
  MyTheme.appBarColor: Colors.green,
  MyTheme.scaffoldBackgroundColor: Colors.white,
  MyTheme.floatingActionButtonColor: Colors.pink,
  MyTheme.mainStyle: const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w900, color: MyTheme.primaryColor),
  MyTheme.iconAddOrEdit: Colors.orange.shade500,
  MyTheme.backgroundTitle: Colors.grey.shade300,
  MyTheme.backgroundPhrase: Colors.orange.shade100,
  MyTheme.highlightWord: Colors.orange.shade900,
  MyTheme.backgroundSelected: Colors.yellow,
};
Map<ThemeRef, Object> myThemeDark = {
  // MyTheme.primarySwatch: Colors.orange.shade900,
  MyTheme.primaryColor: Colors.grey[800]!,
  MyTheme.onPrimaryColor: Colors.yellow,
  MyTheme.secondaryColor: Colors.tealAccent[200]!,
  MyTheme.onSecondaryColor: Colors.yellow,
  MyTheme.onBackgroundColor: Colors.yellow,
  MyTheme.onSurfaceColor: Colors.pink,
  MyTheme.appBarColor: Colors.green,
  MyTheme.scaffoldBackgroundColor: Colors.grey.shade200,
  MyTheme.floatingActionButtonColor: Colors.pink,
  MyTheme.mainStyle: const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w900, color: MyTheme.primaryColor),
  MyTheme.iconAddOrEdit: Colors.orange.shade500,
  MyTheme.backgroundTitle: Colors.grey.shade300,
  MyTheme.backgroundPhrase: Colors.orange.shade100,
  MyTheme.highlightWord: Colors.orange.shade900,
  MyTheme.backgroundSelected: Colors.yellow,
};
