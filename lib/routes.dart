import 'package:classfrase/observer/controller/observer_page_controller.dart';
import 'package:classfrase/users/controller/users_page_controller.dart';
import 'package:flutter/material.dart';

import 'classification/controller/category_addedit_page_controller.dart';
import 'classification/controller/category_page_controller.dart';
import 'classification/controller/group_addedit_page_controller.dart';
import 'classification/controller/group_page_controller.dart';
import 'classifying/controller/classifications_connector.dart';
import 'classifying/controller/classifying_connector.dart';
import 'follow/controller/follow_addedit_page_controller.dart';
import 'follow/controller/follow_page_connector.dart';
import 'follow/controller/follow_user_add_page_controller.dart';
import 'follow/controller/following_users_page_controller.dart';
import 'home/coffee.dart';
import 'home/controller/home_page_connector.dart';
import 'home/information.dart';
import 'login/controller/login_connector.dart';
import 'observer/controller/observed_phrase_page_connector.dart';
import 'observer/controller/observer_addedit_page_controller.dart';
import 'observer/controller/observer_phrase_page_controller.dart';
import 'phrase/controller/phrase_addedit_connector.dart';
import 'phrase/controller/phrase_archived_page_connector.dart';
import 'login/controller/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/information': (BuildContext context) => Information(),
    '/coffee': (BuildContext context) => Coffee(),
    //+++ Phrase
    '/phrase_archived': (BuildContext context) => PhraseArchivedPageConnector(),
    '/phrase_addedit': (BuildContext context) => PhraseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/classifying': (BuildContext context) => ClassifyingConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/classifications': (BuildContext context) => ClassificationsConnector(
          groupId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    //+++ Observer
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
    //+++ Follow People
    '/follow': (BuildContext context) => FollowPageConnector(),
    '/follow_addedit': (BuildContext context) => FollowAddEditPageConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/following_users': (BuildContext context) => FollowingUsersPageConnector(
          followId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/follow_user_add': (BuildContext context) => FollowUserAddPageConnector(),
    '/follow_phrases': (BuildContext context) => ObserverPhrasePageConnector(
          observerId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/follow_phrase': (BuildContext context) => ObservedPhrasePageConnector(
          phraseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),

    // +++ admin
    '/users': (BuildContext context) => UsersPageConnector(),
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
  };
}
