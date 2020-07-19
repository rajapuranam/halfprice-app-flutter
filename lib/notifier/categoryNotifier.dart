import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:halfprice/models/Category.dart';

class CategoryNotifier with ChangeNotifier {
  List<CategoryModel> _categoryList = [];
  CategoryModel _currentCategory; 

  UnmodifiableListView<CategoryModel> get categoryList => UnmodifiableListView(_categoryList);

  CategoryModel get currentCategory => _currentCategory;

  set categoryList(List<CategoryModel> categoryList) {
    _categoryList = categoryList;
    notifyListeners(); 
  }

  set currentFood(CategoryModel category) {
    _currentCategory = category;
    notifyListeners();
  }

  addCategory(CategoryModel category) {
    _categoryList.insert(0, category);
    notifyListeners();
  }

  deleteCategory(CategoryModel category) {
    _categoryList.removeWhere((_category) => _category.name == category.name);
    notifyListeners();
  }
}