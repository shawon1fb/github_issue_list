library suggestion_textfield;

import 'package:flutter/material.dart';

/// AutoSuggestion class
class AutoSuggestionTextField<T> extends StatefulWidget {
  ///Must pass a controller
  final TextEditingController textController;

  /// pass the desired suggestion string
  final List<String> suggestionStrings;

  /// saved value on changing value
  final ValueChanged<T>? onValueChanged;

  /// You can also define your custom decoration
  final BoxDecoration? suggestionBoxDecoration;

  const AutoSuggestionTextField(
      {Key? key,
      required this.textController,
      required this.suggestionStrings,
      this.onValueChanged,
      this.suggestionBoxDecoration})
      : super(key: key);

  @override
  _AutoSuggestionTextFieldState createState() =>
      _AutoSuggestionTextFieldState();
}

class _AutoSuggestionTextFieldState extends State<AutoSuggestionTextField> {
  //hide at the start
  bool showSuggestionBox = false;
  List<dynamic> matchedItems = <dynamic>[];

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //Add text controller listener and functionality
    widget.textController.addListener(_textListenerFunctionality);
  }

  void _textListenerFunctionality() {
    if (widget.textController.text.isNotEmpty) {
      matchedItems.clear();
      widget.suggestionStrings.forEach((f) {
        /// convert every string to upper case for only comparison with case insensitivity
        if (f
            .toUpperCase()
            .contains(widget.textController.text.toUpperCase())) {
          matchedItems.add(f);
        }
      });

      // show items
      if (matchedItems.isNotEmpty) {
        //////// Temporary fix for the bug when selecting string box pops up twice //////////
        if (matchedItems.length == 1 &&
            matchedItems[0] == widget.textController.text) {
          showSuggestionBox = false;
        } else {
          showSuggestionBox = true;
        }
      } else {
        showSuggestionBox = false;
      }
      ////////////////
      setState(() {});
    } else {
      matchedItems.clear();
      //////////////
      setState(() {
        showSuggestionBox = false;
      });
    }
  }

  //On choosing an item
  void _onItemTap(String selectedItem) {
    matchedItems.clear();
    setState(() {
      widget.textController.text = selectedItem;
      showSuggestionBox = false;

      widget.onValueChanged?.call(selectedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Autocomplete text field
        TextField(
          focusNode: _focusNode,
          controller: widget.textController,
          maxLines: 1,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),

        /// padding to suggestions box
        const SizedBox(
          height: 12,
        ),
        Visibility(
          visible: showSuggestionBox,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            decoration: widget.suggestionBoxDecoration ??
                BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height * 0.2),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: matchedItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _onItemTap(matchedItems[index]),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              '${matchedItems[index]}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 22),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black54,
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
