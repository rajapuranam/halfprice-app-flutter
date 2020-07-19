import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

class SpecialDealsModel {
  List<dynamic> sd = List<dynamic>();
  String storeName;
  
  SpecialDealsModel.fromMap(Map<String, dynamic> data, String stName) {
    sd = data['sd1'];
    storeName = stName;
    
  }

  Map<String, dynamic> toMap() {
    return {
      'sd': sd,
    };
  }
}
