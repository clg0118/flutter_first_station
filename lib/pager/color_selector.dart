import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> supportColors;
  final ValueChanged<int> onSelector;
  final int activeIndex;

  const ColorSelector(
      {Key? key,
      required this.supportColors,
      required this.onSelector,
      required this.activeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Wrap(
        children: List.generate(
          supportColors.length,_buildByIndex
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool isSelected = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelector(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(2),
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.blue) : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: supportColors[index],
          ),
        ),
      ),
    );
  }
}
