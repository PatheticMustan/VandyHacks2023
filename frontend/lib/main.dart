import 'package:flutter/material.dart';
import 'src/home/home_page.dart';
import 'src/scan/scan_page.dart';
import 'src/settings/settings_page.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(
     const MyApp(),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
    
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const BottomNav();
  }
}

class MenuItem {
  const MenuItem(this.iconData, this.text);
  final IconData iconData;
  final String text;
}

class NavBarNotifier extends ChangeNotifier {
  int _index = 0;
  int get index => _index;


  set index(int x) {
    _index = x;
    notifyListeners();
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedTab = 0;

  final menuItemList = const <MenuItem>[
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.camera, 'Scan Prescription'),
    MenuItem(Icons.settings, 'Settings'),
  ];

  final List _pages = [
    const HomePage(),
    const ScanPage(),
    const SettingsPage(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: _pages[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          elevation: 16,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.white,
          items: menuItemList
              .map((MenuItem menuItem) => BottomNavigationBarItem(
                    backgroundColor: Colors.blue,
                    icon: Icon(menuItem.iconData),
                    label: menuItem.text,
                  ))
              .toList(),
        ));
  }
}
