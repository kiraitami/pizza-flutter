import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text('Discount Card', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700])),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type your Discount Card code'
              ),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text){
                Firestore.instance.collection('coupons').document(text).get().then(
                    (docSnapshot){
                      if (docSnapshot.data != null){
                        CartModel.of(context).setCoupon(text, docSnapshot.data['percent']);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${docSnapshot.data['percent']}% OFF Aplied!'),
                            backgroundColor: Theme.of(context).primaryColor
                          )
                        );
                      }
                      else {
                        CartModel.of(context).setCoupon(null, 0);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Invalid Discount Card...'),
                                backgroundColor: Colors.redAccent
                            )
                        );
                      }
                    }
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
