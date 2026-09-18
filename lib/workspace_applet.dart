import 'package:flutter/material.dart';
import 'package:todolist/core/navigation/app_router.dart';
import 'package:todolist/core/style/color_manger.dart';

class WorkspaceApp extends StatelessWidget {
  const WorkspaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        primaryColor: ColorsManager.brandPrimarytColor,
        scaffoldBackgroundColor: ColorsManager.brandPrimaryBackgroundColor,
      ),
      routerConfig: AppRouter.appRouter,
    ); // MaterialApp.router
  }
}
