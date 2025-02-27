import 'package:es3_seller/component/custom_text_form_field.dart';
import 'package:es3_seller/component/required_form_label.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

class SignUpSecondForm extends StatefulWidget {
  final VoidCallback goBack;
  final VoidCallback onNext;

  const SignUpSecondForm({
    super.key,
    required this.goBack,
    required this.onNext,
  });

  @override
  State<SignUpSecondForm> createState() => _SignUpSecondFormState();
}

class _SignUpSecondFormState extends State<SignUpSecondForm> {
  final _formKey = GlobalKey<FormState>();
  final sellerType = ['individual', 'corporate'];
  bool _isButtonEnabled = true; // 버튼 상태 관리

  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.disabled,
      key: _formKey,
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
          RequiredFormLabel(text: 'Seller Type'),
          const SizedBox(height: 10),
          DropdownMenu(
            width: double.infinity,
            hintText: 'Business Type',
            dropdownMenuEntries: sellerType
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
          const SizedBox(height: 20),
          RequiredFormLabel(text: 'Business Information'),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Representative Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Representative Contact',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Business Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Registered Business Number',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Address',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: 'Tax Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          RequiredFormLabel(text: 'Select Biz License File'),
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
                child: Text('Upload Biz License'),
              ),
            ),
          ),
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
