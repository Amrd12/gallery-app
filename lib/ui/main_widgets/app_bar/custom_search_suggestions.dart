import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/ui/screens/home_screen/cubit/search_storage_cubit.dart';
import 'orientation_enum.dart';
import '../../../constans/colors.dart';
import '../../../data/models/search_model.dart';

class CustomSearchSuggestions extends StatefulWidget {
  const CustomSearchSuggestions(
      {super.key, required this.text, this.onPressed});
  final String text;
  final Function(String query, String type, BuildContext context)? onPressed;

  @override
  State<CustomSearchSuggestions> createState() =>
      _CustomSearchSuggestionsState();
}

class _CustomSearchSuggestionsState extends State<CustomSearchSuggestions> {
  @override
  Widget build(BuildContext context) {
    del(SearchModel item) {
      item.delete();
      context.read<SearchStorageCubit>().getSearchSugg(widget.text);
      setState(() {});
    }

    context.read<SearchStorageCubit>().getSearchSugg(widget.text);
    return BlocBuilder<SearchStorageCubit, SearchStorageState>(
        builder: (context, state) {
      if (state is SearchStorageSuccess) {
        List<SearchModel> search = state.search;
        log(search.length.toString());
        if (search.isEmpty) {
          return const Center(
            child: Text(
              textAlign: TextAlign.center,
              maxLines: 3,
              "Empty",
              style: TextStyle(fontSize: 30),
            ),
          );
        }

        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 15),
          child: ListView.builder(
            itemCount: search.length,
            itemBuilder: (context, index) {
              final item = search[index];
              return ListTile(
                onTap: () => widget.onPressed!(item.name, item.type, context),
                leading: Icon(item.type.toOrientationMode().icon),
                contentPadding: const EdgeInsets.all(0),
                title: Text(item.name),
                subtitle: Text(item.date),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Results ${item.results.toString()}"),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () => del(item),
                        icon: const Icon(Icons.delete_forever))
                  ],
                ),
              );
            },
          ),
        );
      }
      return const Center(
          child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ));
    });
  }
}
