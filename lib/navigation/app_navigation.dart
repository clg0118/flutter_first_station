import 'package:flutter/material.dart';
import 'package:flutter_first_station/guess/guess_page.dart';
import 'package:flutter_first_station/muyu/muyu_page.dart';

import '../paper/paper.dart';
import 'app_bottom_bar.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;
  final PageController _pageController = PageController();

  final List<MenuData> menus = const [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(label: '白板绘制', icon: Icons.palette_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      bottomNavigationBar: AppBottomBar(
        onItemTap: _onChangePage,
        currentIndex: _index,
        menus: menus,
      ),
    );
  }

  void _onChangePage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _index = index;
    });
  }

  Widget _buildContent() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: const [
        GuessPage(),
        MuyuPage(),
        Paper(),
      ],
    );
  }
}
