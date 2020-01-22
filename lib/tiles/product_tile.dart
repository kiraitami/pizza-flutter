import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/datas/product_data.dart';
import 'package:flutter_app_virtual_market/screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(product) ));
      },

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
            
        Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
                height: 200.0
              ),
            ),
            
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(product.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w500)),

                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text('R\$ ${product.price.toStringAsFixed(2)}',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold))
                    ),

                    Text(product.description,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w300), maxLines: 7)
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
