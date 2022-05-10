import 'dart:convert';

import 'package:demo/main.dart';
import 'package:demo/model/model.dart';
import 'package:demo/provider/theme_provider.dart';
import 'package:demo/widget/change_theme_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class practice2 extends StatelessWidget {
  List<practice> practiceList = [];
  Future<List<practice>> getPhotos() async {
    final response =
        await http.get(Uri.parse('https://api.publicapis.org/entries'));
    var data = jsonDecode(response.body.toString());
    var z = data["entries"];
    //  print(z);
    if (response.statusCode == 200) {
      for (Map i in z) {
        practice Practice =
            practice(Category: i['Category'], Description: i['Description']);
        practiceList.add(Practice);
      }
      return practiceList;
    } else {
      return practiceList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(MyApp.title),
          actions: [
            ChangeThemeButtonWidget(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getPhotos(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<practice>> snapshot) {
                    return ListView.builder(
                        itemCount: practiceList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title:
                                Text(snapshot.data![index].Category.toString()),
                            subtitle: Text(
                                snapshot.data![index].Description.toString()),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ));
  }
}
