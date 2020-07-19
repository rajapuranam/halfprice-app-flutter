import 'package:flutter/material.dart';
import 'package:halfprice/notifier/specialDealsNotifier.dart';
import 'package:halfprice/screens/categoryItems.dart';
import 'package:halfprice/notifier/categoryNotifier.dart';
import 'package:halfprice/services/firestoreCRUD.dart';
import 'package:halfprice/services/storeData.dart';
import 'package:halfprice/singleItem.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String sale = '';
  @override
  void initState() {
    CategoryNotifier categoryNotifier =
        Provider.of<CategoryNotifier>(context, listen: false);
    getCatgeory(categoryNotifier);

    SpecialDealsNotifier specialDealsNotifier =
        Provider.of<SpecialDealsNotifier>(context, listen: false);

    getSpecialDeals(specialDealsNotifier).then((value) {
      setState(() {
        sale = value;
      });
    });

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
              // showSearch(context: context, delegate: Datasearch());
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                '$sale',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 22.0,
                  fontFamily: 'Taviraj',
                  fontWeight: FontWeight.bold,
                  // color: Color.fromRGBO(16, 89, 166, 1),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Center(
                child: Text(
                  'Top products..',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 22.0,
                    fontFamily: 'Taviraj',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Categories',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18.0,
                      fontFamily: 'Taviraj',
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * 0.19,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryNotifier.categoryList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    child: InkWell(
                      splashColor: Colors.blueAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryItems(
                                categoryNotifier.categoryList[index]),
                          ),
                        );
                        // print("Categories tapped...$index");
                      },
                      child: Column(
                        children: <Widget>[
                          Hero(
                            tag: categoryNotifier.categoryList[index].name,
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(categoryNotifier
                                      .categoryList[index].image),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              categoryNotifier.categoryList[index].name,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 16.0,
                                fontFamily: 'Taviraj',
                                color: Color.fromRGBO(16, 89, 166, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Special Deals',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18.0,
                      fontFamily: 'Taviraj',
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: SpecialDealsWidget(),
              // child: Text('Helo'),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialDealsWidget extends StatefulWidget {
  @override
  _SpecialDealsWidgetState createState() => _SpecialDealsWidgetState();
}

class _SpecialDealsWidgetState extends State<SpecialDealsWidget> {
  @override
  Widget build(BuildContext context) {
    var data = [];
    SpecialDealsNotifier specialDealsNotifier =
        Provider.of<SpecialDealsNotifier>(context, listen: false);

    var sd = specialDealsNotifier.specialdealsList;
    sd.forEach((val) {
      val.sd.forEach((element) {
        element['storeName'] = val.storeName;
        element['isLiked'] = false;
      });
      data.addAll(val.sd);
    });

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: SingleItem(data[index]),
              ),
              Positioned(
                right: 25.0,
                bottom: 10.0,
                child: IconButton(
                  icon: data[index]['isLiked']
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  iconSize: 45,
                  color: Color.fromRGBO(166, 16, 16, 0.8),
                  onPressed: () {
                    data[index]['isLiked'] = !data[index]['isLiked'];

                    writeContent(data[index]).then((returnValue) {});
                  },
                ),
              ),
            ],
          );
        });
  }
}

