import 'package:flutter/material.dart';
import 'package:foxaac_app/shared/widget/shmmer_component.dart';

class BookListShimmerCard extends StatelessWidget {
  const BookListShimmerCard({
    Key? key,
    required this.imageHeight,
    required this.imageWidth,
    required this.textWidth,
    required this.gap,
  }) : super(key: key);

  final double imageHeight;
  final double imageWidth;
  final double textWidth;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ShimmerComponent.rectangular(height: imageHeight, width: imageWidth),
          SizedBox(width: gap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerComponent.rectangular(height: 30, width: textWidth),
                const SizedBox(height: 10),
                ShimmerComponent.rectangular(height: 20, width: textWidth),
                const SizedBox(height: 5),
                ShimmerComponent.rectangular(height: 20, width: textWidth),
                const SizedBox(height: 5),
                ShimmerComponent.rectangular(height: 20, width: textWidth),
                const SizedBox(height: 5),
                ShimmerComponent.rectangular(height: 20, width: textWidth),
              ],
            ),
          )
        ],
      ),
    );
  }
}
