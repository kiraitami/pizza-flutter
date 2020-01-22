import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/datas/product_data.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;
  String desiredSize;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title)
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 14.0,
              dotBgColor: Colors.transparent,
              dotColor: Colors.white,
              autoplay: true,
              autoplayDuration: Duration(seconds: 2)
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(product.title,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500), maxLines: 3),

                Text('R\$ ${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: primaryColor)),

                SizedBox(height: 16.0),

                Text('Size', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    children: product.sizes.map(
                        (string){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                desiredSize = string;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                    color: string == desiredSize ? primaryColor : Colors.grey[500],
                                    width: 3
                                )
                              ),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(string),
                            )
                          );
                        }
                    ).toList(),
                  ),
                ),

                SizedBox(height: 16.0),

                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: desiredSize != null ? (){

                    } : null,
                    child: Text('I want this', style: TextStyle(fontSize: 18.0)),
                    textColor: Colors.white,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: 16.0),

                Text('Description',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

                Text(product.description, style: TextStyle(fontSize: 16.0))

              ],
            ),
          )

        ],
      ),
    );
  }
}

