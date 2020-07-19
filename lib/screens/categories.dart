import 'package:flutter/material.dart';
import 'package:halfprice/notifier/categoryNotifier.dart';
import 'package:halfprice/screens/categoryItems.dart';
import 'package:halfprice/services/firestoreCRUD.dart';
import 'package:halfprice/services/seachItems.dart';
import 'package:halfprice/singleGridItem.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  
  @override
  void initState() {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    getCatgeory(categoryNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Half Price"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Datasearch(categoryNotifier.categoryList, "category"));
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              print("Notifications...");
            },
          ),
        ],
      ), 
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Categories'.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 2.0,
                    fontFamily: 'Taviraj',
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 35, bottom: 50),
              child: GridView.builder(
                itemCount: categoryNotifier.categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoryItems(categoryNotifier.categoryList[index]),
                          ),
                        );
                      },
                      child: SingleGridItem(
                      categoryNotifier.categoryList[index].name,
                      categoryNotifier.categoryList[index].image,
                    ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
