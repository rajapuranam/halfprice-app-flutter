import 'package:flutter/material.dart';

class SingleItem extends StatefulWidget {
  final item;
  

  SingleItem(this.item);

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {


  @override
  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(widget.item['image']),
                      width: 80.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 12),
                  child: Text(
                    "${widget.item['quantity']}",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 14.0,
                      fontFamily: 'Taviraj',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, bottom: 8, top: 15, right: 8),
                    child: Text(
                      widget.item['name'],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Taviraj',
                        color: Theme.of(context).primaryColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 8),
                        child: Text(
                          '\$${widget.item['price']}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Taviraj',
                            color: Color.fromRGBO(166, 16, 16, 1),
                            height: 1.2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 8),
                        child: Text(
                          '${widget.item['oldPrice']}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16.0,
                            fontFamily: 'Taviraj',
                            color: Theme.of(context).primaryColor,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 12),
                    child: Text(
                      widget.item['category'] != null
                          ? "${widget.item['category']}"
                          : (widget.item['itemName'] != null
                              ? "${widget.item['itemName']}"
                              : "${widget.item['storeName']}"),
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16.0,
                        fontFamily: 'Taviraj',
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
