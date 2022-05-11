import 'package:demo/widget/change_theme_button_widget.dart';
import 'package:demo/widget/inherit_widget.dart';
import 'package:flutter/material.dart';

class resturantpage extends StatefulWidget {
  final finalToken;
  const resturantpage({Key? key, this.finalToken}) : super(key: key);

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
          Text(
            "Our address is",
            style: TextStyle(fontSize: 20),
          ),
          Center(
            child: Text(
              "$passed_data",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
