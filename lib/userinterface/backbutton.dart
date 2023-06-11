import 'package:flutter/material.dart';

import '../settings.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50),
        child: BackButton(
          color: primary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
