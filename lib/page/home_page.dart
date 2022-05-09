import 'dart:convert';

import 'package:demo/main.dart';
import 'package:demo/model/model.dart';
import 'package:demo/provider/theme_provider.dart';
import 'package:demo/widget/change_theme_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  List<photos> photosList = [];
  Future<List<photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photos photo = photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photo);
      }
      return photosList;
    } else {
      return photosList;
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
                      AsyncSnapshot<List<photos>> snapshot) {
                    return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].url.toString()),
                            ),
                            title: Text(snapshot.data![index].id.toString()),
                            subtitle:
                                Text(snapshot.data![index].title.toString()),
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
