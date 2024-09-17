import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:routing_and_menu/menu_notifier.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    final menuNotifier = Provider.of<MenuNotifier>(context);
    print('MenuWidget build');
    return Container(
        color: Colors.blue,
        width: 250,
        child: TreeView.indexed(
          tree: menuNotifier.tree,
          showRootNode: false,
          onItemTap: (node) {
            widget.navigationShell.goBranch(index(node));
          },
          builder: (context, node) => sideMenuItem(
            context: context,
            title: title(node),
            index: index(node),
          ),
        ));
  }

  Widget sideMenuItem(
      {required BuildContext context,
      required String title,
      required int index}) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: widget.navigationShell.currentIndex == index ? Colors.grey : null,
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  String title(IndexedTreeNode node) {
    return node.data['title'];
  }

  int index(IndexedTreeNode node) {
    return node.data['index'];
  }
}
