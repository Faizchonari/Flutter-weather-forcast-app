import 'package:flutter/material.dart';
import 'package:weather_app_final/screens/home_page.dart';
import 'package:weather_app_final/screens/search_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wheater App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 88, 86, 86),
          primarySwatch: Colors.blue,
        ),
        home: const MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<Widget> _pages = [HomePage(), SearchPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Weather'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Search'),
        ],
      ),
      body: _pages[currentIndex],
    );
  }
}
