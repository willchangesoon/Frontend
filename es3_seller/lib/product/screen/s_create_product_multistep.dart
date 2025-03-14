import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:es3_seller/component/default_layout.dart';
import 'package:es3_seller/product/form/description.dart';
import 'package:es3_seller/product/model/product.dart';
import 'package:es3_seller/product/repository/product_repository.dart';
import 'package:es3_seller/product/screen/product_image_step.dart';
import 'package:es3_seller/provider/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../form/basic_info_form.dart';

class CreateProductMultiStepScreen extends ConsumerStatefulWidget {
  const CreateProductMultiStepScreen({super.key});

  @override
  ConsumerState<CreateProductMultiStepScreen> createState() =>
      _CreateProductMultiStepScreenState();
}

class _CreateProductMultiStepScreenState
    extends ConsumerState<CreateProductMultiStepScreen> {
  int _currentStep = 0;

  Map<String, dynamic>? basicInfo;
  Map<String, dynamic>? images;
  String? description;

  @override
  void initState() {
    super.initState();
  }

  // 각 단계별 콘텐츠 빌드
  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return BasicInfoForm(
          goBack: () {},
          onNext: (Map<String, dynamic> data) {
            setState(() {
              basicInfo = data;
              _currentStep = 1;
              print('$data');
            });
          },
        );
      case 1:
        return ProductImagesStep(
          goBack: () {
            setState(() {
              _currentStep = 0;
            });
          },
          onNext: (Map<String, dynamic> data) {
            setState(() {
              images = data;
              _currentStep = 2;
              print('$data');
            });
          },
        );
      case 2:
        return ProductDescription(
          goBack: () {
            setState(() {
              _currentStep = 1;
            });
          },
          onSubmit: (String value) {
            setState(() {
              description = value;
            });
            _submitForm();
          },
        );
      default:
        return Container();
    }
  }

  Future<void> _submitForm() async {
    // 각 단계에서 받은 값들을 하나의 맵으로 합침
    final Map<String, dynamic> productData = {
      'title': basicInfo?['title'],
      'visibility': basicInfo?['visibility'],
      'deliveryType': basicInfo?['deliveryType'],
      // 카테고리의 경우, CategorySelectionWidget에서 선택한 카테고리의 id를 기본 정보 맵에 포함시켰거나,
      // 여기서 따로 _selectedTopCategory, _selectedSubCategory의 id 값을 넣을 수 있습니다.
      'mainCategory': _selectedTopCategory?.id,
      'subCategory': _selectedSubCategory?.id,
      'price': basicInfo?['price'],
      // 이미지 정보는 images Map에 'mainImage'와 'additionalImages'라는 키로 저장했다고 가정
      'mainImage': images?['mainImage'],
      'additionalImages': images?['additionalImages'],
      'description': description, // quill의 Delta JSON 문자열 혹은 변환된 포맷
      // 옵션 정보 등 추가 데이터가 있다면 함께 추가
    };

    try {
      final response = await ref.read(productRepositoryProvider).createProduct(product: product);
      if (response.statusCode == 200 || response.statusCode == 201) {
        GoRouter.of(context).push('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step ${_currentStep + 1} of 3',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildStepContent(),
            ],
          ),
        ),
      ),
    );
  }
}
