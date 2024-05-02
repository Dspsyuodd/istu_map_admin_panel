import 'package:flutter/material.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/pages/main_page.dart';
import 'package:istu_map_admin_panel/admin_panel/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.intiDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
