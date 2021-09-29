// class UserModel {
//   static final String collection = 'users';
//   late final String? photoURL;
//   late final String? displayName;
//   late final String email;
//   late final bool isActive;
// }

// class PhraseModel {
//   static final String collection = 'phrases';

//   late final String userId;
//   late final String phrase;
//   late final String? font;
//   late final String? description;
//   late final bool isArchived;
//   late final bool isPublic;
//   late final String? observer;

//   late final Map<String, String>
//       classification; // phraseListPos0,phraseListPos1:classificationId1,classificationId2
//   late final bool isDeleted;
// }

// class ClassificationModel {
//   static final String collection = 'classifications';
//   // uuid:title
//   // Ex.:
//   // uuid: Morfológica
//   // uuid: Sintática
//   // uuid: Semântica
//   late final Map<String, Group> group; // uuid:Type

//   late final Map<String, Classification> Category; // uuid:Category

// }

// class Group {
//   late final String title;
//   late final String? url;
// }

// class Category {
//   late final String type;
//   late final String title;
//   late final String? url;
// }

// class ObserverModel {
//   late final String descrition;
//   late final List<String> phraseIdList;
//   late final bool isDeleted;
// }
