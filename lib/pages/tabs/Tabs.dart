import 'package:flutter/material.dart';
import 'package:jd_shop/pages/tabs/Home.dart';
import 'package:jd_shop/pages/tabs/Cart.dart';
import 'package:jd_shop/pages/tabs/Caregory.dart';
import 'package:jd_shop/pages/tabs/User.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  TabsState createState() {
    return TabsState();
  }
}

class TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List _pageList = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const UserPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("jdshop"),
      ),
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "购物车"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的"),
        ],
      ),
    );
  }
}
