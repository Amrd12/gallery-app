import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit/photo_Api_cubit.dart';
import '../../constans/colors.dart';
import '../../data/models/Photo_Model.dart';
import 'Custom_Photo_List.dart';

class CustomBlocApi extends StatefulWidget {
  const CustomBlocApi({super.key});

  @override
  State<CustomBlocApi> createState() => _CustomBlocApiState();
}

class _CustomBlocApiState extends State<CustomBlocApi> {
  final ScrollController _scrollController = ScrollController();

  Future<void> onpressed(BuildContext context) async {
    context.read<PhotoApiCubit>().nextpage();
    await context.read<PhotoApiCubit>().getPhotosPage();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      await onpressed(context);
    }
  } 

  @override
  void initState() {
    context.read<PhotoApiCubit>().getPhotosPage();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoApiCubit, PhotoApiState>(
      builder: (context, state) {
        if (state is PhotoApiLoaded) {
          List<PhotoModel> photos = state.photos;
          return CustomPhotoList(
              photos: photos, scrollController: _scrollController);
        }
        return const Center(
            child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ));
      },
    );
  }
}
