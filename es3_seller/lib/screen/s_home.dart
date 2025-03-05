import 'package:flutter/material.dart';
import '../component/state_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> marketMenu = [
    '배너 관리',
    '기타 정보 관리',
  ];

  final List<String> productMenu = [
    '상품 등록',
    '상품 목록',
  ];

  final List<String> orderMenu = [
    '전체 주문 목록',
    '배송 관리',
    '발송 관리',
    '취소 관리',
    '반품 관리',
  ];

  @override
  Widget build(BuildContext context) {
    // 화면 폭을 확인하여 모바일 여부 결정 (예: 800 미만이면 모바일)
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
          child: _buildSidebar(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatCards(),
              const SizedBox(height: 24),
              Text(
                '최근 주문 목록',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildRecentOrdersTable(),
              const SizedBox(height: 24),
              _buildNotificationsSection(),
            ],
          ),
        ),
      );
    } else {
      // 데스크탑: 사이드바 + 상단바 + 메인 콘텐츠 Row 레이아웃
      return Scaffold(
        body: Row(
          children: [
            // 왼쪽 사이드바
            SizedBox(
              width: 220,
              child: Container(
                color: Colors.grey[900],
                child: _buildSidebar(),
              ),
            ),
            // 오른쪽 메인 영역 (상단 네비게이션 바 + 콘텐츠)
            Expanded(
              child: Column(
                children: [
                  // 상단 네비게이션 바
                  Container(
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
                  ),
                  // 메인 콘텐츠
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatCards(),
                          const SizedBox(height: 24),
                          Text(
                            '최근 주문 목록',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          _buildRecentOrdersTable(),
                          const SizedBox(height: 24),
                          _buildNotificationsSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSidebar() {
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
                // 사이드바 상단 로고(텍스트)
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'MENU',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                // 마켓 관리
                _buildSidebarSection('마켓 관리', marketMenu),
                const SizedBox(height: 16),
                // 상품 관리
                _buildSidebarSection('상품 관리', productMenu),
                const SizedBox(height: 16),
                // 주문 관리
                _buildSidebarSection('주문 관리', orderMenu),
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
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: items
          .map(
            (e) => ListTile(
          title: Text(e, style: const TextStyle(color: Colors.white70)),
          onTap: () {
            // 각 메뉴 선택 시 로직
          },
        ),
      )
          .toList(),
    );
  }

  // 상단 통계 카드들
  Widget _buildStatCards() {
    // 예시로 3개 카드
    final List<StatCardData> stats = [
      StatCardData(title: '오늘 주문수', value: '120'),
      StatCardData(title: '발송 대기', value: '34'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stats
          .map((stat) => Expanded(
        child: StatCard(data: stat),
      ))
          .toList(),
    );
  }

  // 최근 주문 목록 테이블
  Widget _buildRecentOrdersTable() {
    // 샘플 데이터
    final orders = [
      {'orderId': '1001', 'customer': '홍길동', 'status': '결제완료', 'amount': 35000},
      {'orderId': '1002', 'customer': '이영희', 'status': '배송중', 'amount': 12000},
      {'orderId': '1003', 'customer': '김철수', 'status': '취소요청', 'amount': 56000},
      {'orderId': '1004', 'customer': '박영미', 'status': '배송준비', 'amount': 22000},
    ];

    return Card(
      elevation: 2,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('주문번호')),
          DataColumn(label: Text('고객명')),
          DataColumn(label: Text('상태')),
          DataColumn(label: Text('금액')),
        ],
        rows: orders
            .map(
              (o) => DataRow(cells: [
            DataCell(Text(o['orderId'].toString())),
            DataCell(Text(o['customer'].toString())),
            DataCell(Text(o['status'].toString())),
            DataCell(Text(o['amount'].toString())),
          ]),
        )
            .toList(),
      ),
    );
  }

  // 공지/알림 섹션 예시
  Widget _buildNotificationsSection() {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '공지사항',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• 설 연휴 배송 안내'),
            Text('• 시스템 점검 안내 (1/25 ~ 1/26)'),
          ],
        ),
      ),
    );
  }
}
