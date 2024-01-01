import 'package:flutter/material.dart';
import 'package:magpie/src/pages/browse_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List screens = [
    const Text("Library"),
    const BrowsePage(),
    const Text("Settings")
  ];
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Your Library"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.browse_gallery),
              label: "Browse"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
            )
          ],
          onTap: (index) {
            setState(() {
              currentScreen = index;
            });
          },
          selectedItemColor: Colors.lightBlue,
          currentIndex: currentScreen,
        ),
        body: screens[currentScreen],
      ),
    );
  }
}
