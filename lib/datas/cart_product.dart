import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_virtual_market/datas/product_data.dart';

class CartProduct {

  String cart_id;
  String product_id;
  String category;
  int amount;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){
    cart_id = document.documentID;
    category = document.data['category'];
    product_id = document.data['product_id'];
    amount = document.data['amount'];
    size = document.data['size'];
  }

  Map<String, dynamic> toMap(){
    return {
      'category' : category,
      'product_id' : product_id,
      'amount' : amount,
      'size' : size,
      'product' : productData.toResumedMap()
    };
  }

}