import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_virtual_market/datas/cart_product.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  User user;

  List<CartProduct> productList = [];

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user){
    if (user.isLoggedIn()){
      _loadCartItems();
    }
  }

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

  void incrementProductInCart(CartProduct cartProduct){
    cartProduct.amount ++;
    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart')
        .document(cartProduct.cart_id).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void decrementProductInCart(CartProduct cartProduct){
    cartProduct.amount --;
    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart')
        .document(cartProduct.cart_id).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async{
    QuerySnapshot query = await Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart')
        .getDocuments();
    
    productList = query.documents.map(
            (document)=> CartProduct.fromDocument(document)
    ).toList();

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductPrice(){
    double price = 0.0;

    for (CartProduct c in productList){
      if (c.productData != null){
        price += c.amount * c.productData.price;
      }
    }

    return price;
  }

  double getDiscount(){
    return getProductPrice() * discountPercentage /100;
  }

  void updatePrices(){
    notifyListeners();
  }
  
  Future<String> finishOrder() async {
    if (productList.isEmpty) return null;
    
    notifyListeners();
    
    double orderPrice = getProductPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await
    Firestore.instance.collection('orders').add({
      'clientId': user.firebaseUser.uid,
      'products': productList.map((cartProduct)=>cartProduct.toMap()).toList(),
      'orderPrice': orderPrice,
      'discount': discount,
      'totalPrice': orderPrice - discount,
      'status': 1
    });

    await Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('orders').document(refOrder.documentID).setData({
      'orderId': refOrder.documentID
    });

    QuerySnapshot query = await Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('cart').getDocuments();

    for (DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    productList.clear();
    couponCode = null;
    discountPercentage = 0;
    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }

}