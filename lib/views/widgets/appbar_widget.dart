import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? backButton;
  final List<Widget>? actionWidgets;
  const MyAppBar(
      {super.key, required this.title, this.backButton, this.actionWidgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: backButton,
      centerTitle: true,
      actions: actionWidgets ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
