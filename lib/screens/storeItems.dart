import 'package:flutter/material.dart';
import 'package:halfprice/services/seachItems.dart';
import 'package:halfprice/services/storeData.dart';
import 'package:halfprice/singleItem.dart';

class StoreItems extends StatefulWidget {
  final store;

  StoreItems(this.store);

  @override
  _StoreItemsState createState() => _StoreItemsState();
}

class _StoreItemsState extends State<StoreItems> {
  
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Datasearch(forSearch, "storeItems"),
              );
            },
          ),
        ],
        title: Text("Half Price"),
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
                        tag: widget.store.storeName,
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.store.logo),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.store.storeName,
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
                child: getListView(widget.store.storeItems),
                // child: Text("store."),
              )
            ],
          ),
        ],
      ),
    );
  }
List<dynamic> forSearch;
  getListView(storeItems) {
    List<dynamic> toSend = List<dynamic>();
    storeItems.keys.forEach((key) {
      storeItems['$key'].forEach((item) {
        item['category'] = key;
        item['isLiked'] = false;
      });
      toSend.addAll(storeItems[key]);
    });
forSearch = toSend;
    return ListView.builder(
        itemCount: toSend.length,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Container(
                child: SingleItem(toSend[index]),
              ),
              Positioned(
                right: 25.0,
                bottom: 10.0,
                child: IconButton(
                  icon: toSend[index]['isLiked']
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  iconSize: 45,
                  color: Color.fromRGBO(166, 16, 16, 0.8),
                  onPressed: () {
                    writeContent(toSend[index]).then((returnValue) {});
                  },
                ),
              ),
            ],
          );
        });
  }
}
