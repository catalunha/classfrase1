import 'package:classfrase/observer/controller/observer_page_controller.dart';
import 'package:classfrase/users/controller/users_page_controller.dart';
import 'package:flutter/material.dart';

import 'classification/controller/category_addedit_page_controller.dart';
import 'classification/controller/category_page_controller.dart';
import 'classification/controller/group_addedit_page_controller.dart';
import 'classification/controller/group_page_controller.dart';
import 'classifying/controller/classifications_connector.dart';
import 'classifying/controller/classifying_connector.dart';
import 'learn/controller/learn_page_connector.dart';
import 'learn/controller/learn_phrase_filter_connector.dart';
import 'learn/controller/learn_phrase_list_page_connector.dart';
import 'learn/controller/learn_phrase_page_connector.dart';
import 'learn/controller/learning_users_page_connector.dart';
import 'home/coffee.dart';
import 'home/controller/home_page_connector.dart';
import 'home/information.dart';
import 'login/controller/login_connector.dart';
import 'observer/controller/observed_phrase_page_connector.dart';
import 'observer/controller/observer_phrase_page_controller.dart';
import 'pdf/controller/pdf_connector.dart';
import 'pdf/controller/pdf_learn_connector.dart';
import 'pdf/controller/pdf_observer_connector.dart';
import 'phrase/controller/phrase_addedit_page_connector.dart';
import 'phrase/controller/phrase_archived_page_connector.dart';
import 'login/controller/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/information': (BuildContext context) => Information(),
    '/coffee': (BuildContext context) => Coffee(),
    // +++ PDF
    '/pdf': (BuildContext context) => PdfConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/pdf_observer': (BuildContext context) => PdfObserverConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/pdf_learn': (BuildContext context) => PdfLearnConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    // +++ Phrase
    '/phrase_archived': (BuildContext context) => PhraseArchivedPageConnector(),
    '/phrase_addedit': (BuildContext context) => PhraseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    // Classifuing
    '/classifying': (BuildContext context) => ClassifyingConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/classifications': (BuildContext context) => ClassificationsConnector(
          groupId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    // Observer
    '/observer_list': (BuildContext context) => ObserverPageConnector(),
    '/observer_phrase': (BuildContext context) => ObserverPhrasePageConnector(
          observerId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/observed_phrase': (BuildContext context) => ObservedPhrasePageConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    // Learn
    '/learn': (BuildContext context) => LearnPageConnector(),
    '/learning_users': (BuildContext context) => LearningUsersPageConnector(
          learnId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/learn_phrase_list': (BuildContext context) =>
        LearnPhraseListPageConnector(
          userId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/learn_phrase_filter': (BuildContext context) =>
        LearnPhraseFilterConnector(
          userId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/learn_phrase': (BuildContext context) => LearnPhrasePageConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),

    // Admin
    '/group': (BuildContext context) => GroupPageConnector(),
    '/group_addedit': (BuildContext context) => GroupAddEditPageConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/category': (BuildContext context) => CategoryPageConnector(
          groupId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/category_addedit': (BuildContext context) => CategoryAddEditPageConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/users': (BuildContext context) => UsersPageConnector(),
  };
}
