import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:flutter_app_virtual_market/screens/login_screen.dart';
import 'package:flutter_app_virtual_market/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if (User.of(context).isLoggedIn()){

      String userId = User.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('users').document(userId)
            .collection('orders').getDocuments(),

        builder: (context, snapshot){
          if (!snapshot.hasData){
            return Center(
                child: CircularProgressIndicator()
            );
          }

          else {

            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList().reversed.toList()
            );

          }
        },
      );

    }

    else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list,
                size: 80.0, color: Theme.of(context).primaryColor),

            SizedBox(height: 16.0),

            RaisedButton(
              child: Text('Login to see your orders', style: TextStyle(fontSize: 18.0)),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen())
                );
              },
            )
          ],
        ),
      );
    }
  }
}
