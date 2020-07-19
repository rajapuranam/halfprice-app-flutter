import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final databaseReference = Firestore.instance;

  String image, name;
  var itemsArray, toSend = [];
  List<dynamic> refs = List<dynamic>();

  CategoryModel.fromMap(Map<String, dynamic> data) {
    image = data['image'];
    name = data['name'];
    refs = data['refs']; 
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'refs': refs,
      'itemsArray': itemsArray,
    };
  }

  tempFunction() async {
    String cat = name.toString().toLowerCase();
    await Future.forEach(refs, (val) async {
      var data001;
      await val['ref'].get().then((document) {
        data001 = document.data;
        if (data001.containsKey(cat)) {
          itemsArray = data001['$cat'];
          itemsArray.forEach((item) {
            item.addAll({'itemName': data001['storeName'], 'cate': '$cat'});
          });
          toSend.addAll(itemsArray);
        }
      });
    });
    toMap();
  }
}
