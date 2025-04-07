import 'package:flutter/material.dart';

import '../product/model/product_option.dart';

class OptionInput extends StatefulWidget {
  final List<ProductOption> option;
  final ValueChanged<String> onOptionNameChanged;
  final ValueChanged<String> onAddValue;
  final ValueChanged<String> onRemoveValue;
  final VoidCallback onRemoveOption;

  const OptionInput({
    super.key,
    required this.option,
    required this.onOptionNameChanged,
    required this.onAddValue,
    required this.onRemoveValue,
    required this.onRemoveOption,
  });

  @override
  OptionInputWidgetState createState() => OptionInputWidgetState();
}

class OptionInputWidgetState extends State<OptionInput> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _extraPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _nameController.text = widget.option.optionName;
    _nameController.text = widget.option[0].name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _handleAddValue() {
    final value = _valueController.text.trim();
    if (value.isNotEmpty) {
      widget.onAddValue(value);
      _valueController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "옵션명 (예: 색상, 사이즈)",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: widget.onOptionNameChanged,
                  ),
                ),
                IconButton(
                  onPressed: widget.onRemoveOption,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 옵션 값 입력과 추가 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _valueController,
                    decoration: const InputDecoration(
                      labelText: "옵션 값 입력 (예: 화이트, S)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _handleAddValue,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DataTable(
                columns: const [
                  DataColumn(label: Text('옵션값')),
                  DataColumn(label: Text('재고')),
                  DataColumn(label: Text('추가금액')),
                  DataColumn(label: Text('확인')),
                  DataColumn(label: Text('삭제')),
                ],
                rows: widget.option
                    .where((value) =>
                        value.name.isNotEmpty && value.value.isNotEmpty)
                    .map(
                      (value) => DataRow(
                        cells: [
                          DataCell(Text(value.value)),
                          DataCell(
                            TextField(
                              controller: _stockController,
                            ),
                          ),
                          DataCell(
                            TextField(
                              controller: _extraPriceController,
                            ),
                          ),
                          DataCell(IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {},
                          )),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList()),
          ],
        ),
      ),
    );
  }
}
