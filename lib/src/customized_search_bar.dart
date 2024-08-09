import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// `CustomizedSearchBar` is a custom search bar widget.
/// This widget provides voice search functionality along with dynamic result filtering.
class CustomizedSearchBar extends StatefulWidget {
  /// The hint text displayed in the search bar.
  final String hintText;

  /// The hint text displayed while voice input is active.
  final String speakHintText;

  /// The icon displayed at the start of the search bar. Optional.
  final IconData? prefixIcon;

  /// The icon displayed at the end of the search bar. Optional.
  final IconData? suffixIcon;

  /// The icon used for voice search. Optional.
  final IconData? voiceIcon;

  /// The color of the prefix icon.
  final Color prefixIconColor;

  /// The color of the suffix icon.
  final Color suffixIconColor;

  /// The color of the voice search icon.
  final Color voiceIconColor;

  /// The color of the border when the search bar is focused.
  final Color focusedBorderColor;

  /// The color of the cursor.
  final Color cursorColor;

  /// The size of the prefix icon.
  final double prefixIconSize;

  /// The size of the suffix icon.
  final double suffixIconSize;

  /// The size of the voice search icon.
  final double voiceIconSize;

  /// The border radius of the search bar.
  final double borderRadiusValue;

  /// The border width of the search bar.
  final double borderWidth;

  /// The list of items to be searched.
  final List<String> searchList;

  /// Callback function triggered when the search results change.
  final ValueChanged<List<String>> onSearchResultChanged;

  /// The text controller used for managing the text input in the search bar.
  final TextEditingController searchController;

  /// Constructor for `CustomizedSearchBar`.
  CustomizedSearchBar({
    Key? key,
    required this.hintText,
    required this.speakHintText,
    this.prefixIcon,
    this.suffixIcon,
    this.voiceIcon,
    required this.prefixIconColor,
    required this.suffixIconColor,
    required this.voiceIconColor,
    required this.focusedBorderColor,
    required this.cursorColor,
    required this.prefixIconSize,
    required this.suffixIconSize,
    required this.voiceIconSize,
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
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isSpeechAvailable = false;
  FocusNode _focusNode = FocusNode();
  late Color _borderColor;
  late String _currentHintText;
  late Color _currentVoiceIconColor;

  @override
  void initState() {
    super.initState();
    _borderColor = Colors.grey;
    _currentHintText = widget.hintText;
    _currentVoiceIconColor = widget.voiceIconColor;
    _speech = stt.SpeechToText();
    _initializeSpeechRecognition();

    _focusNode.addListener(() {
      setState(() {
        _borderColor =
        _focusNode.hasFocus ? widget.focusedBorderColor : Colors.grey;
      });
    });
  }

  /// Initializes the speech recognition functionality and checks if the necessary permissions are granted.
  void _initializeSpeechRecognition() async {
    _isSpeechAvailable = await _speech.initialize(
      onStatus: (val) {
        if (val == 'done') {
          _resetVoiceIcon();
        }
        print('onStatus: $val');
      },
      onError: (val) {
        _resetVoiceIcon();
        print('onError: $val');
      },
    );
    if (!_isSpeechAvailable) {
      print(
          "Microphone access may not have been granted, or your device may not support voice search.");
    }
  }

  /// Starts the voice search functionality. The recognized text is entered into the search box, and results are filtered accordingly.
  void _startVoiceSearch() async {
    if (_isSpeechAvailable) {
      setState(() {
        _isListening = true;
        _currentHintText = widget.speakHintText;
        _currentVoiceIconColor = Colors.green;
      });
      _speech.listen(
        onResult: (val) {
          setState(() {
            widget.searchController.text = val.recognizedWords;
            List<String> results = widget.searchList
                .where((element) => element
                .toLowerCase()
                .contains(val.recognizedWords.toLowerCase()))
                .toList();
            widget.onSearchResultChanged(results);
          });
        },
      );
    } else {
      print("Voice search could not be started. Microphone access may not have been granted.");
    }
  }

  /// Resets the voice search icon and status.
  void _resetVoiceIcon() {
    setState(() {
      _isListening = false;
      _currentHintText = widget.hintText;
      _currentVoiceIconColor = widget.voiceIconColor;
    });
  }

  /// Stops the voice search functionality.
  void _stopVoiceSearch() {
    _resetVoiceIcon();
    _speech.stop();
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
        hintText: _currentHintText,
        prefixIcon: Icon(
          widget.prefixIcon ?? Icons.search, // Default prefix icon
          size: widget.prefixIconSize,
        ),
        suffixIcon: _buildSuffixIcon(),
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

  /// Builds the suffix icon, which is either the voice search icon or a clear icon, depending on whether text is entered in the search bar.
  Widget? _buildSuffixIcon() {
    if (widget.searchController.text.isEmpty) {
      if (widget.voiceIcon != null) {
        return IconButton(
          icon: Icon(
            widget.voiceIcon,
            size: widget.voiceIconSize,
            color: _currentVoiceIconColor,
          ),
          onPressed: _isListening ? _stopVoiceSearch : _startVoiceSearch,
        );
      } else {
        return Icon( // Default suffix icon
          widget.suffixIcon ?? Icons.clear,
          size: widget.suffixIconSize,
        );
      }
    } else {
      return InkWell(
        onTap: () {
          widget.searchController.clear();
          widget.onSearchResultChanged(widget.searchList);
        },
        child: Icon(
          widget.suffixIcon ?? Icons.clear, // Default suffix icon
          size: widget.suffixIconSize,
        ),
      );
    }
  }
}
