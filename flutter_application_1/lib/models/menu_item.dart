import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class MenuItem {
  final String title;
  final String icon;
  final List<MenuItem>? children;

  MenuItem(this.title, this.icon, {this.children});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      json['title'] as String,
      json['icon'] as String,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

Future<List<MenuItem>> getMenuItems() async {
  final jsonString = await rootBundle.loadString('assets/menu.json');
  final jsonData = json.decode(jsonString) as List<dynamic>;
  return jsonData
      .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
      .toList();
}
