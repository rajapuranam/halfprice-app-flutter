import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:halfprice/services/storeData.dart';
import 'package:halfprice/singleItem.dart';

class Liked extends StatefulWidget {
  @override
  _LikedState createState() => _LikedState();
}

class _LikedState extends State<Liked> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Half Price"),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
        
          //   },
          // ),
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
                  'liked items'.toUpperCase(),
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
            height: MediaQuery.of(context).size.height - 230.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 35),
              height: 50,
              child: FutureBuilder<dynamic>(
                future: readContent().then((contents) {
                  Map<String, dynamic> map = jsonDecode(contents);
                  List<dynamic> items = map["data"];
                  return items;
                }),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text(
                        'Please wait its loading...',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                        ),
                      ),
                    );
                  } else {
                    print("\n\nin else block...");
                    print(snapshot.data);
                    if (snapshot.hasError)
                      return Center(child: Text('Error: ${snapshot.error}'));
                    else if (snapshot.data == null || snapshot.data.length == 0 )
                      return Center(
                        child: Text(
                          'No liked items!!',
                          style: TextStyle(
                            fontFamily: "Taviraj",
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                          ),
                        ),
                      );
                    else {
                      return getListView(snapshot.data);
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  getListView(items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: SingleItem(items[index]),
            ),
            Positioned(
              right: 25.0,
              bottom: 10.0,
              child: IconButton(
                icon: Icon(Icons.favorite),
                iconSize: 45,
                color: Color.fromRGBO(166, 16, 16, 0.8),
                onPressed: () {
                  deleteContent(items[index]);
                  setState(() {});
                },
              ),
            ),
          ],
        );
      },
    );
  }
}