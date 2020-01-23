import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Finished')
      ),

      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80.0
            ),

            Text('Order finished successfully!', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),

            Text('Order code: ${orderId}', style: TextStyle(fontSize: 16.0))
          ],
        ),
      ),
    );
  }
}
