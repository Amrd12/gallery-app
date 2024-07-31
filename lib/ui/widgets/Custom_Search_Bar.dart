import 'package:flutter/material.dart';
import '../../data/models/orientation_model.dart';
import 'Custom_Search_Results.dart';
import 'Custom_Search_Suggestions.dart';

class CustomSearchBar extends SearchDelegate {
  String? res;
  OrientationModel orientation = OrientationModel();

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.of(context).pop(res),
      icon: Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        ValueListenableBuilder<int>(
          valueListenable: orientation.item,
          builder: (BuildContext context, int i, Widget? wid) => IconButton(
              onPressed: () {
                orientation.nextItem();
              },
              icon: orientation.icon),
        ),
        IconButton(
            onPressed: () {
              this.query = '';
            },
            icon: Icon(Icons.close))
      ];

  @override
  Widget buildResults(BuildContext context) {
    return CustomSearchResults(querry: query, type: orientation.mode);
  }

  void onpress(String query, String type, BuildContext context) {
    this.query = query;
    orientation.mode = type;
    showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CustomSearchSuggestions(text: query, onPressed: onpress);
  }
}
