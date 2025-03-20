import 'package:es3_seller/component/custom_text_form_field.dart';
import 'package:es3_seller/component/required_form_label.dart';
import 'package:es3_seller/product/model/product_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../component/category_selection.dart';
import '../../component/option_manager.dart';
import '../../provider/dio_provider.dart';
import '../model/category.dart' as category;

class BasicInfoForm extends ConsumerStatefulWidget {
  final VoidCallback goBack;
  final ValueChanged<Map<String, dynamic>> onNext;

  const BasicInfoForm({
    super.key,
    required this.goBack,
    required this.onNext,
  });

  @override
  ConsumerState<BasicInfoForm> createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends ConsumerState<BasicInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  bool visibility = false;
  String? deliveryType;

  List<category.Category> _categories = [];
  List<OptionGroup> _options = [];
  category.Category? _selectedTopCategory;
  category.Category? _selectedSubCategory;
  bool _loadingCategories = true;
  String? _categoryError;

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
        final categories =
            data.map((json) => category.Category.fromJson(json)).toList();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RequiredFormLabel(text: 'Basic Information'),
          const SizedBox(height: 20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Visibility'),
              Switch(
                value: visibility,
                onChanged: (val) {
                  setState(() {
                    visibility = val;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Type'),
              Row(
                children: [
                  Radio<String>(
                    value: '가게 배송',
                    groupValue: deliveryType,
                    onChanged: (val) {
                      setState(() {
                        deliveryType = val;
                      });
                    },
                  ),
                  const Text('가게 배송'),
                  Radio<String>(
                    value: '서비스 배송',
                    groupValue: deliveryType,
                    onChanged: (val) {
                      setState(() {
                        deliveryType = val;
                      });
                    },
                  ),
                  const Text('서비스 배송'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
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
          CustomTextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            text: 'price',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter price';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Text('Options'),
          const SizedBox(height: 20),
          OptionManager(
            groups: _options,
            onGroupsChanged: (updatedOptions) {
              setState(() {
                _options = updatedOptions;
              });
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                child: Text('Next'),
                onPressed: () {
                  final data = {
                    "title": titleController.text,
                    "visibility": visibility,
                    "deliveryType": deliveryType,
                    "mainCategory": _selectedTopCategory!.id,
                    "subCategory": _selectedSubCategory?.id,
                    "price": priceController.text,
                    "options":
                        _options.expand((group) => group.options).toList(),
                  };
                  widget.onNext(data);
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
