import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;

  const DefaultLayout({Key? key, required this.child}) : super(key: key);

  Widget _buildSidebar(BuildContext context) {
    final Map<String, String> marketMenuRoutes = {
      '배너 관리': '/banner-management',
      '기타 정보 관리': '/general-info',
    };
    final Map<String, String> productMenuRoutes = {
      '상품 등록': '/create-product',
      '상품 목록': ''
    };
    final Map<String, String> orderMenuRoutes = {
      '전체 주문 목록': '',
      '배송 관리': '',
      '발송 관리': '',
      '취소 관리': '',
      '반품 관리': ''
    };
    final Map<String, String> accountMenuRoutes = {'계정 관리': '', '로그아웃': ''};

    return Container(
      // color: Colors.grey[900],
      height: double.infinity,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!kIsWeb)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Menu',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                _buildSidebarSection(context, '마켓 관리', marketMenuRoutes),
                const SizedBox(height: 16),
                _buildSidebarSection(context, '상품 관리', productMenuRoutes),
                const SizedBox(height: 16),
                _buildSidebarSection(context, '주문 관리', orderMenuRoutes),
                const SizedBox(height: 16),
                _buildSidebarSection(context, '계정 관리', accountMenuRoutes),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarSection(
      BuildContext context, String title, Map<String, String> items) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      // iconColor: Colors.white,
      // collapsedIconColor: Colors.white,
      children: items.entries.map((entry) {
        return ListTile(
          title: Text(
            entry.key,
            // style: const TextStyle(color: Colors.white70),
          ),
          onTap: () {
            context.push(entry.value);
          },
        );
      }).toList(),
    );
  }

  // 상단 네비게이션 바 구성
  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 로고 및 검색창
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                Text(
                  'Seller',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 우측 프로필 및 알림
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                child: const Icon(Icons.person),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    if (isMobile) {
      // 모바일: AppBar + Drawer 사용
      return Scaffold(
        appBar: AppBar(
          title: const Text('어드민'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
        drawer: Drawer(
          child: _buildSidebar(context),
        ),
        body: child,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.ac_unit),
          title: const Text('어드민'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Row(
          children: [
            SizedBox(
              width: 220,
              child: _buildSidebar(context),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: child,
              ),
            ),
          ],
        ),
      );
    }
  }
}
