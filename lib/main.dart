import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/cart_model.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:flutter_app_virtual_market/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel <User>(
      model: User(),
      child: ScopedModelDescendant<User>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: 'My Pizza',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: Color.fromARGB(255, 4, 125, 141)
                ),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              )
          );
        },
      )
    );
  }
}
