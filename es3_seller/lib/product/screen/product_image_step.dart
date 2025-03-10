import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagesStep extends StatefulWidget {
  final File? mainImage;
  final List<File> additionalImages;
  final ValueChanged<File> onMainImagePicked;
  final ValueChanged<File> onAdditionalImagePicked;
  final ValueChanged<int> onRemoveAdditionalImage;

  const ProductImagesStep({
    Key? key,
    required this.mainImage,
    required this.additionalImages,
    required this.onMainImagePicked,
    required this.onAdditionalImagePicked,
    required this.onRemoveAdditionalImage,
  }) : super(key: key);

  @override
  State<ProductImagesStep> createState() => _ProductImagesStepState();
}

class _ProductImagesStepState extends State<ProductImagesStep> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMainImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.onMainImagePicked(File(pickedFile.path));
    }
  }

  Future<void> _pickAdditionalImage() async {
    if (widget.additionalImages.length >= 4) return;
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.onAdditionalImagePicked(File(pickedFile.path));
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
            child: widget.mainImage != null
                ? Image.file(widget.mainImage!, fit: BoxFit.cover)
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
            ...widget.additionalImages.asMap().entries.map((entry) {
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
                    onPressed: () => widget.onRemoveAdditionalImage(index),
                  ),
                ],
              );
            }).toList(),
            if (widget.additionalImages.length < 4)
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
      ],
    );
  }
}
