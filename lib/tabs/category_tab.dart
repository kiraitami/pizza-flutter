import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/tiles/category_tile.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('products').getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator()
          );
        }
        else {
          return ListView(
            children: snapshot.data.documents.map(
                (doc){
                  return CategoryTile(doc);
                }
            ).toList()
          );
        }
      },
    );
  }
}
