import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const PagerAppBar(
      {Key? key, required this.onClear, this.onBack, this.onRevocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: BackUpButtons(onBack: onBack, onRevocation: onRevocation),
      leadingWidth: 100,
      title: const Text('画板绘制',
          style: TextStyle(color: Colors.black, fontSize: 16)),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: onClear,
          icon:
          const Icon(CupertinoIcons.delete, color: Colors.black, size: 20),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const BackUpButtons(
      {Key? key, required this.onBack, required this.onRevocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const BoxConstraints cts = BoxConstraints(minHeight: 32, minWidth: 32);
    Color backColor = onBack == null ? Colors.grey : Colors.black;
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.black;
    return Center(
      child: Wrap(
        children: [
          Transform.scale(
            scaleX: -1,
            child: IconButton(
              splashRadius: 20,
              constraints: cts,
              onPressed: onBack,
              icon: Icon(Icons.next_plan_outlined, color: backColor),
            ),
          ),
          IconButton(
            splashRadius: 20,
            constraints: cts,
            onPressed: onRevocation,
            icon: Icon(Icons.next_plan_outlined, color: revocationColor),
          ),
        ],
      ),
    );
  }
}