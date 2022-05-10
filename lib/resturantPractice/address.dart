import 'package:demo/provider/address_Provider.dart';
import 'package:demo/widget/change_theme_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class address extends StatefulWidget {
  const address({Key? key}) : super(key: key);

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> {
  @override
  Widget build(BuildContext context) {
    final locationservices_provider = Provider.of<cartprovider>(context);
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
                "Please enter your location to allow acess",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  locationservices_provider.currentlocation(context);
                },
                child: Container(
                    color: Colors.red,
                    height: 50,
                    width: 200,
                    child: Center(child: Text("User Current Location"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
