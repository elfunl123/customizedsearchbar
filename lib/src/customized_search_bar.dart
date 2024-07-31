import 'package:flutter/material.dart';

/// A customizable search bar component.
///
/// This component provides a customizable search bar for users to perform searches.
/// Various visual and functional features can be set via parameters.
class CustomizedSearchBar extends StatefulWidget {
  /// Hint text displayed in the search bar.
  final String hintText;

  /// Icon displayed at the beginning of the search bar.
  final IconData prefixIcon;

  /// Icon displayed at the end of the search bar.
  final IconData suffixIcon;

  /// Color of the prefix icon.
  final Color prefixIconColor;

  /// Color of the suffix icon.
  final Color suffixIconColor;

  /// Border color when the search bar is focused.
  final Color focusedBorderColor;

  /// Color of the cursor.
  final Color cursorColor;

  /// Size of the prefix icon.
  final double prefixIconSize;

  /// Size of the suffix icon.
  final double suffixIconSize;

  /// Border radius value.
  final double borderRadiusValue;

  /// Border width.
  final double borderWidth;

  /// List of items to search through.
  final List<String> searchList;

  /// Callback function when search results change.
  final ValueChanged<List<String>> onSearchResultChanged;

  /// Text controller for the search bar.
  final TextEditingController searchController;

  /// Creates a new [CustomizedSearchBar] component.
  CustomizedSearchBar({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.prefixIconColor,
    required this.suffixIconColor,
    required this.focusedBorderColor,
    required this.cursorColor,
    required this.prefixIconSize,
    required this.suffixIconSize,
    required this.borderRadiusValue,
    required this.borderWidth,
    required this.searchList,
    required this.onSearchResultChanged,
    required this.searchController,
  }) : super(key: key);

  @override
  State<CustomizedSearchBar> createState() => _CustomizedSearchBarState();
}

class _CustomizedSearchBarState extends State<CustomizedSearchBar> {
  FocusNode _focusNode = FocusNode();
  late Color _borderColor;

  @override
  void initState() {
    super.initState();
    _borderColor = Colors.grey;
    _focusNode.addListener(() {
      setState(() {
        _borderColor =
            _focusNode.hasFocus ? widget.focusedBorderColor : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      cursorColor: widget.cursorColor,
      controller: widget.searchController,
      onChanged: (value) {
        List<String> results = widget.searchList
            .where((element) =>
                element.toLowerCase().contains(value.toLowerCase()))
            .toList();
        widget.onSearchResultChanged(results);
      },
      decoration: InputDecoration(
        prefixIconColor: widget.prefixIconColor,
        suffixIconColor: widget.suffixIconColor,
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIcon,
          size: widget.prefixIconSize,
        ),
        suffixIcon: widget.searchController.text.isEmpty
            ? null
            : InkWell(
                onTap: () {
                  widget.searchController.clear();
                  widget.onSearchResultChanged(widget.searchList);
                },
                child: Icon(
                  widget.suffixIcon,
                  size: widget.suffixIconSize,
                ),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadiusValue),
          ),
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadiusValue),
          ),
          borderSide: BorderSide(
              color: widget.focusedBorderColor, width: widget.borderWidth),
        ),
      ),
    );
  }
}
