import 'package:flutter/material.dart';

import '../../../utils/constant/image_asset.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAsset().homeBanner),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
