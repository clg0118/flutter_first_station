import 'package:flutter/material.dart';

class CountPanel extends StatelessWidget {
  final int count;
  final VoidCallback onTapSwitchAudio;
  final VoidCallback onTapSwitchImage;

  const CountPanel({
    super.key,
    required this.count,
    required this.onTapSwitchAudio,
    required this.onTapSwitchImage,
  });

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      minimumSize: const Size(34, 34),
      padding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.green,
    );

    return Stack(
      children: [
        Center(
          child: Text(
            '功德数：$count',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: Wrap(
              spacing: 8,
              direction: Axis.vertical,
              children: [
                ElevatedButton(
                  style: style,
                  onPressed: onTapSwitchAudio,
                  child: const Icon(Icons.music_note_outlined),
                ),
                ElevatedButton(
                  style: style,
                  onPressed: onTapSwitchImage,
                  child: const Icon(Icons.image),
                ),
              ],
            )),
      ],
    );
  }
}
