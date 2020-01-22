import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:flutter_app_virtual_market/screens/login_screen.dart';
import 'package:flutter_app_virtual_market/tabs/main_drawer_pages_enum.dart';
import 'package:flutter_app_virtual_market/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBackground() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBackground(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 32.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 140.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text('Pizza', style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold))
                    ),

                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<User>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Hello, ${model.isLoggedIn() ? model.userData['name'] : '' }', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                              GestureDetector(
                                child: Text(
                                  model.isLoggedIn() ? 'Sign Out' : 'Sign Ig or Register,',
                                  style: TextStyle(color: Theme.of(context).primaryColor ,fontSize: 16.0, fontWeight: FontWeight.bold)
                                ),
                                onTap: (){
                                 if (model.isLoggedIn()){
                                   model.signOut();
                                 }
                                 else {
                                   Navigator.of(context).push(
                                       MaterialPageRoute(builder: (context) => LoginScreen())
                                   );
                                 }
                                },
                              )
                            ],
                          );
                        }
                      )
                    )
                  ],
                ),
              ),

              Divider(),

              DrawerTile(Icons.home, 'Home', pageController, Page.HOME),
              DrawerTile(Icons.list, 'Menu', pageController, Page.MENU),
              DrawerTile(Icons.location_on, 'Locations', pageController, Page.LOCATIONS),
              DrawerTile(Icons.playlist_add_check, 'Orders', pageController, Page.ORDERS)

            ],
          )
        ],
      ),
    );
  }
}
