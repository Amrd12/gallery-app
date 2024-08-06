import 'package:flutter/material.dart';
import 'package:gallaryapp/ui/widgets/app_bar/orientation_enum.dart';
import 'Custom_Search_Results.dart';
import 'Custom_Search_Suggestions.dart';

class CustomSearchBar extends SearchDelegate {
  String? res;

  CustomSearchBar() {
    // Initialize searchFieldLabel with context-aware localization.
  }

  final ValueNotifier<OrientationMode> orientation =
      ValueNotifier(OrientationMode.none);

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.of(context).pop(res),
      icon: const Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        ValueListenableBuilder<OrientationMode>(
          valueListenable: orientation,
          builder:
              (BuildContext context, OrientationMode mode, Widget? child) =>
                  IconButton(
                      onPressed: () {
                        orientation.value = OrientationMode.values[
                            (orientation.value.index + 1) %
                                OrientationMode.values.length];
                      },
                      icon: Icon(mode.icon)),
        ),
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.close))
      ];

  @override
  Widget buildResults(BuildContext context) {
    return CustomSearchResults(querry: query, type: orientation.value.name);
  }

  void onPress(String query, String type, BuildContext context) {
    this.query = query;
    orientation.value =
        OrientationMode.values.firstWhere((mode) => mode.name == type);
    showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CustomSearchSuggestions(text: query, onPressed: onPress);
  }
}
