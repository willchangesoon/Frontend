import 'package:flutter/material.dart';

import '../product/model/product_option.dart';
import 'option_input.dart';

class DynamicOptionsForm extends StatefulWidget {
  const DynamicOptionsForm({super.key});

  @override
  DynamicOptionsFormState createState() => DynamicOptionsFormState();
}

class DynamicOptionsFormState extends State<DynamicOptionsForm> {
  List<ProductOption> options = [];

  void _addOption() {
    setState(() {
      options.add(ProductOption(optionName: '', optionValues: []));
    });
  }

  void _removeOption(int index) {
    setState(() {
      options.removeAt(index);
    });
  }

  void _updateOptionName(int index, String name) {
    setState(() {
      options[index].optionName = name;
    });
  }

  void _addOptionValue(int optionIndex, String value) {
    setState(() {
      if (!options[optionIndex].optionValues.contains(value)) {
        options[optionIndex].optionValues.add(value);
      }
    });
  }

  void _removeOptionValue(int optionIndex, String value) {
    setState(() {
      options[optionIndex].optionValues.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(options.length, (index) {
          return OptionInput(
            key: ValueKey(index),
            option: options[index],
            onOptionNameChanged: (name) => _updateOptionName(index, name),
            onAddValue: (value) => _addOptionValue(index, value),
            onRemoveValue: (value) => _removeOptionValue(index, value),
            onRemoveOption: () => _removeOption(index),
          );
        }),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addOption,
          icon: const Icon(Icons.add),
          label: const Text("옵션 추가"),
        ),
      ],
    );
  }
}
