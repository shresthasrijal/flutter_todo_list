import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj5_todo_app_keys/keys/keys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Srijal's Todo App",
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[ Colors.lightBlue, Colors.black,],
              ),
            ),
          ),
        ),
        body: const Keys(),
      ),
    );
  }
}
