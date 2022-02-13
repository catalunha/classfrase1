import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:classfrase/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'ClassFrase',
      // theme: appThemeDataDark,
      // darkTheme: appThemeDataDark,
      // themeMode: ThemeMode.system,
      getPages: RoutesPages.pageList,
      initialRoute: '/',
      // locale: const Locale('pt', 'BR'),
      // translationsKeys: AppTranslations.translations,
    );
  }
}
