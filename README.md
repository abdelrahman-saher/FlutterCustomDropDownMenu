# customdropdownmenu

Use this package if you need more customization with DropDownMenu.

# Quick reference 
Since customization requires a lot of properties, here is a quick cheatsheet:

| Property | what does it do |
|----------|-----------------|
|withoutHeader|Determine if you want a header above the drop down button or not|
|title|the title displayed in the header|
|titlesize|the text size of the title|
|headerIcon|the Icon displayed next to the title in the header|
|headerIconColor|the color of the icon|
|iconSize|the size of the icon in the header|
|headerColor|the color of the title|
|error|boolean variable which you can use in validation "if true ==> show error message else ==> hide th message"|
|errorMessage|the error message which is displayed to the user when error is true|
|errorMessageSize|the text size of error message|
|hintText|the initial text value in the Drop down button|
|items|list of items to display in the menu|
|onSelected|A callback that registers the selected item|
|selectedItem|if you want to initialize the menu with specific item|
|iconColor|the color of the arrow icon|
|bgColor|the color of the background|
|textColor|the color of the text inside the menu|
|dividerColor|the color of dividers between items|
|withBorder|determine if you want a border around the menu|
|borderColor|the color of the border|
|direction|determine the directon of the DropDownMenu "Direction.RTL,Direction.LTR"|
|borderRadius|the radius of all corners|
|itemsTextSize|the text size of the items and hint|
|borderWidth|the width of the border (by default = 1)|

## How to use
Simply create a CustomDropDown widget, and pass the required params:
hint : items is a list of maps ({"name": the name of the item,"value":the id of the item})
let's first initialize the error variable and the selected item
```dart
bool error = false;
Map<String,String> _selectedItem;
```
1) for LTR direction

1.1- create your list of items 
```dart
List<Map<String, dynamic>> countries = [
      {"value": "12", name: "Brazil"},
      {"value": "12", name: "Algeria"},
      {"value": "12", name: "Australia"},
      {"value": "12", name: "Denmark"},
      {"value": "12", name: "Egypt"},
    ];
```
1.2- create CustomDropDown widget
```dart
CustomDropDown(
                titleSize: 15,
                errorMessageSize: 15,
                withoutHeader: false,
                bgColor: Colors.blue.shade400,
                borderColor: Colors.blueGrey,
                direction: Direction.LTR,
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
                items: countries,
                onSelected: (Map<String, dynamic> selectedItem) {
                  print(selectedItem);
                  setState(() {
                    _selectedItem = selectedItem;
                  });
                },
                borderRadius: 5,
                itemsTextSize: 30,
                iconSize: 20,
                headerIconColor: Colors.blue,
              ),
```

2) for RTL direction

2.1 - create your list of items 
```dart
List<Map<String, dynamic>> countries = [
      {"value": "12", name: "البرازيل"},
      {"value": "12", name: "الجزائر"},
      {"value": "12", name: "استراليا"},
      {"value": "12", name: "الدنمارك"},
      {"value": "12", name: "مصر"},
    ];
```
2.2- create CustomDropDown widget
```dart
CustomDropDown(
                titleSize: 20,
                errorMessageSize: 20,
                withoutHeader: false,
                bgColor: Colors.blue.shade400,
                borderColor: Colors.blueGrey,
                direction: Direction.RTL,
                dividerColor: Colors.white,
                error: error,
                errorMessage: "برجاء اختيار الدولة",
                headerColor: Colors.blue,
                headerIcon: Icons.location_searching,
                hintText: "الدولة",
                iconColor: Colors.white,
                textColor: Colors.white,
                title: "الدول",
                withBorder: true,
                items: countries,
                onSelected: (Map<String, dynamic> selectedItem) {
                  print(selectedItem);
                  _selectedItem = selectedItem;
                },
                borderRadius: 5,
                itemsTextSize: 20,
                iconSize: 25,
                headerIconColor: Colors.blue,
                borderWidth: 1,
              ),
```
finally you can do validation when some button is pressed 
```dart
RaisedButton(
                child: Text("validate"),
                onPressed: () {
                  if (_selectedItem == null) {
                    setState(() {
                      error = true;
                    });
                  } else {
                    setState(() {
                      error = false;
                    });
                  }
                },
              )
```

## Example


<img src="https://i.imgur.com/hTNWNbW.gif" width="250" height="400" />

