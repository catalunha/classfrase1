// import 'splitPhrase.dart';
// import 'uuidTest.dart';
// import 'map_list.dart';

import 'classification.dart';

void main() {
  // id();
  // splitPhrase();
  // map_list();
  // a = '';

  Text2JsonClassifications text2jsonClassifications = Text2JsonClassifications(
      path: '/home/catalunha/myapp/classfrase/docs/ngb',
      fileNameGroup: 'group.txt');
  text2jsonClassifications.readGroup();
  text2jsonClassifications.writeJsonGroup();
  text2jsonClassifications.writeJsonCategory();
  text2jsonClassifications.writeTextCategory();
  text2jsonClassifications.readJsonGroup();
  text2jsonClassifications.readJsonCategory();
  text2jsonClassifications.testIfJsonCategoryAsDoubleId();
}
