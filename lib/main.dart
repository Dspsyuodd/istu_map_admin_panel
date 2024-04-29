import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: RequestCheck(),
        ),
      ),
    );
  }
}

class RequestCheck extends StatefulWidget {
  const RequestCheck({Key? key}) : super(key: key);

  @override
  _RequestCheckState createState() => _RequestCheckState();
}

class _RequestCheckState extends State<RequestCheck> {
  var responseText = "Response text";
  var request = "";
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        onChanged: (value) {
          request = value;
        },
      ),
      const Gap(20),
      ElevatedButton(
        onPressed: () {
          makeRequest();
        },
        child: const Text("Make request"),
      ),
      const Gap(20),
      Text(responseText),
    ]);
  }

  Future<void> makeRequest() async {
    var client = http.Client();
    var response =
        await client.get(Uri.parse(request));
    responseText = response.body;
    setState(() {});
  }
}
