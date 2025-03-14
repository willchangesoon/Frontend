import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagesStep extends StatefulWidget {
  final dynamic mainImage;
  final List<dynamic> additionalImages;
  final ValueChanged<dynamic> onMainImagePicked;
  final ValueChanged<dynamic> onAdditionalImagePicked;
  final ValueChanged<int> onRemoveAdditionalImage;

  const ProductImagesStep({
    super.key,
    required this.mainImage,
    required this.additionalImages,
    required this.onMainImagePicked,
    required this.onAdditionalImagePicked,
    required this.onRemoveAdditionalImage,
  });

  @override
  State<ProductImagesStep> createState() => _ProductImagesStepState();
}

class _ProductImagesStepState extends State<ProductImagesStep> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMainImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final Uint8List bytes = await pickedFile.readAsBytes();
        widget.onMainImagePicked(bytes);
      } else {
        widget.onMainImagePicked(File(pickedFile.path));
      }
    }
  }

  Future<void> _pickAdditionalImage() async {
    if (widget.additionalImages.length >= 4) return;
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final Uint8List bytes = await pickedFile.readAsBytes();
        widget.onAdditionalImagePicked(bytes);
      } else {
        widget.onAdditionalImagePicked(File(pickedFile.path));
      }
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
                ? (kIsWeb
                ? Image.memory(widget.mainImage as Uint8List, fit: BoxFit.cover)
                : Image.file(widget.mainImage as File, fit: BoxFit.cover))
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
              var image = entry.value;
              Widget imageWidget;
              if (kIsWeb) {
                imageWidget = Image.memory(image as Uint8List, fit: BoxFit.cover);
              } else {
                imageWidget = Image.file(image as File, fit: BoxFit.cover);
              }
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: imageWidget,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: (){
                context.pop();
              },
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: (){},
              child: Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
