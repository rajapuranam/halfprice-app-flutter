import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

class StoreModel {
  String logo, storeName;
  Map<String, List<dynamic>> storeItems = Map<String, List<dynamic>>();

  StoreModel.fromMap(Map<String, dynamic> data) {
    logo = data['logo'];
    storeName = data['storeName'];

    data.remove('logo');
    data.remove('storeName');

    data.forEach((key, value) {
      storeItems[key] = value;
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'logo': logo,
      'storeName': storeName,
      'storeItems': storeItems,
    };
  }
}

