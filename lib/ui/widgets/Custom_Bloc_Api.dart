import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit/photo_Api_cubit.dart';
import '../../constans/colors.dart';
import '../../data/models/Photo_Model.dart';
import 'Custom_Photo_List.dart';

class CustomBlocApi extends StatelessWidget {
  CustomBlocApi({super.key});
  void onpressed(BuildContext context) {
    context.read<PhotoApiCubit>().nextpage();
    context.read<PhotoApiCubit>().getPhotosPage();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PhotoApiCubit>().getPhotosPage();
    return BlocBuilder<PhotoApiCubit, PhotoApiState>(
      builder: (context, state) {
        if (state is PhotoApiLoaded) {
          List<PhotoModel> photos = state.photos;
          print(photos.length);
          return CustomPhotoList(
              photos: photos, onPressed: () => onpressed(context));
        }
        return const Center(
            child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ));
      },
    );
  }
}
