import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_and_menu/menu_widget.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    print('MenuPage build');
    return Material(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        child: Row(
          children: [
            MenuWidget(
              navigationShell: navigationShell,
            ),
            Expanded(child: navigationShell),
          ],
        ),
      )
    ]));
  }
}
