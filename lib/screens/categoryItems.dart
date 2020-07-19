import 'package:flutter/material.dart';
import 'package:halfprice/services/seachItems.dart';
import 'package:halfprice/services/storeData.dart';
import 'package:halfprice/singleItem.dart';

class CategoryItems extends StatefulWidget {
  final category;
  CategoryItems(this.category);

  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  var dataToSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Half Price"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Datasearch(dataToSearch, "categoryItems"),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                top: 75.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.grey[200]),
                    height: MediaQuery.of(context).size.height - 100.0,
                    width: MediaQuery.of(context).size.width),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: Hero(
                        tag: widget.category.name,
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.category.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.category.name,
                    style: TextStyle(
                      letterSpacing: 2.0,
                      fontFamily: 'Taviraj',
                      color: Theme.of(context).accentColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 180.0,
                left: 25.0,
                right: 25.0,
                bottom: 0.0,
                // child: getListView(category.name, category.refs),
                child: FutureBuilder<dynamic>(
                  future:
                      tempFunction(widget.category.name, widget.category.refs),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    dataToSearch = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Text(
                        'Please wait its loading...',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                        ),
                      ));
                    } else {
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  child: SingleItem(snapshot.data[index]),
                                ),
                                Positioned(
                                  right: 25.0,
                                  bottom: 10.0,
                                  child: IconButton(
                                    icon: snapshot.data[index]['isLiked']
                                        ? Icon(Icons.favorite)
                                        : Icon(Icons.favorite_border),
                                    iconSize: 45,
                                    color: Color.fromRGBO(166, 16, 16, 0.8),
                                    onPressed: () {
                                      writeContent(snapshot.data[index])
                                          .then((returnValue) {});
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  tempFunction(name, refs) async {
    var itemsArray, toSend = [];
    String cat = name.toString().toLowerCase();
    await Future.forEach(refs, (val) async {
      var data001;
      await val['ref'].get().then((document) {
        data001 = document.data;
        if (data001.containsKey(cat)) {
          itemsArray = data001['$cat'];
          itemsArray.forEach((item) {
            item.addAll({
              'itemName': data001['storeName'],
              'cate': '$cat',
              'isLiked': false
            });
          });
          toSend.addAll(itemsArray);
        }
      });
    });
    return toSend;
  }
}
