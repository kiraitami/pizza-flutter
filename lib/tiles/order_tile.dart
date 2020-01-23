import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection('orders').document(orderId).snapshots(),
          builder: (context, snapshot){
            if (!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator()
              );
            }

            else{

              int status = snapshot.data['status'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Order code: $orderId', style: TextStyle(fontWeight: FontWeight.bold)),

                  SizedBox(height: 4.0),

                  Text(_buildProductsText(snapshot.data)),

                  SizedBox(height: 4.0),

                  Text('Order status: $orderId', style: TextStyle(fontWeight: FontWeight.bold)),

                  SizedBox(height: 4.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle('1', 'Preparing', status, 1),
                      _buildLine(),
                      _buildCircle('2', 'Delivering', status, 2),
                      _buildLine(),
                      _buildCircle('3', 'Finished', status, 3),
                    ],
                  )

                ],
              );
            }

          },
        ),
      ),
    );
  }

  Widget _buildLine(){
    return Container(
      height: 1.0,
      width: 44.0,
      color: Colors.grey[500],
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot){
    String text = 'Description:\n';
    for (LinkedHashMap p in snapshot.data['products']){
      text += '${p['amount']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)}\n)';
    }
    text += 'Total: R\$${snapshot.data['totalPrice'].toStringAsFixed(2)}';

    return text;
  }

  Widget _buildCircle(String title, String subTitle, int status, int myStatus){
    Color backColor;
    Widget child;

    if (status < myStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    }

    else if (status == myStatus){
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
          )
        ],
      );
    }

    else{
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child
        ),
        Text(subTitle)
      ],
    );

  }
}
