import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/navigation/routes.dart';
import 'package:todolist/core/shared/custom_main_button.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/core/utils/units.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});
  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  final List<Color> _themeOptions = [
    ColorsManager.brandPrimarytColor,
    ColorsManager.blackColor,
    const Color(0xffEF5350),
    const Color(0xff2979FF),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 24),
              ),
              Text(
                'Create to do list',
                style: TextStyles.textStyleBlackSB26,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 8),
              ),
              Text(
                'Choose your to do list color theme:',
                style: TextStyles.textStyleNeutralSecondaryR14,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 24),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _themeOptions.length,
                  separatorBuilder: (_, __) => SizedBox(
                    height: Units.getHeight(context: context, widgetHeight: 16),
                  ),
                  itemBuilder: (context, index) => _buildThemeCard(index),
                ),
              ),
              CustomMainButton(
                btnTitle: 'Open Todyapp',
                onPressed: () {
                  context.pushReplacementNamed(Routes.kHomeView);
                },
              ),
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeCard(int index) {
    final bool selected = index == _selectedIndex;
    final Color color = _themeOptions[index];

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.whiteColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? color : ColorsManager.neutralLineColor,
                width: selected ? 2 : 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 44, color: color),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorsManager.neutralBackgroundColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 8,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorsManager.neutralBackgroundColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 8,
                              width: 120,
                              decoration: BoxDecoration(
                                color: ColorsManager.neutralBackgroundColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Positioned(
              top: -8,
              left: -8,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManager.whiteColor, width: 2),
                ),
                child: const Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
