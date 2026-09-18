import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolist/core/style/assets_manger.dart';
import 'package:todolist/core/style/color_manger.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<String> _icons = [
    AssetsManager.homeIcon,
    AssetsManager.calendarIcon,
    AssetsManager.historyIcon,
    AssetsManager.profileIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: ColorsManager.whiteColor,
        border: Border(top: BorderSide(color: ColorsManager.neutralLineColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (index) {
          final bool active = index == currentIndex;
          final Color tint = active
              ? ColorsManager.brandPrimarytColor
              : ColorsManager.neutralSecondaryColor;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  _icons[index],
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 16,
                  height: 2,
                  color: active
                      ? ColorsManager.brandPrimarytColor
                      : Colors.transparent,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
