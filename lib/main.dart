import 'package:classfrase/view/theme/app_theme.dart';
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
      theme: appThemeDataOrange,
      // darkTheme: appThemeDataDark,
      // themeMode: ThemeMode.system,
      getPages: Routes.pageList,
      initialRoute: Routes.splash,
      // locale: const Locale('pt', 'BR'),
      // translationsKeys: AppTranslations.translations,
    );
  }
}
