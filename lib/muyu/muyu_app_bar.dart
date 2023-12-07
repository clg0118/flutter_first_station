import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MuyuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTapHistory;
  const MuyuAppBar({super.key, required this.onTapHistory});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleTextStyle: const TextStyle(color: Colors.black),
      title: const Text("电子木鱼"),
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: onTapHistory,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
