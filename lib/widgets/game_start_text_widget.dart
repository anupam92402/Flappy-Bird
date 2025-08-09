import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/color_constants.dart';
import '../utils/string_constants.dart';

class GameStartTextWidget extends StatelessWidget {
  const GameStartTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment(0, 0.2),
        child:
            Text(
                  StringConstants.tapToPlay,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.color2387FC,
                    letterSpacing: 4,
                  ),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scale(
                  begin: Offset(1.0, 1.0),
                  end: Offset(1.2, 1.2),
                  duration: Duration(milliseconds: 500),
                ),
      ),
    );
  }
}
