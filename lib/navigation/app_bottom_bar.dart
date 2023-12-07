import 'package:flutter/material.dart';

class MenuData {
  final String label;
  final IconData icon;

  const MenuData({
    required this.label,
    required this.icon,
  });
}

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<MenuData> menus;
  final ValueChanged<int>? onItemTap;

  const AppBottomBar(
      {Key? key, this.currentIndex = 0, required this.menus, this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      // 底部导航栏的背景颜色
      onTap: onItemTap,
      // 当底部导航栏的项被点击时的回调函数
      currentIndex: currentIndex,
      // 当前底部导航栏的索引
      elevation: 3,
      // 底部导航栏的elevation（投影深度）
      type: BottomNavigationBarType.fixed,
      // 底部导航栏的类型（固定类型）
      iconSize: 22,
      // 底部导航栏图标的大小
      selectedItemColor: Theme.of(context).primaryColor,
      // 选中底部导航栏项的颜色
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      // 选中底部导航栏项的文本样式
      showSelectedLabels: true,
      // 是否显示选中的标签
      showUnselectedLabels: true,
      // 是否显示未选中的标签
      items: menus.map((e) => _buildItemByMenuMeta(e)).toList(),
      // 底部导航栏的项列表
    );
  }

  BottomNavigationBarItem _buildItemByMenuMeta(MenuData menu) {
    return BottomNavigationBarItem(
      icon: Icon(menu.icon),
      label: menu.label,
    );
  }
}
