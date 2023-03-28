import 'package:flutter/material.dart';

class ReusableRatingRow extends StatelessWidget {
  const ReusableRatingRow({Key? key, required this.rating}) : super(key: key);
  final int rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for(int i=0;i<rating;i++)
          const Icon(
            Icons.star,
            size: 14,
            color: Colors.amber,
          ),
         for(int i=0;i<5-rating;i++)
          const Icon(
            Icons.star,
            size: 14,
            color: Colors.grey,
          )
      ],
    );
  }
}
