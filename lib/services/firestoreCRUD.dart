import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halfprice/models/Category.dart';
import 'package:halfprice/models/SpecialDeals.dart';
import 'package:halfprice/models/Store.dart';
import 'package:halfprice/notifier/categoryNotifier.dart';
import 'package:halfprice/notifier/specialDealsNotifier.dart';
import 'package:halfprice/notifier/storeNotifier.dart';

final databaseReference = Firestore.instance;

getStores(StoreNotifier storeNotifier) async {
  QuerySnapshot snapshot = await databaseReference
      .collection('stores')
      .getDocuments();

  List<StoreModel> _storeList = [];

  snapshot.documents.forEach((document) {
    StoreModel store = StoreModel.fromMap(document.data);

    _storeList.add(store);
  });

  storeNotifier.storeList = _storeList;
}

getCatgeory(CategoryNotifier categoryNotifier) async {
  QuerySnapshot snapshot = await databaseReference
      .collection('categories')
      .getDocuments();

  List<CategoryModel> _categoryList = [];

  snapshot.documents.forEach((document) {
    CategoryModel store = CategoryModel.fromMap(document.data);

    _categoryList.add(store);
  });

  categoryNotifier.categoryList = _categoryList;
}

getSpecialDeals(SpecialDealsNotifier specialDealsNotifier) async {
  QuerySnapshot snapshot = await databaseReference
      .collection('specialdeals')
      .getDocuments();

  List<SpecialDealsModel> _specialDealsList = [];

  snapshot.documents.forEach((document) {
    SpecialDealsModel sd = SpecialDealsModel.fromMap(document.data, document.documentID);
    
    
    _specialDealsList.add(sd);
  });

  specialDealsNotifier.specialdealsList = _specialDealsList;

  String sale = '';

  await databaseReference
      .collection('saleperiod')
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((doc) => sale = doc.data['period']);
  });
  return sale.toString();

}
