import 'package:es3_seller/component/required_form_label.dart';
import 'package:flutter/material.dart';

import '../component/custom_text_form_field.dart';
import '../const/colors.dart';

class SignUpThirdForm extends StatefulWidget {
  final VoidCallback goBack;
  final VoidCallback onNext;

  const SignUpThirdForm({
    super.key,
    required this.goBack,
    required this.onNext,
  });

  @override
  State<SignUpThirdForm> createState() => _SignUpThirdFormState();
}

class _SignUpThirdFormState extends State<SignUpThirdForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = true;
  final List<String> bankList = [
    'Shinhan Bank',
    'Vietcom Bank',
    'Viettin Bank',
    'Agri Bank'
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Business Info',
              style: TextStyle(fontSize: 16),
            ),
          ),
          RequiredFormLabel(text: 'Settlement Info'),
          const SizedBox(height: 7),
          Text(
            '\u2022 Please use a personal account, not a business account for income reporting.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 7),
          Text(
            '\u2022 The ID number is required for income reporting.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 7),
          Text(
            '\u2022 Ensure the account holder matches the income earner for accurate reporting.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 20),
          RequiredFormLabel(text: 'Payment Info'),
          const SizedBox(height: 10),
          DropdownMenu(
            width: double.infinity,
            hintText: 'Bank',
            dropdownMenuEntries: bankList
                .map(
                  (e) => DropdownMenuEntry(
                    value: e,
                    label: e,
                    style: MenuItemButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
                .toList(),
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffcccccc),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Account Number',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Account Holder Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          RequiredFormLabel(text: 'Upload Copy of Bankbook'),
          Text(
            'Max 5MB (JPG, JPEG, PNG)',
            style: TextStyle(color: Color(0xff999999)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 45,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xff3F9EFF),
                  side: BorderSide(color: Color(0xff3F9EFF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text('Upload Image'),
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
                      backgroundColor: _isButtonEnabled
                          ? Color(0xff999999)
                          : Color(0xfff5f5f5),
                    ),
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                        color:
                            _isButtonEnabled ? Colors.white : Color(0xffCCCCCC),
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
                      // if (!(_formKey.currentState!.validate())) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Not Completed')),
                      //   );
                      // } else {
                      //   widget.onNext();
                      // }
                      widget.onNext();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isButtonEnabled ? MAIN_COLOR : Color(0xfff5f5f5),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color:
                            _isButtonEnabled ? Colors.white : Color(0xffCCCCCC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
