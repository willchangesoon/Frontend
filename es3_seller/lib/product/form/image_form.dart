import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagesScreen extends StatefulWidget {
  const ProductImagesScreen({Key? key}) : super(key: key);

  @override
  State<ProductImagesScreen> createState() => _ProductImagesScreenState();
}

class _ProductImagesScreenState extends State<ProductImagesScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _mainImage;
  final List<File> _otherImages = [];

  Future<void> _pickMainImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mainImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickOtherImage() async {
    if (_otherImages.length >= 4) return; // 최대 4장까지만 추가
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _otherImages.add(File(pickedFile.path));
      });
    }
  }

  void _removeOtherImage(int index) {
    setState(() {
      _otherImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Product Images'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                ..._otherImages.asMap().entries.map((entry) {
                  int index = entry.key;
                  File imageFile = entry.value;
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Image.file(imageFile, fit: BoxFit.cover),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _removeOtherImage(index),
                      ),
                    ],
                  );
                }).toList(),
                if (_otherImages.length < 4)
                  GestureDetector(
                    onTap: _pickOtherImage,
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
            // Next 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 대표 이미지와 추가 이미지가 선택되었는지 검증한 후 다음 스크린으로 이동
                  // 예시: GoRouter.of(context).push('/nextScreen');
                  GoRouter.of(context).push('/nextScreen');
                },
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
    );
  }
}
