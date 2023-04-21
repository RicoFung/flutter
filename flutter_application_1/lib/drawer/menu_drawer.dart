import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/menu_item.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  Future<List<MenuItem>> _getMenuItems() async {
    final jsonString = await rootBundle.loadString('assets/menu.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    List<MenuItem> menuItems = jsonData
        .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
        .toList();

    return menuItems;
  }

  List<Widget> _buildMenu(List<MenuItem> items) {
    return items
        .map((item) => ExpansionTile(
              leading: Icon(Icons.dashboard),
              title: Text(item.title),
              children: item.children != null
                  ? _buildMenu(item.children!).toList()
                  : [],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<List<MenuItem>>(
        future: _getMenuItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final menuItems = snapshot.data!;
              final menuList = _buildMenu(menuItems);
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      'Flutter Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  ...menuList,
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
