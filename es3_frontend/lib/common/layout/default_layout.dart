import 'package:es3_frontend/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultLayout extends StatefulWidget {
  final String? title;
  final Widget child;

  const DefaultLayout({
    super.key,
    required this.child,
    this.title,
  });

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  int _currentIndex = 2;
  final List<String> _routes = [
    '/category',
    '/event',
    '/home',
    '/favorite',
    '/mypage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: widget.child,
      bottomNavigationBar: renderBottomNav(),
    );
  }

  renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Icon(Icons.logo_dev_outlined),
      title: widget.title != null
          ? Text(
              widget.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          : null,
      centerTitle: true,
      foregroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_basket_outlined),
        ),
      ],
    );
  }

  renderBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        context.go(_routes[index]);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.campaign_outlined),
          label: 'event',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'my page',
        ),
      ],
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
    );
  }
}
