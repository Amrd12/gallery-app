import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/data/models/Photo_Model.dart';
import 'package:gallaryapp/ui/widgets/Custom_Photo_List.dart';

import '../../../bloc/cubit/search_api_cubit.dart';

class CustomSearchResults extends StatefulWidget {
  const CustomSearchResults({
    super.key,
    required this.querry,
    required this.type,
  });

  final String querry;
  final String type;

  @override
  State<CustomSearchResults> createState() => _CustomSearchResultsState();
}

class _CustomSearchResultsState extends State<CustomSearchResults> {
  ScrollController? _scrollController;

  Future<void> onpressed(BuildContext context) async {
    context.read<SearchApiCubit>().nextpage();
    await context
        .read<SearchApiCubit>()
        .getPhotosPage(widget.querry, widget.type);
  }

  void _scrollListener() async {
    if (_scrollController!.position.pixels >=
        _scrollController!.position.maxScrollExtent) {
      await onpressed(context);
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<SearchApiCubit>()
        .getPhotosPage(widget.querry, widget.type, newsearch: true);
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchApiCubit, SearchApiState>(
        builder: (context, state) {
      if (state is SearchApiSuccess) {
        List<PhotoModel> photos = state.photos;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomPhotoList(
            photos: photos,
            scrollController: _scrollController,
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
