# CustomizedSearchBar

The CustomizedSearchBar is a highly customizable search bar widget for Flutter applications. It offers a variety of options to tailor the search bar's appearance and functionality to fit your specific needs. The widget includes customizable icons, colors, border features, and provides real-time search results filtering from a provided list.

## Developer

Elif Köser | info@technerd.dev

## Features

- **Voice Search Feature**: You can search by voice thanks to the microphone icon in the search bar. (1.0.0 version)
- **Real-Time Search Filtering:** Automatically filter a list of items based on the user's input. (0.0.6 version and after)
- **Clear Search Functionality:** Clear the search input with a suffix icon button. (0.0.6 version and after)
- **Customizable Hint Text:** Set a custom hint text for the search bar. (0.0.6 version and after)
- **Customizable Icons:** Add icons to the start and end of the search bar, with customizable size and color. (0.0.6 version and after)
- **Customizable Border Features:** Set the border features of the search bar. (0.0.6 version and after)

## Installation

1. Add the latest version of package to your pubspec.yaml (and run `dart pub get`):
```yaml
dependencies:
  customized_search_bar: ^1.0.0
```
2. Import the package and use it in your Flutter App.
```dart
import 'package:customized_search_bar/customized_search_bar.dart';
```

## Permissions Required

- If you use 0.0.6 version, you don't need add permissions.
- If you use 1.0.0 version, you need to add permissions for your Android and iOS applications before using this package. These permissions are for accessing your phone's microphone. Below, you will find where and how to add these permissions to your files.

### Android Permission

Steps:

1. Open `android/app/src/main/AndroidManifest.xml` file.

2. Add the following permission just below the `<manifest>` tag:
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

### iOS Permission

Steps:

1. Open `iOS/Runner/Info.plist` file.

2. Add the following permission just below the `<dict>` tag:
```xml
<key>NSMicrophoneUsageDescription</key>
<string>Permission to use the phone's microphone is required for the voice search feature of the search bar.</string>
```

## Usage Example
```dart
CustomizedSearchBar(
    hintText: 'Search for fruits...',
    speakHintText: "Speak to search",
    prefixIcon: Icons.search,
    suffixIcon: Icons.clear,
    voiceIcon: Icons.mic,
    prefixIconColor: Colors.blueAccent,
    suffixIconColor: Colors.red,
    voiceIconColor: Colors.pinkAccent,
    cursorColor: Colors.green,
    focusedBorderColor: Colors.deepPurpleAccent,
    prefixIconSize: 35.0,
    suffixIconSize: 35.0,
    voiceIconSize: 35.0,
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
      title: 'Customized Search Bar with Voice Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  final List<String> fruitList = [
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Pineapple',
    'Strawberry',
    'Watermelon'
  ];
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
              speakHintText: "Speak to search",
              prefixIcon: Icons.search,
              suffixIcon: Icons.clear,
              voiceIcon: Icons.mic,
              prefixIconColor: Colors.blueAccent,
              suffixIconColor: Colors.red,
              voiceIconColor: Colors.pinkAccent,
              cursorColor: Colors.green,
              focusedBorderColor: Colors.deepPurpleAccent,
              prefixIconSize: 35.0,
              suffixIconSize: 35.0,
              voiceIconSize: 35.0,
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

- `hintText` (`String`, required): The initial placeholder text displayed in the search bar.
- `speakHintText` (`String`, required): The placeholder text displayed when voice search is activated.
- `prefixIcon` (`IconData?`, optional): The icon displayed at the start (left side) of the search bar.
- `suffixIcon` (`IconData?`, optional): The icon displayed at the end (right side) of the search bar.
- `voiceIcon` (`IconData?`, optional): The icon used for the voice search button.
- `prefixIconColor` (`Color`, required): The color of the prefix icon.
- `suffixIconColor` (`Color`, required): The color of the suffix icon.
- `voiceIconColor` (`Color`, required): The color of the voice search icon.
- `focusedBorderColor` (`Color`, required): The border color of the search bar when it is focused.
- `cursorColor` (`Color`, required): The color of the cursor.
- `prefixIconSize` (`double`, required): The size of the prefix icon.
- `suffixIconSize` (`double`, required): The size of the suffix icon.
- `voiceIconSize` (`double`, required): The size of the voice search icon.
- `borderRadiusValue` (`double`, required): The corner radius of the search bar.
- `borderWidth` (`double`, required): The width of the search bar border.
- `searchList` (`List<String>`, required): The list of items to be searched.
- `onSearchResultChanged` (`ValueChanged<List<String>>`, required): The callback function triggered when the search results change.
- `searchController` (`TextEditingController`, required): The text controller for managing the search input.

## Example Video

1. If you use 0.0.6 version:
You can watch video on **https://youtube.com/shorts/EWt2hVrAg2k** if you want to see what the search bar looks like and how it works.
2. If you use 1.0.0 version:
You can watch video on **https://youtube.com/shorts/mYDT8RUpy9g** if you want to see what the search bar looks like and how it works.

## Contributing

If you would like to contribute, please send mail to **info@technerd.dev** mail adress. Contributions are welcome!
