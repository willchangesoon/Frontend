import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:go_router/go_router.dart';

class ProductDescription extends StatelessWidget {
  final ValueChanged<String> onSubmit;
  final VoidCallback goBack;

  const ProductDescription({
    super.key,
    required this.onSubmit,
    required this.goBack,
  });

  @override
  Widget build(BuildContext context) {
    quill.QuillController quillController = quill.QuillController.basic();
    return Center(
      child: Column(
        children: [
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            width: 700,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!kIsWeb)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        quill.QuillSimpleToolbar(
                          controller: quillController,
                          config: const quill.QuillSimpleToolbarConfig(),
                        ),
                      ],
                    ),
                  ),
                if (kIsWeb)
                  quill.QuillSimpleToolbar(
                    controller: quillController,
                    config: const quill.QuillSimpleToolbarConfig(),
                  ),
                Divider(),
                SizedBox(
                  height: 500,
                  child: quill.QuillEditor.basic(
                    controller: quillController,
                    config: const quill.QuillEditorConfig(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  goBack();
                },
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  print('${quillController.document}');
                  onSubmit(jsonEncode(quillController.document.toDelta().toJson()));
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
