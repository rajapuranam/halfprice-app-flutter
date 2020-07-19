import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get localFile async {
  final path = await localPath;
  return File('$path/tempdata.txt');
}

Future<dynamic> readContent() async {
  final file = await localFile;
  String contents = await file.readAsString();
  return contents;
}

writeContent(data) async {
  int i = 0;
  final file = await localFile;
  String rawJson;
  readContent().then((contents) {
    Map<String, dynamic> map = jsonDecode(contents);
    for (var element in map['data']) {
      if (element['name'] == data['name']) {
        i = 1;

        print("\nMatch found....");
      } else {
        print("\nMatch not found....");
      }
    }

    if (i == 0) {
      map['data'].add(data);
      rawJson = jsonEncode(map);
      file.writeAsString(rawJson);
    }

  });
  return "done...";
}

deleteContent(data) async {
  final file = await localFile;
  String rawJson;
  Map<String, dynamic> toStore = Map<String, dynamic>();
  toStore['data'] = [];
  readContent().then((contents) {
    Map<String, dynamic> map = jsonDecode(contents);

    for (var element in map['data']) {
      if (element['name'] == data['name']) {
        print("\nMatch found....");
      } else {
        toStore['data'].add(element);
      }
    }

    rawJson = jsonEncode(toStore);
    file.writeAsString(rawJson);
  });

  return "done...";
}
