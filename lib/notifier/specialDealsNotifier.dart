import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:halfprice/models/SpecialDeals.dart';

class SpecialDealsNotifier with ChangeNotifier {
  List<SpecialDealsModel> _specialDealsList = [];
  SpecialDealsModel _currentSpecialDeal;

  UnmodifiableListView<SpecialDealsModel> get specialdealsList => UnmodifiableListView(_specialDealsList);

  SpecialDealsModel get currentSpecialDeal => _currentSpecialDeal;

  set specialdealsList(List<SpecialDealsModel> specialdealsList) {
    _specialDealsList = specialdealsList;
    notifyListeners();
  }

  set currentFood(SpecialDealsModel specialdeal) {
    _currentSpecialDeal = specialdeal;
    notifyListeners();
  }

  addSpecialDeals(SpecialDealsModel specialdeal) {
    _specialDealsList.insert(0, specialdeal);
    notifyListeners();
  }

  deleteSpecialDeals(SpecialDealsModel specialdeal) {
    _specialDealsList.removeWhere((_specialdeal) => _specialdeal.sd == specialdeal.sd);
    notifyListeners();
  }
}