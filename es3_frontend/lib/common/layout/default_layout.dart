import 'package:es3_frontend/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultLayout extends StatefulWidget {
  final String? title;
  final Widget child;
  final bool showBottomNav;
  final bool showAppBarBtnBack;
  final bool appBarColor;
  final bool showBuyBottomNav;

  const DefaultLayout({
    super.key,
    required this.child,
    this.title,
    this.showBottomNav = true,
    this.showAppBarBtnBack = false,
    this.appBarColor = false,
    this.showBuyBottomNav = false,
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
      backgroundColor: Colors.white,
      appBar: renderAppBar(),
      body: Container(
        color: Colors.white,
        child: widget.child,
      ),
      bottomNavigationBar: widget.showBottomNav
          ? widget.showBuyBottomNav
              ? renderBuyBottomNav()
              : renderBottomNav()
          : null,
    );
  }

  renderAppBar() {
    return AppBar(
      backgroundColor: widget.appBarColor ? MAIN_COLOR : Colors.white,
      leading: widget.showAppBarBtnBack
          ? BackButton(
              onPressed: () {
                context.pop();
              },
            )
          : const Icon(Icons.logo_dev_outlined),
      title: widget.title != null
          ? Text(
              widget.title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : null,
      centerTitle: true,
      foregroundColor: widget.appBarColor ? Colors.white : Colors.black,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go(_routes[index]);
        },
        items: const [
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
        backgroundColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        elevation: 0,
      ),
    );
  }

  renderBuyBottomNav() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 좋아요 아이콘 + 개수
            Row(
              children: [
                Icon(Icons.add_shopping_cart),
                SizedBox(width: 4),
                Text(
                  "add to cart",
                ),
              ],
            ),
            // 구매하기 버튼
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Row(
                children: [
                  Text("구매하기",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "무료배송",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
