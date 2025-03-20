import 'package:es3_seller/component/default_layout.dart';
import 'package:es3_seller/product/form/description.dart';
import 'package:es3_seller/product/form/product_image_step.dart';
import 'package:es3_seller/product/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../form/basic_info_form.dart';
import '../repository/product_repository.dart';

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
    Product product = Product(
      title: basicInfo?['title'],
      visibility: basicInfo?['visibility'],
      deliveryType: basicInfo?['deliveryType'],
      categoryId: basicInfo?['subCategory'] == null
          ? basicInfo!['mainCategory']
          : basicInfo!['subCategory'],
      price: int.parse(basicInfo?['price']),
      // mainImage: images?['mainImage'],
      mainImage: '',
      // additionalImages: images?['additionalImages'],
      additionalImages: [''],
      description: description!,
      productOptionList: basicInfo!['options'],
    );

    print(product.toString());

    try {
      await ref.read(productRepositoryProvider).createProduct(product: product);
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
