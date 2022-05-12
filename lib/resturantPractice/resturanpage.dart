import 'dart:convert';

import 'package:demo/model/model.dart';
import 'package:demo/widget/change_theme_button_widget.dart';
import 'package:demo/widget/inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class resturantpage extends StatefulWidget {
  final finalToken;
  final latitude;
  final longtitude;

  resturantpage({Key? key, this.finalToken, this.latitude, this.longtitude})
      : super(key: key);

  @override
  State<resturantpage> createState() => _resturantpageState();
}

class _resturantpageState extends State<resturantpage> {
  @override
  Widget build(BuildContext context) {
    final passed_data = InheritedDataProvider.of(context)!.data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("API Practice"),
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              // print(widget.latitude);
              // print(widget.longtitude);
              // print(widget.finalToken);
              getResturant();
            },
            child: Text(
              "Our address is",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Center(
            child: Text(
              "$passed_data",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Future getResturant() async {
    var userHeader = {
      "Accept": "application/json",
      'Authorization': 'Bearer $widget.finalToken',
    };
    final response = await http.get(
      Uri.parse(
          'https://dnpprojects.com/demo/comshop/api/getRestuarant/${widget.latitude}/${widget.longtitude}'),
      headers: userHeader,
    );
    var data = jsonDecode(response.body);
    print(data);
    response.headers.addAll(userHeader);
    var z = data["data"];
    print(z);
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {}
  }
}
