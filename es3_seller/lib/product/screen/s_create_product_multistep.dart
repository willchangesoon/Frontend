import 'dart:convert';
import 'dart:io';

import 'package:es3_seller/component/default_layout.dart';
import 'package:es3_seller/component/dynamic_option_form.dart';
import 'package:es3_seller/product/screen/product_image_step.dart';
import 'package:es3_seller/provider/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/category_selection.dart';
import '../../component/custom_text_form_field.dart';
import '../form/basic_info_form.dart';
import '../model/category.dart';

class CreateProductMultiStepScreen extends ConsumerStatefulWidget {
  const CreateProductMultiStepScreen({super.key});

  @override
  ConsumerState<CreateProductMultiStepScreen> createState() =>
      _CreateProductMultiStepScreenState();
}

class _CreateProductMultiStepScreenState
    extends ConsumerState<CreateProductMultiStepScreen> {
  // Step 관리
  int _currentStep = 0;
  quill.QuillController _quillController = quill.QuillController.basic();

  // Step 1: Basic Info
  final GlobalKey<FormState> _basicInfoFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  bool _visibility = true;
  String? _deliveryType;

  // 카테고리
  List<Category> _categories = [];
  Category? _selectedTopCategory;
  Category? _selectedSubCategory;
  bool _loadingCategories = true;
  String? _categoryError;

  // 가격은 CustomTextFormField 내에서 처리 (값은 나중에 Form에서 가져올 수 있음)

  // Step 2: Product Images
  File? _mainImage;
  final List<File> _additionalImages = [];

  // Step 3: Description
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // 카테고리 API 호출 및 초기화
  Future<void> _fetchCategories() async {
    try {
      final response = await ref
          .read(dioProvider)
          .get('http://localhost:8080/order-v1/common/categories');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final categories = data.map((json) => Category.fromJson(json)).toList();
        setState(() {
          _categories = categories;
          _loadingCategories = false;
          final topCategories =
              _categories.where((cat) => cat.parentsId == null).toList();
          if (topCategories.isNotEmpty) {
            _selectedTopCategory = topCategories.first;
            final subCategories = _categories
                .where((cat) => cat.parentsId == _selectedTopCategory!.id)
                .toList();
            if (subCategories.isNotEmpty) {
              _selectedSubCategory = subCategories.first;
            }
          }
        });
      } else {
        setState(() {
          _loadingCategories = false;
          _categoryError = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _loadingCategories = false;
        _categoryError = e.toString();
      });
    }
  }

  // 각 단계별 콘텐츠 빌드
  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildImagesStep();
      case 2:
        return _buildDescriptionStep();
      default:
        return Container();
    }
  }

  // Step 1: Basic Info Form 구성
  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicInfoForm(
          formKey: _basicInfoFormKey,
          titleController: _titleController,
          visibility: _visibility,
          deliveryType: _deliveryType,
          onVisibilityChanged: (val) {
            setState(() {
              _visibility = val;
            });
          },
          onDeliveryTypeChanged: (val) {
            setState(() {
              _deliveryType = val;
            });
          },
        ),
        const SizedBox(height: 20),
        // 카테고리 선택
        _loadingCategories
            ? const Center(child: CircularProgressIndicator())
            : _categoryError != null
                ? Center(child: Text(_categoryError!))
                : CategorySelection(
                    topCategories: _categories
                        .where((cat) => cat.parentsId == null)
                        .toList(),
                    subCategories: _selectedTopCategory == null
                        ? []
                        : _categories
                            .where((cat) =>
                                cat.parentsId == _selectedTopCategory!.id)
                            .toList(),
                    selectedTopCategory: _selectedTopCategory,
                    selectedSubCategory: _selectedSubCategory,
                    onTopCategoryChanged: (newCat) {
                      setState(() {
                        _selectedTopCategory = newCat;
                        final subCats = _categories
                            .where((cat) => cat.parentsId == newCat!.id)
                            .toList();
                        _selectedSubCategory =
                            subCats.isNotEmpty ? subCats.first : null;
                      });
                    },
                    onSubCategoryChanged: (newSubCat) {
                      setState(() {
                        _selectedSubCategory = newSubCat;
                      });
                    },
                  ),
        const SizedBox(height: 10),
        // 가격 입력 (CustomTextFormField 내에 validator 포함)
        CustomTextFormField(
          keyboardType: TextInputType.number,
          text: 'price',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter price';
            }
            return null;
          },
        ),
        const DynamicOptionsForm(),
      ],
    );
  }

  // Step 2: 이미지 선택 화면
  Widget _buildImagesStep() {
    return ProductImagesStep(
      mainImage: _mainImage,
      additionalImages: _additionalImages,
      onMainImagePicked: (file) {
        setState(() {
          _mainImage = file;
        });
      },
      onAdditionalImagePicked: (file) {
        setState(() {
          if (_additionalImages.length < 4) {
            _additionalImages.add(file);
          }
        });
      },
      onRemoveAdditionalImage: (index) {
        setState(() {
          _additionalImages.removeAt(index);
        });
      },
    );
  }

  // Step 3: Description 입력 화면
  Widget _buildDescriptionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              quill.QuillSimpleToolbar(
                controller: _quillController,
                config: const quill.QuillSimpleToolbarConfig(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 500,
          child: quill.QuillEditor.basic(
            controller: _quillController,
            config: const quill.QuillEditorConfig(),
          ),
        )
      ],
    );
  }

  // 단계 이동: Next 버튼
  Future<void> _nextStep() async {
    if (_currentStep == 0) {
      // Step 1 유효성 검사
      if (!_basicInfoFormKey.currentState!.validate()) return;
    }
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Step 3: 모든 데이터를 모아서 API 호출 (예시)
      final productData = {
        'title': _titleController.text,
        'visibility': _visibility,
        'deliveryType': _deliveryType,
        'mainCategory': _selectedTopCategory?.id,
        'subCategory': _selectedSubCategory?.id,
        // 가격과 옵션은 기본정보 폼 내에서 처리되었다고 가정
        'price': '... ', // 필요 시 추출
        'options': '...', // DynamicOptionsForm의 결과
        'description': _descriptionController.text,
        // 이미지 파일들은 따로 업로드 후 URL을 받는 로직 필요
      };
      // 예시 API 호출
      final response = await ref.read(dioProvider).post(
            'http://localhost:8080/product-v1/create',
            data: jsonEncode(productData),
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // 성공 시 홈으로 이동 (또는 성공 메시지 표시)
        GoRouter.of(context).push('/home');
      } else {
        // 실패 처리 (예: 에러 메시지 표시)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
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
              // 단계 표시
              Text(
                'Step ${_currentStep + 1} of 3',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildStepContent(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: _prevStep,
                      child: const Text('Back'),
                    ),
                  ElevatedButton(
                    onPressed: _nextStep,
                    child: Text(_currentStep < 2 ? 'Next' : 'Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
