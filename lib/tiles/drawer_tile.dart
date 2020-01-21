import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/tabs/main_drawer_pages_enum.dart';



class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final Page page;


  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page.index);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(icon, size: 32.0,
                  color: controller.page == page.index ?
                      Theme.of(context).primaryColor : Colors.black
              ),
              SizedBox(width: 32.0),
              Text(text, style: TextStyle(fontSize: 16.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
