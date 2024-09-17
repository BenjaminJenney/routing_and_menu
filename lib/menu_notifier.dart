import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:flutter/material.dart';

IndexedTreeNode node(title, index) {
  return IndexedTreeNode(
    key: title,
    data: {
      'title': title,
      'index': index,
    },
    parent: null,
  );
}

class MenuNotifier with ChangeNotifier {
  final IndexedTreeNode tree = IndexedTreeNode.root()
    ..addAll([
      node('Dashboard', 0),
      node('Participants', 1),
      node('Shops', 2),
    ]);

  void addNodeToParent(String title, String parentTitle, int branchIndex) {
    final parent = tree.children.firstWhere((node) => node.key == parentTitle);
    for (final child in parent.children) {
      if (child.key == title) {
        return;
      }
    }
    parent.add(node(title, branchIndex));
  }
}
