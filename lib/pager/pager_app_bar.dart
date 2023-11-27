import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;

  const PagerAppBar({Key? key, required this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
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
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
