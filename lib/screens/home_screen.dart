import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/tabs/home_tab.dart';
import 'package:flutter_app_virtual_market/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Container(color: Colors.blue),
        Container(color: Colors.green),
        Container(color: Colors.blueGrey),
      ],
    );
  }
}
