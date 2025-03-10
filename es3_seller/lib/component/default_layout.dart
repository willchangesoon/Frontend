import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;

  const DefaultLayout({Key? key, required this.child}) : super(key: key);

  // 사이드바 구성 (여러 페이지에서 공통으로 사용)
  Widget _buildSidebar(BuildContext context) {
    final List<String> marketMenu = ['배너 관리', '기타 정보 관리'];
    final List<String> productMenu = ['상품 등록', '상품 목록'];
    final List<String> orderMenu = [
      '전체 주문 목록',
      '배송 관리',
      '발송 관리',
      '취소 관리',
      '반품 관리'
    ];
    final List<String> accountMenu = ['계정 관리', '로그아웃'];

    return Container(
      color: Colors.grey[900],
      height: double.infinity,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'MENU',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                _buildSidebarSection('마켓 관리', marketMenu),
                const SizedBox(height: 16),
                _buildSidebarSection('상품 관리', productMenu),
                const SizedBox(height: 16),
                _buildSidebarSection('주문 관리', orderMenu),
                const SizedBox(height: 16),
                _buildSidebarSection('계정 관리', accountMenu),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarSection(String title, List<String> items) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: items
          .map(
            (e) => ListTile(
              title: Text(e, style: const TextStyle(color: Colors.white70)),
              onTap: () {
                // 각 메뉴 선택 시 라우팅이나 로직 처리
              },
            ),
          )
          .toList(),
    );
  }

  // 상단 네비게이션 바 구성
  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 로고 및 검색창
          Row(
            children: [
              Text(
                '에이블리 어드민',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
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
                backgroundColor: Colors.blue[800],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  // 로그아웃 로직
                },
                child: const Text('Logout'),
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
      // 데스크탑: 사이드바 고정 + 상단 네비게이션 바 위에 콘텐츠
      return Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: 220,
              child: _buildSidebar(context),
            ),
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(context),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
