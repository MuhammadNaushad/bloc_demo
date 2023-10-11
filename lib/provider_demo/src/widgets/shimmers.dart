import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerForListView extends StatelessWidget {
  const ShimmerForListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          height: Get.height,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              //scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.14,
                      child: const Card()),
                );
              }),
        ),
      ),
    );
  }
}
