import 'package:es3_seller/component/custom_text_form_field.dart';
import 'package:es3_seller/component/default_layout.dart';
import 'package:es3_seller/component/dynamic_option_form.dart';
import 'package:es3_seller/provider/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/category_selection.dart';
import '../../const/colors.dart';
import '../model/category.dart';

class CreateProductScreen extends ConsumerStatefulWidget {
  const CreateProductScreen({super.key});

  @override
  ConsumerState<CreateProductScreen> createState() =>
      _CreateProductScreenState();
}

class _CreateProductScreenState extends ConsumerState<CreateProductScreen> {
  String? _delivery;
  bool visibility = true;
  List<Category> _categories = [];
  bool _loading = true;
  String? _error;

  Category? _selectedTopCategory;
  Category? _selectedSubCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

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
          _loading = false;
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
          _loading = false;
          _error = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 로딩 또는 에러 상태 처리
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }

    // API로 불러온 카테고리 중 상위(부모가 없는) 카테고리와
    // 선택된 상위 카테고리에 해당하는 하위 카테고리 추출
    final List<Category> topCategories =
        _categories.where((cat) => cat.parentsId == null).toList();
    final List<Category> subCategories = _selectedTopCategory == null
        ? []
        : _categories
            .where((cat) => cat.parentsId == _selectedTopCategory!.id)
            .toList();

    return DefaultLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BasicInfoForm(formKey: GlobalKey<FormState>()),
              const SizedBox(height: 20),
              CategorySelection(
                topCategories: topCategories,
                subCategories: subCategories,
                selectedTopCategory: _selectedTopCategory,
                selectedSubCategory: _selectedSubCategory,
                onTopCategoryChanged: (newCategory) {
                  setState(() {
                    _selectedTopCategory = newCategory;
                    final subCats = _categories
                        .where((cat) => cat.parentsId == newCategory!.id)
                        .toList();
                    _selectedSubCategory =
                        subCats.isNotEmpty ? subCats.first : null;
                  });
                },
                onSubCategoryChanged: (newSubCategory) {
                  setState(() {
                    _selectedSubCategory = newSubCategory;
                  });
                },
              ),
              const SizedBox(height: 10),
              // 가격 입력 필드
              CustomTextFormField(
                keyboardType: TextInputType.number,
                text: 'price',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter price';
                  }
                  return null;
                },
              ),
              // 옵션 입력 폼 (DynamicOptionsForm: 옵션명 및 값들을 동적으로 추가)
              const DynamicOptionsForm(),
              const SizedBox(height: 30),
              // Next 버튼: 다음 페이지로 이동
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    GoRouter.of(context).push('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MAIN_COLOR,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
