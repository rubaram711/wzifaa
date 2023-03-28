import 'package:flutter/material.dart';

class ReusableReviewRow extends StatelessWidget {
  const ReusableReviewRow({Key? key, required this.review}) : super(key: key);
  final String review;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.remove_red_eye,
          color: Colors.grey[700],
          size: 20,
        ),
        const SizedBox(width: 5,),
        Text(
          review,
          style: TextStyle(color: Colors.grey[700],fontSize: 15),),
      ],
    );
  }
}
