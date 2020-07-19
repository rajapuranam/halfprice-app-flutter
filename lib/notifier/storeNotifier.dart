import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:halfprice/models/Store.dart';

class StoreNotifier with ChangeNotifier {
  List<StoreModel> _storeList = [];
  StoreModel _currentStore;

  UnmodifiableListView<StoreModel> get storeList => UnmodifiableListView(_storeList);

  StoreModel get currentStore => _currentStore;

  set storeList(List<StoreModel> storeList) {
    _storeList = storeList;
    notifyListeners();
  }

  set currentFood(StoreModel store) {
    _currentStore = store;
    notifyListeners();
  }

  addStore(StoreModel store) {
    _storeList.insert(0, store);
    notifyListeners();
  }

  deleteStore(StoreModel store) {
    _storeList.removeWhere((_store) => _store.storeName == store.storeName);
    notifyListeners();
  }
}