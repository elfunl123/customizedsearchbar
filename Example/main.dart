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