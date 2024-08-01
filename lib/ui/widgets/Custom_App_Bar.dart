import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/photo_storage_cubit.dart';
import '../../constans/colors.dart';
import 'Custom_Search_Bar.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool onlineSearch;
  final String Title;
  final bool searchavilable;
  CustomAppBar(
      {Key? key,
      required this.Title,
      required this.preferredSize,
      this.onlineSearch = false,
      this.searchavilable = true})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool search = true;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final he = MediaQuery.of(context).size.height * 0.05;
    var iconButton = (search
        ? IconButton(
            icon: Icon(
              Icons.search,
              size: (he * .7),
            ),
            onPressed: searchon)
        : IconButton(
            icon: Icon(
              Icons.close,
              size: (he * .7),
            ),
            onPressed: searchon));

    return AppBar(
      leading: search
          ? null
          : IconButton(
              onPressed: searchon,
              icon: Icon(Icons.arrow_back),
              iconSize: he * .7,
            ),
      backgroundColor: MyColors.myYellow,
      title: search
          ? Text(
              widget.Title,
              style: TextStyle(color: MyColors.myGrey, fontSize: (he * .7)),
            )
          : TextField(
              controller: controller,
              onChanged:
                  BlocProvider.of<PhotoStorageCubit>(context).searchPhotosPage),
      actions: widget.searchavilable
          ? [
              widget.onlineSearch
                  ? IconButton(
                      icon: Icon(
                        Icons.search,
                        size: (he * .7),
                      ),
                      onPressed: () => showSearch(
                          context: context, delegate: CustomSearchBar()))
                  : iconButton
            ]
          : [],
    );
  }

  void searchon() {
    search = !search;
    if (search = false) {
      controller.text = "";
      BlocProvider.of<PhotoStorageCubit>(context).getPhotosPage();
    }
    setState(() {});
  }
}

              // showSearch(context: context, delegate: CustomSearchBar()),