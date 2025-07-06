import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_widgets/files/image.dart';
import '../../../_widgets/others/other.dart';

class SharedBg extends StatelessWidget {
  const SharedBg({super.key});

  @override
  Widget build(BuildContext context) {
    // return Metaballs(
    //     color: const Color.fromARGB(255, 66, 133, 244),
    //     effect: MetaballsEffect.follow(
    //       growthFactor: 1,
    //       smoothing: 1,
    //       radius: 0.5,
    //     ),
    //     gradient: LinearGradient(
    //       colors: [
    //         const Color.fromARGB(255, 90, 60, 255),
    //         const Color.fromARGB(255, 120, 255, 255),
    //       ],
    //       begin: Alignment.center,
    //       end: Alignment.center,
    //     ),
    //     metaballs: 10,
    //     animationDuration: const Duration(milliseconds: 200),
    //     speedMultiplier: 1,
    //     bounceStiffness: 3,
    //     minBallRadius: 15,
    //     maxBallRadius: 40,
    //     glowRadius: 0.7,
    //     glowIntensity: 0.6,
    //     child: Blur(
    //       child: SizedBox(width: double.infinity, height: double.infinity),
    //     ));

    return state.share.item.hasCover()
        ? ImageFile(
            state.share.item.coverId(),
            state.share.item.coverName(),
            images: {state.share.item.coverId(): state.share.item.coverName()},
            size: double.infinity,
            showOptions: false,
            ignore: true,
          )
        : NoWidget();
  }
}
