import 'package:es3_seller/component/custom_text_form_field.dart';
import 'package:es3_seller/component/required_form_label.dart';
import 'package:flutter/material.dart';

class BasicInfoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final bool visibility;
  final String? deliveryType;
  final ValueChanged<bool> onVisibilityChanged;
  final ValueChanged<String?> onDeliveryTypeChanged;

  const BasicInfoForm({
    Key? key,
    required this.formKey,
    required this.titleController,
    required this.visibility,
    required this.deliveryType,
    required this.onVisibilityChanged,
    required this.onDeliveryTypeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RequiredFormLabel(text: 'Basic Information'),
          const SizedBox(height: 20),
          // 제목 입력 필드
          CustomTextFormField(
            controller: titleController,
            text: 'Title',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter title';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Visibility 스위치
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Visibility'),
              Switch(
                value: visibility,
                onChanged: onVisibilityChanged,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Delivery Type 라디오 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Type'),
              Row(
                children: [
                  Radio<String>(
                    value: '가게 배송',
                    groupValue: deliveryType,
                    onChanged: onDeliveryTypeChanged,
                  ),
                  const Text('가게 배송'),
                  Radio<String>(
                    value: '서비스 배송',
                    groupValue: deliveryType,
                    onChanged: onDeliveryTypeChanged,
                  ),
                  const Text('서비스 배송'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
