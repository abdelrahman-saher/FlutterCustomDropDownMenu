import 'package:customdropdownmenu/customdropdownmenu.dart';
import 'package:customdropdownmenu/model/Country.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Map<String, String> selectedCountryEn, selectedCountryar;
  bool error = false;
  bool error1 = false;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> countries_en = [
      Country(id: "12", name: "Brazil").toDropDownItems(),
      Country(id: "13", name: "Algeria").toDropDownItems(),
      Country(id: "14", name: "Australia").toDropDownItems(),
      Country(id: "15", name: "Denmark").toDropDownItems(),
      Country(id: "16", name: "Egypt").toDropDownItems(),
    ];
    List<Map<String, dynamic>> countries_ar = [
      Country(id: "12", name: "البرازيل").toDropDownItems(),
      Country(id: "13", name: "الجزائر").toDropDownItems(),
      Country(id: "14", name: "استراليا").toDropDownItems(),
      Country(id: "15", name: "الدنمارك").toDropDownItems(),
      Country(id: "16", name: "مصر").toDropDownItems(),
    ];
    return MaterialApp(
      title: 'Custom DropDownMenu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              CustomDropDown(
                titleSize: 15,
                errorMessageSize: 15,
                withoutHeader: false,
                bgColor: Colors.blue.shade400,
                borderColor: Colors.blueGrey,
                direction: Direction.Left,
                dividerColor: Colors.white,
                error: error,
                errorMessage: "required",
                headerColor: Colors.blue,
                headerIcon: Icons.location_searching,
                hintText: "Country",
                iconColor: Colors.white,
                textColor: Colors.white,
                title: "Country",
                withBorder: true,
                items: countries_en,
                onSelected: (Map<String, dynamic> selectedItem) {
                  print(selectedItem);
                  setState(() {
                    selectedCountryEn = selectedItem;
                  });
                },
                borderRadius: 5,
                itemsTextSize: 30,
                iconSize: 20,
                headerIconColor: Colors.blue,
              ),
              SizedBox(
                height: 200,
              ),
              CustomDropDown(
                titleSize: 20,
                errorMessageSize: 20,
                withoutHeader: false,
                bgColor: Colors.blue.shade400,
                borderColor: Colors.blueGrey,
                direction: Direction.Right,
                dividerColor: Colors.white,
                error: error1,
                errorMessage: "برجاء اختيار الدولة",
                headerColor: Colors.blue,
                headerIcon: Icons.location_searching,
                hintText: "الدولة",
                iconColor: Colors.white,
                textColor: Colors.white,
                title: "الدول",
                withBorder: true,
                items: countries_ar,
                onSelected: (Map<String, dynamic> selectedItem) {
                  print(selectedItem);
                  selectedCountryar = selectedItem;
                },
                borderRadius: 5,
                itemsTextSize: 20,
                iconSize: 25,
                headerIconColor: Colors.blue,
                borderWidth: 2,
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text("next"),
                onPressed: () {
                  if (selectedCountryar == null) {
                    setState(() {
                      error1 = true;
                    });
                  } else {
                    setState(() {
                      error1 = false;
                    });
                    print(selectedCountryar);
                  }
                  if (selectedCountryEn == null) {
                    setState(() {
                      error = true;
                    });
                  } else {
                    setState(() {
                      error = false;
                    });
                    print(selectedCountryEn);
                  }
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}
