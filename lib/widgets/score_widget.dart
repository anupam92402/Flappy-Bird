import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key,required this.score});

  final String score;

  @override
  Widget build(BuildContext context) {
    return   Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
         score,
          style: TextStyle(color: Colors.black, fontSize: 38),
        ),
      ),
    );
  }
}
