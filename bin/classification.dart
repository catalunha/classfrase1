import 'dart:io';
import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'ngb_category_model.dart';
import 'ngb_group_model.dart';

class Text2JsonClassifications {
  final String path;
  final String fileNameGroup;
  List<NgbGroup> _ngbGroupList = [];

  Text2JsonClassifications({
    required this.path,
    required this.fileNameGroup,
  });

  void readGroup() {
    String pathFileName = '$path/$fileNameGroup.txt';

    var groupLineList = File(pathFileName).readAsLinesSync();

    final List<NgbGroup> ngbGroupList = groupLineList.map((line) {
      var fieldList = line.split('|');

      return NgbGroup(
          id: fieldList[2].trim(),
          title: fieldList[0].trim(),
          description: fieldList[1].trim());
    }).toList();

    // ngbGroupList.forEach(print);
    _ngbGroupList = ngbGroupList;
  }

  List<NgbCategory> readCategory(
      {required String name, required String groupId}) {
    print(name);

    String pathFileName = '$path/$name.txt';
    var lineList = File(pathFileName).readAsLinesSync();

    final List<NgbCategory> ngbCategoryList = lineList.map((line) {
      var fieldList = line.split('|');

      return NgbCategory(
        title: fieldList[0].trim(),
        description: fieldList[1].trim(),
        id: fieldList[2].trim().isEmpty ? Uuid().v4() : fieldList[2].trim(),
        group: groupId,
        filter: fieldList[1].trim() == '*' ? ['Undefined'] : ['ngb'],
      );
    }).toList();

    // ngbCategoryList.forEach(((element) {
    //   print(
    //       '${element.title} |${element.description}| ${element.filter} | ${element.id} | ${element.group}');
    // }));
    return ngbCategoryList;
  }

  void writeJsonGroup() {
    String pathFileName = '$path/jsonGroup.json';

    if (File(pathFileName).existsSync()) File(pathFileName).deleteSync();
    var fileOpen = File(pathFileName).openWrite(mode: FileMode.append);
    fileOpen.write('[');
    fileOpen.write(_ngbGroupList.map((e) => e.toJson()).join(','));
    fileOpen.write(']');
    fileOpen.close();
  }

  void writeJsonCategory() {
    String pathFileName = '$path/jsonCategory.json';

    if (File(pathFileName).existsSync()) File(pathFileName).deleteSync();
    var fileOpen = File(pathFileName).openWrite(mode: FileMode.append);
    fileOpen.write('[');
    List<NgbCategory> ngbCategoryListAllGroups = [];
    for (var group in _ngbGroupList) {
      var ngbCategoryList = readCategory(name: group.title, groupId: group.id);
      ngbCategoryListAllGroups.addAll(ngbCategoryList);
    }
    fileOpen.write(ngbCategoryListAllGroups.map((e) => e.toJson()).join(','));
    fileOpen.write(']');
    fileOpen.close();
  }

  void writeTextCategory() {
    String pathFileName = '$path/txtCategory.txt';
    if (File(path).existsSync()) File(pathFileName).deleteSync();

    var fileOpen = File(path).openWrite(mode: FileMode.append);
    for (var group in _ngbGroupList) {
      var ngbCategoryList = readCategory(name: group.title, groupId: group.id);
      fileOpen.writeln('${group.title}');
      for (var item in ngbCategoryList) {
        fileOpen.writeln(
            '${item.title} |${item.description}| ${item.filter} | ${item.id} | ${item.group}');
      }
    }

    fileOpen.close();
  }

  void readJsonGroup() {
    String pathFileName = '$path/jsonGroup.json';

    var fileReadAsString = File(pathFileName).readAsStringSync();
    final List<dynamic> fileReadAsJson = jsonDecode(fileReadAsString);
    final a = fileReadAsJson.map((resp) => NgbGroup.fromMap(resp)).toList();
    print(a);
  }

  void readJsonCategory() {
    String pathFileName = '$path/jsonCategory.json';

    var fileReadAsString = File(pathFileName).readAsStringSync();
    final List<dynamic> fileReadAsJson = jsonDecode(fileReadAsString);
    final a = fileReadAsJson.map((resp) => NgbCategory.fromMap(resp)).toList();
    print(a);
  }

  void testIfJsonCategoryAsDoubleId() {
    String pathFileName = '$path/jsonCategory.json';

    var fileReadAsString = File(pathFileName).readAsStringSync();
    final List<dynamic> fileReadAsJson = jsonDecode(fileReadAsString);
    final ngbCategoryList =
        fileReadAsJson.map((resp) => NgbCategory.fromMap(resp)).toList();
    print('Categorias cadastradas: ${ngbCategoryList.length}');
    List<String> idlist = [];
    for (var ngbCategory in ngbCategoryList) {
      if (idlist.contains(ngbCategory.id)) {
        print('Ops: Este id esta duplicado.');
        print(
            '${ngbCategory.title} |${ngbCategory.description}| ${ngbCategory.filter} | ${ngbCategory.id} | ${ngbCategory.group}');
      } else {
        idlist.add(ngbCategory.id);
      }
    }
  }
}
