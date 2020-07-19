import 'package:flutter/material.dart';
import 'package:halfprice/screens/categoryItems.dart';
import 'package:halfprice/screens/storeItems.dart';
import 'package:halfprice/services/storeData.dart';
import 'package:halfprice/singleGridItem.dart';
import 'package:halfprice/singleItem.dart';

class Datasearch extends SearchDelegate<String> {
  var cities = ["delhi", 'lucknow', "agra", "mumbai", "hyderabad", "denkada"];

  var toSearch, flag;
  var tempDict = {};
  var tempArr = [];

// flag = category, store

  Datasearch(this.toSearch, this.flag) {
    if (flag == "store") {
      for (var i = 0; i < toSearch.length; i++) {
        tempDict[toSearch[i].storeName] = toSearch[i].logo;
        tempArr.add(toSearch[i].storeName);
      }
    } else if (flag == "category") {
      for (var i = 0; i < toSearch.length; i++) {
        tempDict[toSearch[i].name.toLowerCase()] = toSearch[i].image;
        tempArr.add(toSearch[i].name.toLowerCase());
      }
      
    } else print(toSearch);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    var results = tempArr
        .where((element) => element.startsWith(query.toLowerCase()))
        .toList();
    if (flag == "store") {
      return Container(
        margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
        child: GridView.builder(
          itemCount: results.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StoreItems(toSearch[tempArr.indexOf(results[index])]),
                    ),
                  );
                },
                child: SingleGridItem(
                  results[index],
                  tempDict[results[index]],
                ),
              ),
            );
          },
        ),
      );
    } else if (flag == "category") {
      return Container(
        margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
        child: GridView.builder(
          itemCount: results.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryItems(
                            toSearch[tempArr.indexOf(results[index])])),
                  );
                },
                child: SingleGridItem(
                  results[index],
                  tempDict[results[index]],
                ),
              ),
            );
          },
        ),
      );
    } else if (flag == "categoryItems") {
      toSearch.forEach((element) {
        if (element['name']
            .toString()
            .toLowerCase()
            .startsWith(query.toLowerCase())) results.add(element);
      });
      return Container(
        margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Container(
                  child: SingleItem(results[index]),
                ),
                Positioned(
                  right: 25.0,
                  bottom: 10.0,
                  child: IconButton(
                    icon: results[index]['isLiked']
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    iconSize: 45,
                    color: Color.fromRGBO(166, 16, 16, 0.8),
                    onPressed: () {
                      writeContent(results[index]).then((returnValue) {});
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else if (flag == "storeItems") {
      toSearch.forEach((element) {
        if (element['name']
            .toString()
            .toLowerCase()
            .startsWith(query.toLowerCase())) results.add(element);
      });
      
      return Container(
        margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
        child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: SingleItem(results[index]),
                  ),
                  Positioned(
                    right: 25.0,
                    bottom: 10.0,
                    child: IconButton(
                      icon: results[index]['isLiked']
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      iconSize: 45,
                      color: Color.fromRGBO(166, 16, 16, 0.8),
                      onPressed: () {
                        writeContent(results[index]).then((returnValue) {});
                      },
                    ),
                  ),
                ],
              );
            }),
      );
    }
  }
}
