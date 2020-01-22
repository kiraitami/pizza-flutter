import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int amount = model.productList.length;
                return Text('${amount ?? 0} ${amount > 1 ? 'ITEMS' : 'ITEM'}',
                style: TextStyle(fontSize: 17.0));
              },
            ),
          )
        ],
      ),
    );
  }
}
