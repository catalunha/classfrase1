import 'package:flutter/material.dart';

import 'home/coffee.dart';
import 'home/controller/home_page_connector.dart';
import 'home/information.dart';
import 'home/orientations.dart';
import 'login/controller/login_connector.dart';
import 'observer/observer_list.dart';
import 'phrase/controller/phrase_addedit_connector.dart';
import 'phrase/phrase_archived.dart';
import 'splash/controller/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/information': (BuildContext context) => Information(),
    '/orientations': (BuildContext context) => Orientations(),
    '/coffee': (BuildContext context) => Coffee(),
    '/phrase_archived': (BuildContext context) => PhraseArchived(),
    '/phrase_addedit': (BuildContext context) => PhraseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/observer_list': (BuildContext context) => ObserverList(),
  };
}
