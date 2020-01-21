import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/datas/product_data.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: type == 'grid' ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(product.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w500)),

                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('R\$ ${product.price.toStringAsFixed(2)}',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
        :
        Row(),
      ),
    );
  }
}
