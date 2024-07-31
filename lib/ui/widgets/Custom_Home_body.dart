import 'package:flutter/material.dart';

import 'Custom_Bloc_Api.dart';

class CustomHomeBody extends StatelessWidget {
  CustomHomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CustomBlocApi(),
    );
  }
}
