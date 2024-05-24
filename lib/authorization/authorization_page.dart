import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:istu_map_admin_panel/admin_panel/injection_container.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/pages/main_page.dart';

import 'package:istu_map_admin_panel/authorization/authorization_api.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = '';
    var password = '';
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  autofillHints: const [AutofillHints.newUsername],
                  decoration: const InputDecoration(
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Gap(20),
                TextField(
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 99, 197, 103),
                    ),
                    onPressed: () async {
                      var result =
                          await sl<AuthorizationApi>().login(email, password);
                      if (result) {
                        if (!context.mounted) return;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MainPage()));
                      }
                    },
                    child: const Text(
                      "Готово",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
