import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/tabs/category_tab.dart';
import 'package:flutter_app_virtual_market/tabs/home_tab.dart';
import 'package:flutter_app_virtual_market/tabs/oders_tab.dart';
import 'package:flutter_app_virtual_market/widgets/cart_button.dart';
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
          floatingActionButton: CartButton(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text('Categories'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoryTab(),
          floatingActionButton: CartButton(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text('My Orders'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: OrdersTab()
        ),

        Scaffold(
            appBar: AppBar(
              title: Text('Call'),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            //body: OrdersTab()
        )

      ],
    );
  }
}
