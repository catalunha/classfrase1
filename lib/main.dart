import 'package:async_redux/async_redux.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app_state.dart';
import 'routes.dart';
import 'theme/app_colors.dart';

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
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'ClassFrase',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          primarySwatch: AppColors.swatch,
        ),
        navigatorKey: navigatorKey,
        routes: Routes.routes,
        initialRoute: '/',
      ),
    );
  }
}
