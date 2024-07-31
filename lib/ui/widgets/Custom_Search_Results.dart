import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/data/models/Photo_Model.dart';
import 'package:gallaryapp/ui/widgets/Custom_Photo_List.dart';

import '../../bloc/cubit/search_api_cubit.dart';

class CustomSearchResults extends StatelessWidget {
  const CustomSearchResults({
    super.key,
    required this.querry,
    required this.type,
  });

  final String querry;
  final String type;

  void onpressed(BuildContext context) {
    context.read<SearchApiCubit>().nextpage();
    context.read<SearchApiCubit>().getPhotosPage(querry, type);
  }

  @override
  Widget build(BuildContext context) {
    context.read<SearchApiCubit>().getPhotosPage(querry, type, newsearch: true);
    return BlocBuilder<SearchApiCubit, SearchApiState>(
        builder: (context, state) {
      if (state is SearchApiSuccess) {
        List<PhotoModel> photos = state.photos;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomPhotoList(
            photos: photos,
            onPressed: () => onpressed,
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
