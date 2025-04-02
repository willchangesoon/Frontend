import 'package:es3_frontend/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../cart/provider/cart_count_provider.dart';
import '../../cart/repository/cart_repository.dart';
import '../../cart/screen/cart_screen.dart';
import '../../products/component/product_option_bottomsheet.dart';

class DefaultLayout extends ConsumerStatefulWidget {
  final String? title;
  final Widget child;
  final bool showBottomNav;
  final bool showAppBarBtnBack;
  final bool appBarColor;
  final bool showBuyBottomNav;
  final VoidCallback? onBuyPressed;

  const DefaultLayout({
    super.key,
    required this.child,
    this.title,
    this.showBottomNav = true,
    this.showAppBarBtnBack = false,
    this.appBarColor = false,
    this.showBuyBottomNav = false,
    this.onBuyPressed
  });

  @override
  ConsumerState<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends ConsumerState<DefaultLayout> {
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
  final cartCount = ref.watch(cartCountProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: renderAppBar(cartCount),
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

  renderAppBar(cartCount) {
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
          icon: const Icon(Icons.search),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {
                context.pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_basket_outlined),
            ),
            if (cartCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$cartCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
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
    return Material(
      elevation: 12,
      shadowColor: GRAY2_COLOR,
      child: BottomAppBar(
        shadowColor: GRAY2_COLOR,
        elevation: 12,
        color: Colors.white,
        child: ElevatedButton(
          onPressed: widget.onBuyPressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text(
            "Purchase",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  renderCartBottomNav() {
    return Material(
      elevation: 12,
      shadowColor: GRAY2_COLOR,
      child: BottomAppBar(
        shadowColor: GRAY2_COLOR,
        elevation: 12,
        color: Colors.white,
        child: ElevatedButton(
          onPressed: widget.onBuyPressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text(
            "Purchase",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
