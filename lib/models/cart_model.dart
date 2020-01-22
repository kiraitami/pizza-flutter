import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_virtual_market/datas/cart_product.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  User user;

  List<CartProduct> productList = [];

  CartModel(this.user);

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct){
    productList.add(cartProduct);
    Firestore.instance.collection('users').document(user.firebaseUser.uid)
    .collection('cart').add(cartProduct.toMap()).then((doc){
      cartProduct.cart_id = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('cart').document(cartProduct.cart_id).delete();
    productList.remove(cartProduct);

    notifyListeners();
  }

}