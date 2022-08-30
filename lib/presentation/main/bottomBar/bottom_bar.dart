import 'package:books/presentation/main/category/category_page.dart';
import 'package:books/presentation/main/main_view.dart';
import 'package:books/presentation/main/personaldetails/personal_info.dart';
import 'package:books/presentation/main/search/search_page.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';


class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key? key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _selectedIndex = 0;
  List pages = [
    MainView(),
    CategoryPage(),
    SearchPage(),
    PersonalInfo(),
  ];
  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.darkGrey,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
            ),
        ],
        ),
    );
  }
}