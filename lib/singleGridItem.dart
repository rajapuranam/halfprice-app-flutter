import 'package:flutter/material.dart';

class SingleGridItem extends StatelessWidget {
  final name, logo;
  SingleGridItem(this.name, this.logo);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: name,
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(logo)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Text(
                  name,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20.0,
                    fontFamily: 'Raleway',
                    color: Color.fromRGBO(16, 89, 166, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
