import 'package:es3_seller/component/required_form_label.dart';
import 'package:flutter/material.dart';
import 'package:es3_seller/const/colors.dart';
import '../component/custom_text_form_field.dart';

class SignUpThirdForm extends StatefulWidget {
  final VoidCallback goBack;
  final ValueChanged<Map<String, dynamic>> onNext;

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
  final GlobalKey<FormFieldState<String>> _bankFieldKey = GlobalKey<FormFieldState<String>>();
  final accountNumberController = TextEditingController();
  final accountHolderNameController = TextEditingController();
  final List<String> bankList = [
    'Shinhan Bank',
    'Vietcom Bank',
    'Viettin Bank',
    'Agri Bank'
  ];
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    accountNumberController.addListener(_updateButtonState);
    accountHolderNameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final isValid = accountNumberController.text.isNotEmpty &&
        accountHolderNameController.text.isNotEmpty;
    setState(() {
      _isButtonEnabled = isValid;
    });
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    accountHolderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DropdownMenu를 FormField로 감싸서 선택값 관리
          FormField<String>(
            key: _bankFieldKey,
            initialValue: null,
            validator: (value) => value == null ? 'Please select a bank' : null,
            builder: (FormFieldState<String> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownMenu<String>(
                    width: double.infinity,
                    hintText: 'Bank',
                    dropdownMenuEntries: bankList
                        .map(
                          (e) => DropdownMenuEntry<String>(
                        value: e,
                        label: e,
                      ),
                    )
                        .toList(),
                    inputDecorationTheme: InputDecorationTheme(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcccccc)),
                      ),
                    ),
                    onSelected: (value) {
                      state.didChange(value);
                    },
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        state.errorText ?? '',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          // Account Number Field
          CustomTextFormField(
            controller: accountNumberController,
            text: 'Account Number',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter account number';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Account Holder Name Field
          CustomTextFormField(
            controller: accountHolderNameController,
            text: 'Account Holder Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter account holder name';
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
          // 버튼 영역
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: widget.goBack,
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff999999),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
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
                  child: TextButton(
                    onPressed:_isButtonEnabled ?  () {
                      if (_formKey.currentState!.validate()) {
                        final selectedBank = _bankFieldKey.currentState?.value;
                        final bankInfo = {
                          "bank": selectedBank,
                          "accountNumber": accountNumberController.text,
                          "accountHolder": accountHolderNameController.text,
                          "bankbookCopy" : "bankbookCopy.jpg"
                          // 추가로 필요한 필드(예: bankbookCopy)는 여기에 포함
                        };
                        widget.onNext(bankInfo);
                      }
                    } : null,
                    style: TextButton.styleFrom(
                      backgroundColor: MAIN_COLOR.withAlpha(128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black,
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
