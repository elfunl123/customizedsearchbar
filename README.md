# CustomizedSearchBar

The CustomizedSearchBar is a highly customizable search bar widget for Flutter applications. It offers a variety of options to tailor the search bar's appearance and functionality to fit your specific needs. The widget includes customizable icons, colors, border features, and provides real-time search results filtering from a provided list.

## Developer

Elif Köser | info@technerd.dev

## Features

- **Real-Time Search Filtering:** Automatically filter a list of items based on the user's input.
- **Clear Search Functionality:** Clear the search input with a suffix icon button.
- **Customizable Hint Text:** Set a custom hint text for the search bar.
- **Prefix and Suffix Icons:** Add icons to the start and end of the search bar, with customizable size and color.
- **Customizable Border Features:** Set the border features of the search bar.

## Installation

1. Add the latest version of package to your pubspec.yaml (and run `dart pub get`):
```yaml
dependencies:
  customized_search_bar: ^0.0.2
```
2.Import the package and use it in your Flutter App.
```dart
import 'package:customized_search_bar/customized_search_bar.dart';
```

## Usage Example
```dart
CustomizedSearchBar(
      hintText: 'Search for fruits...',
      prefixIcon: Icons.search,
      suffixIcon: Icons.clear,
      prefixIconColor: Colors.blueAccent,
      suffixIconColor: Colors.red,
      cursorColor: Colors.green,
      focusedBorderColor: Colors.deepPurpleAccent,
      prefixIconSize: 35.0,
      suffixIconSize: 35.0,
      borderRadiusValue: 30.0,
      borderWidth: 3.0,
      searchList: fruitList,
      onSearchResultChanged: updateSearchResults,
      searchController: searchController,
),
```

## Usage Example in Screen
```dart
import 'package:flutter/material.dart';
import 'package:customized_search_bar/customized_search_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customized Search Bar Example',
      home: SearchBarDemo(),
    );
  }
}

class SearchBarDemo extends StatefulWidget {
  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  final TextEditingController searchController = TextEditingController();
  final List<String> fruitList = ['Apple', 'Banana', 'Orange', 'Grape', 'Pineapple', 'Strawberry', 'Watermelon'];
  List<String> displayedFruits = [];

  @override
  void initState() {
    super.initState();
    displayedFruits = fruitList;
  }

  void updateSearchResults(List<String> results) {
    setState(() {
      displayedFruits = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customized Search Bar Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomizedSearchBar(
              hintText: 'Search for fruits...',
              prefixIcon: Icons.search,
              suffixIcon: Icons.clear,
              prefixIconColor: Colors.blueAccent,
              suffixIconColor: Colors.red,
              cursorColor: Colors.green,
              focusedBorderColor: Colors.deepPurpleAccent,
              prefixIconSize: 35.0,
              suffixIconSize: 35.0,
              borderRadiusValue: 30.0,
              borderWidth: 3.0,
              searchList: fruitList,
              onSearchResultChanged: updateSearchResults,
              searchController: searchController,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedFruits.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(displayedFruits[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Parameters

- `hintText`: The hint text to display inside the search bar.
- `prefixIcon`: The icon to display at the beginning of the search bar.
- `suffixIcon`: The icon to display at the end of the search bar, used to clear the search input.
- `prefixIconColor`: The color of the prefix icon.
- `suffixIconColor`: The color of the suffix icon.
- `focusedBorderColor`: The color of the border when the search bar is focused.
- `cursorColor`: The color of the cursor inside the search bar.
- `prefixIconSize`: The size of the prefix icon.
- `suffixIconSize`: The size of the suffix icon.
- `borderRadiusValue`: The border radius of the search bar.
- `borderWidth`: The width of the border when the search bar is focused.
- `searchList`: The list of items to search from.
- `onSearchResultChanged`: The callback function to handle changes in search results.
- `searchController`: The controller to manage the search input.

## Example Video

You can watch video on **https://youtube.com/shorts/EWt2hVrAg2k?feature=share** if you want to to see what the search bar looks like and how it works.

## Contributing

If you would like to contribute, please send mail to **info@technerd.dev** mail adress. Contributions are welcome!
