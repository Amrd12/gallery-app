import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      textAlign: TextAlign.center,
      maxLines: 3,
      "You are ofline",
      style: TextStyle(fontSize: 30),
    ));
  }
}
