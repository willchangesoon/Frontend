import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagesStep extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onNext;
  final VoidCallback goBack;

  const ProductImagesStep({
    super.key,
    required this.onNext,
    required this.goBack,
  });

  @override
  State<ProductImagesStep> createState() => _ProductImagesStepState();
}

class _ProductImagesStepState extends State<ProductImagesStep> {
  final ImagePicker _picker = ImagePicker();
  File? _mainImage;
  final List<File> _additionalImages = [];

  Future<void> _pickMainImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mainImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAdditionalImage() async {
    if (_additionalImages.length >= 4) return;
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (_additionalImages.length >= 4) return;
        _additionalImages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 대표 이미지 섹션
        const Text(
          'Representative Image',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickMainImage,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey[200],
            ),
            child: _mainImage != null
                ? Image.file(_mainImage!, fit: BoxFit.cover)
                : const Center(child: Text('Tap to select main image')),
          ),
        ),
        const SizedBox(height: 20),
        // 추가 이미지 섹션
        const Text(
          'Additional Images (up to 4)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ..._additionalImages.asMap().entries.map((entry) {
              int index = entry.key;
              File imageFile = entry.value;
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.file(imageFile, fit: BoxFit.cover),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _additionalImages.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            if (_additionalImages.length < 4)
              GestureDetector(
                onTap: _pickAdditionalImage,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.add),
                ),
              ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton.tonal(
              onPressed: () {
                widget.goBack();
              },
              child: const Text('Back'),
            ),
            FilledButton(
              onPressed: () {
                final data = {
                  'mainImage': _mainImage,
                  'additionalImages': _additionalImages,
                };
                print('$data');
                widget.onNext(data);
              },
              child: Text('Next'),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
