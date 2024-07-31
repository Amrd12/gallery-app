import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/photo_storage_cubit.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/data/models/Photo_Model.dart';
import 'package:gallaryapp/ui/widgets/Custom_Photo_List.dart';

class CustomBlocStorage extends StatelessWidget {
  const CustomBlocStorage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PhotoStorageCubit>().getPhotosPage();
    return BlocBuilder<PhotoStorageCubit, PhotoStorageState>(
      builder: (context, state) {
        if (state is PhotoStorageLoaded) {
          List<PhotoModel> photos = state.photos;
          print(photos.length);
          return CustomPhotoList(photos: photos);
        }
        return const Expanded(
            child: Center(
                child: CircularProgressIndicator(
          color: MyColors.myYellow,
        )));
      },
    );
  }
}
