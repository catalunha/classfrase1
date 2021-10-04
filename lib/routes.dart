import 'package:classfrase/observer/controller/observer_page_controller.dart';
import 'package:flutter/material.dart';

import 'classifying/controller/classifications_connector.dart';
import 'classifying/controller/classifying_connector.dart';
import 'home/coffee.dart';
import 'home/controller/home_page_connector.dart';
import 'home/information.dart';
import 'login/controller/login_connector.dart';
import 'observer/controller/observed_phrase_page_connector.dart';
import 'observer/controller/observer_addedit_page_controller.dart';
import 'observer/controller/observer_phrase_page_controller.dart';
import 'observer/observer_page.dart';
import 'phrase/controller/phrase_addedit_connector.dart';
import 'phrase/controller/phrase_archived_page_connector.dart';
import 'splash/controller/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/information': (BuildContext context) => Information(),
    '/coffee': (BuildContext context) => Coffee(),
    '/phrase_archived': (BuildContext context) => PhraseArchivedPageConnector(),
    '/phrase_addedit': (BuildContext context) => PhraseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/observer_list': (BuildContext context) => ObserverPageConnector(),
    '/observer_addedit': (BuildContext context) => ObserverAddEditPageConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/observer_phrase': (BuildContext context) => ObserverPhrasePageConnector(
          observerId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/observed_phrase': (BuildContext context) => ObservedPhrasePageConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/classifying': (BuildContext context) => ClassifyingConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/classifications': (BuildContext context) => ClassificationsConnector(
          groupId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
  };
}
