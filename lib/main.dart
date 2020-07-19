import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:halfprice/notifier/categoryNotifier.dart';
import 'package:halfprice/notifier/specialDealsNotifier.dart';
import 'package:halfprice/notifier/storeNotifier.dart';
import 'package:halfprice/screens/categories.dart';
import 'package:halfprice/screens/home.dart';
import 'package:halfprice/screens/liked.dart';
import 'package:halfprice/screens/more.dart';
import 'package:halfprice/screens/stores.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:halfprice/services/storeData.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StoreNotifier()),
        ChangeNotifierProvider(create: (context) => CategoryNotifier()),
        ChangeNotifierProvider(create: (context) => SpecialDealsNotifier()),
      ],
      child: SplashScreenEffect(),
    ));


class SplashScreenEffect extends StatefulWidget {
  @override
  _SplashScreenEffectState createState() => _SplashScreenEffectState();
}

class _SplashScreenEffectState extends State<SplashScreenEffect> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      home: Scaffold(
        body: SplashScreen(
          title: Text(
            'Our app name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
              color: Color.fromRGBO(12, 18, 72, 1),
              fontFamily: 'Pacifico',
              letterSpacing: 2.0,
            ),
          ),
          seconds: 5,
          navigateAfterSeconds: MyApp(),
          image: Image.asset('images/logo.png'),
          backgroundColor: Colors.grey[200],
          photoSize: 80.0,
          loaderColor: Color.fromRGBO(12, 18, 72, 1),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  startFunction() async {
    final file = await localFile;
    Map<String, dynamic> map = Map<String, dynamic>();
    map['data'] = [];
    String rawJson = jsonEncode(map);
    file.writeAsString(rawJson);
  }

  @override
  Widget build(BuildContext context) {
    startFunction();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Half Price',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(16, 89, 166, 1),
        accentColor: Color.fromRGBO(16, 89, 166, 1),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  final _pageOptions = [Home(), Stores(), Categories(), Liked(), More()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   title: Text("Half Price"),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () {
      //         print("Search...");
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.notifications),
      //       onPressed: () {
      //         print("Notifications...");
      //       },
      //     ),
      //   ],
      // ),
      body: _pageOptions[currentPage],
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        height: 60,
        animationDuration: Duration(milliseconds: 400),
        animationCurve: Curves.easeInOut,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.store,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.category,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.menu,
            size: 25,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
