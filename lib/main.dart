import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing_and_menu/menu_notifier.dart';
import 'package:routing_and_menu/router_notifier.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MenuNotifier()),
    Provider(create: (context) => RouterNotifier()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: context.read<RouterNotifier>().router,
    );
  }
}
