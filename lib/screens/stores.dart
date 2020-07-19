import 'package:flutter/material.dart';
import 'package:halfprice/notifier/storeNotifier.dart';
import 'package:halfprice/screens/storeItems.dart';
import 'package:halfprice/services/firestoreCRUD.dart';
import 'package:halfprice/services/seachItems.dart';
import 'package:halfprice/singleGridItem.dart';
import 'package:provider/provider.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
 
  @override
  void initState() {
    StoreNotifier storeNotifier =
        Provider.of<StoreNotifier>(context, listen: false);
    getStores(storeNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StoreNotifier storeNotifier = Provider.of<StoreNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Half Price"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Datasearch(storeNotifier.storeList, "store"));
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
                  'stores'.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 2.5,
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
                itemCount: storeNotifier.storeList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreItems(storeNotifier.storeList[index]),
                          ),
                        );
                      },
                      child: SingleGridItem(
                        storeNotifier.storeList[index].storeName,
                        storeNotifier.storeList[index].logo,
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
