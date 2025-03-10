import 'package:flutter/material.dart';

import '../component/default_layout.dart';
import '../component/state_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCards(context),
          const SizedBox(height: 24),
          Text(
            '최근 주문 목록',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildRecentOrdersTable(context),
          const SizedBox(height: 24),
          _buildNotificationsSection(),
        ],
      ),
    );
  }

  // 통계 카드들 예시
  Widget _buildStatCards(BuildContext context) {
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

  // 최근 주문 목록 테이블 예시
  Widget _buildRecentOrdersTable(BuildContext context) {
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

  // 공지사항/알림 섹션 예시
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

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: _buildContent(context),
    );
  }
}
