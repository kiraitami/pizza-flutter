import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/datas/cart_product.dart';
import 'package:flutter_app_virtual_market/datas/product_data.dart';
import 'package:flutter_app_virtual_market/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    CartModel.of(context).updatePrices();

    Widget _buildContent(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120.0,
            child: Image.network(cartProduct.productData.images[0], fit: BoxFit.cover),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[

                  Text(cartProduct.productData.title,
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)
                  ),

                  SizedBox(height: 12.0),

                  Text('Size: ${cartProduct.size}',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),

                  SizedBox(height: 12.0),

                  Text('R\$ ${cartProduct.productData.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),

                  SizedBox(height: 12.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: cartProduct.amount > 1 ? (){
                          CartModel.of(context).decrementProductInCart(cartProduct);
                        } : null
                      ),

                      Text(cartProduct.amount.toString()),

                      IconButton(
                          icon: Icon(Icons.add),
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            CartModel.of(context).incrementProductInCart(cartProduct);
                          }
                      ),

                      FlatButton(
                        child: Text('Remove'),
                        textColor: Colors.grey[500],
                        onPressed: (){
                          CartModel.of(context).removeCartItem(cartProduct);
                        }
                      )

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null ?
      FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("products").document(cartProduct.category)
              .collection("items").document(cartProduct.product_id).get(),

        builder: (context, snapshot){

          if (snapshot.hasData){
            cartProduct.productData = ProductData.fromDocument(snapshot.data);
            return _buildContent();
          }
          else {
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center
            );
          }
        }
      ) : _buildContent(),
    );
  }
}
