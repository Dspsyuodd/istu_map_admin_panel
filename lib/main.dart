import 'package:flutter/material.dart';
import 'package:istu_map_admin_panel/authorization/authorization_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'admin_panel/ui/pages/main_page.dart';
import 'admin_panel/injection_container.dart' as di;
import 'dart:html';

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
      home: Authorization(),
    );
  }
}

class Authorization extends StatefulWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  var authorized = false;
  @override
  void initState() {
    final cookie = document.cookie!;
    if (cookie.isEmpty) {
      authorized = false;
    } else {
      final entity = cookie.split("; ").map((item) {
        final split = item.split("=");
        return MapEntry(split[0], split[1]);
      });
      var cookieMap = Map.fromEntries(entity);
      var token = cookieMap["AccessToken"];
      if (token != null && !JwtDecoder.isExpired(token)) {
        authorized = true;
      } else {
        authorized = false;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return authorized ? const MainPage() : const AuthorizationPage();
  }
}
