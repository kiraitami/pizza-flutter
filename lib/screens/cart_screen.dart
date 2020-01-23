import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/cart_model.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:flutter_app_virtual_market/screens/login_screen.dart';
import 'package:flutter_app_virtual_market/screens/order_screen.dart';
import 'package:flutter_app_virtual_market/tiles/cart_tile.dart';
import 'package:flutter_app_virtual_market/widgets/cart_price.dart';
import 'package:flutter_app_virtual_market/widgets/discount_card.dart';
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
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          if(model.isLoading && User.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator()
            );
          }

          else if (!User.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart,
                  size: 80.0, color: Theme.of(context).primaryColor),

                  SizedBox(height: 16.0),

                  RaisedButton(
                    child: Text('Login to add order', style: TextStyle(fontSize: 18.0)),
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

          else if ( model.productList == null || model.productList.isEmpty ){
            return Center(
              child: Text('Cart is Empty',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            );
          }

          else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.productList.map((product){
                    return CartTile(product);
                  }).toList(),
                ),

                DiscountCard(),

                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  if (orderId != null){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>OrderScreen(orderId))
                    );
                  }
                })
              ],
            );
          }
        }
      )
    );
  }
}
