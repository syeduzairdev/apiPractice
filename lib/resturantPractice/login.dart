import 'package:demo/provider/theme_provider.dart';
import 'package:demo/resturantPractice/address.dart';
import 'package:demo/widget/change_theme_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool visible = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("API Practice"),
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                "LOGIN",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email Address',
                ),
                controller: _email,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                controller: _password,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  _login();
                },
                child: Container(
                  color: Colors.red,
                  height: 50,
                  width: 100,
                  child: Center(child: Text("Login")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _login() async {
    final MultipartRequest = new http.MultipartRequest(
        "POST", Uri.parse("https://dnpprojects.com/demo/comshop/api/login"));
    MultipartRequest.fields.addAll({
      "email": _email.text,
      "password": _password.text,
    });
    http.StreamedResponse response = await MultipartRequest.send();
    var resposeString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => address()));
    } else {
      return CircularProgressIndicator();
    }

    print(response.statusCode);
    print(resposeString);
    print(response);
  }
}
