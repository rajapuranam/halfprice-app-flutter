import 'package:flutter/material.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height - 160.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 35, bottom: 50, left: 16),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    'Half Price',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Taviraj',
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.mail,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Contact Us',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18.0,
                                  fontFamily: 'Taviraj',
                                  color: Colors.white,
                                  // color: Color.fromRGBO(16, 89, 166, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'About Us',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18.0,
                                  fontFamily: 'Taviraj',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18.0,
                                  fontFamily: 'Taviraj',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Privacy policy',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18.0,
                                  fontFamily: 'Taviraj',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
