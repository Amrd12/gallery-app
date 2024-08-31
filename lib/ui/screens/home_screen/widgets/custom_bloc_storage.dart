import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/ui/screens/home_screen/cubit/photo_storage_cubit.dart';
import '../../../main_widgets/Custom_Photo_List.dart';
import '../../../../constans/colors.dart';
import '../../../../data/models/photo_model.dart';

class CustomBlocStorage extends StatefulWidget {
  const CustomBlocStorage({super.key});

  @override
  State<CustomBlocStorage> createState() => _CustomBlocStorageState();
}

class _CustomBlocStorageState extends State<CustomBlocStorage> {
  @override
  void initState() {
    super.initState();
    context.read<PhotoStorageCubit>().getPhotosPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoStorageCubit, PhotoStorageState>(
      builder: (context, state) {
        if (state is PhotoStorageLoaded) {
          List<PhotoModel> photos = state.photos;
          log(photos.length.toString());
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
