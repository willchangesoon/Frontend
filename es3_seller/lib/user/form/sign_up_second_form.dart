import 'package:es3_seller/component/custom_text_form_field.dart';
import 'package:es3_seller/component/required_form_label.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class SignUpSecondForm extends StatefulWidget {
  final VoidCallback goBack;
  final ValueChanged<Map<String, dynamic>> onNext;

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
  final representativeNameController = TextEditingController();
  final representativeContactController = TextEditingController();
  final businessNameController = TextEditingController();
  final registeredBusinessNumberController = TextEditingController();
  final addressController = TextEditingController();
  final taxEmailController = TextEditingController();

  final sellerType = ['individual', 'corporate'];
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    representativeNameController.addListener(_updateButtonState);
    representativeContactController.addListener(_updateButtonState);
    businessNameController.addListener(_updateButtonState);
    registeredBusinessNumberController.addListener(_updateButtonState);
    addressController.addListener(_updateButtonState);
    taxEmailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final isValid = representativeNameController.text.isNotEmpty &&
        representativeContactController.text.isNotEmpty &&
        businessNameController.text.isNotEmpty &&
        registeredBusinessNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        taxEmailController.text.isNotEmpty;
    setState(() {
      _isButtonEnabled = isValid;
    });
  }

  @override
  void dispose() {
    representativeNameController.dispose();
    representativeContactController.dispose();
    businessNameController.dispose();
    registeredBusinessNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
            controller: representativeNameController,
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
            controller: representativeContactController,
            keyboardType: TextInputType.phone,
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
            controller: businessNameController,
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
            controller: registeredBusinessNumberController,
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
            controller: addressController,
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
            controller: taxEmailController,
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
                    child: const Text(
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
                    onPressed: _isButtonEnabled ? () {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          "representativeName": representativeNameController.text,
                          "representativeContact": representativeContactController.text,
                          "businessName": businessNameController.text,
                          "businessNumber": registeredBusinessNumberController.text,
                          "businessAddress": addressController.text,
                          "businessLicenseFile" : "fileTemp"
                          // "taxEmail": taxEmailController.text,
                        };
                        widget.onNext(data);
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
