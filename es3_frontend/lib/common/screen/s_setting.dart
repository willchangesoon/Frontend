import 'package:es3_frontend/user/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _myInfo(),
          Divider(thickness: 1),
          _generalSetting(),
        ],
      ),
    );
  }

  Widget _myInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Info',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Update Profile'),
            IconButton(
                onPressed: () {
                  context.push('/mypage/setting/update-profile');
                },
                icon: Icon(Icons.chevron_right))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Manage Shipping Address'),
            IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
          ],
        ),
      ],
    );
  }

  Widget _generalSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Setting',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Notification Setting'),
            IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
          ],
        ),
        GestureDetector(
          onTap: (){
            ref.watch(authProvider.notifier).logout();
            context.go('/');
          },
          child: Text('Log out'),
        ),
      ],
    );
  }
}
