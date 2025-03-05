import 'package:flutter/material.dart';

import '../const/colors.dart';

class AgreeTerms extends StatefulWidget {
  final VoidCallback goBack;
  final VoidCallback onComplete;

  const AgreeTerms({
    super.key,
    required this.goBack,
    required this.onComplete,
  });

  @override
  State<AgreeTerms> createState() => _AgreeTermsState();
}

class _AgreeTermsState extends State<AgreeTerms> {
  bool agreeToAll = false;
  Map<String, bool> agreements = {
    "Seller Terms and Conditions (Required)": false,
    "Consent to Personal Data Collection (Required)": false,
    "Ad Service Terms (Optional)": false,
    "Advertiser Data Consent (Optional)": false,
  };

  void _toggleAll(bool? value) {
    if (value == null) return;
    setState(() {
      agreeToAll = value;
      agreements.updateAll((key, _) => value);
    });
  }

  void _toggleAgreement(String key, bool? value) {
    if (value == null) return;
    setState(() {
      agreements[key] = value;
      agreeToAll = agreements.values.every((element) => element);
    });
  }

  bool _isButtonEnabled() {
    return agreements.entries
        .where((entry) => entry.key.contains("(Required)")) // 필수 항목만 필터링
        .every((entry) => entry.value); // 모두 true인지 확인
  }

  Widget _buildCheckBoxTile(String key, {bool isAllTerms = false}) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ExpansionTile(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (isAllTerms) {
                  _toggleAll(!agreeToAll);
                } else {
                  _toggleAgreement(key, !agreements[key]!);
                }
              },
              child: Image.asset(
                (isAllTerms ? agreeToAll : agreements[key]!) == true
                    ? 'assets/components/btn_check_teal.png'
                    : 'assets/components/btn_check_gray.png',
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                key,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        showTrailingIcon: isAllTerms ? false : true,
        children: isAllTerms
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("$key details go here..."),
                ),
              ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Agree To Terms',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 21.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.black12,
              ),
            ),
            child: Column(
              children: [
                _buildCheckBoxTile("I agree to all terms", isAllTerms: true),
                ListView(
                  shrinkWrap: true,
                  children: agreements.keys
                      .map((key) => _buildCheckBoxTile(key))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    widget.goBack();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff999999),
                  ),
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (!_isButtonEnabled()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not Completed')),
                      );
                    }
                    widget.onComplete();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isButtonEnabled() ? MAIN_COLOR : Color(0xfff5f5f5),
                  ),
                  child: Text(
                    'Complete',
                    style: TextStyle(
                      color: _isButtonEnabled() ? Colors.white : Color(0xffCCCCCC),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
