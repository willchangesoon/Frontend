import 'package:flutter/material.dart';

import '../product/model/product_option.dart';

class OptionManager extends StatefulWidget {
  final List<OptionGroup> groups;
  final ValueChanged<List<OptionGroup>> onGroupsChanged;

  const OptionManager({
    super.key,
    required this.groups,
    required this.onGroupsChanged,
  });

  @override
  State<OptionManager> createState() => _OptionManagerState();
}

class _OptionManagerState extends State<OptionManager> {
  late List<OptionGroup> _groups;

  @override
  void initState() {
    super.initState();
    _groups = List.from(widget.groups);
  }

  void _addOptionGroup(String groupName) {
    if (groupName.trim().isEmpty) return;
    if (_groups.any((g) => g.name == groupName)) return;
    setState(() {
      _groups.add(OptionGroup(name: groupName));
      widget.onGroupsChanged(_groups);
    });
  }

  void _removeOptionGroup(String groupName) {
    setState(() {
      _groups.removeWhere((g) => g.name == groupName);
      widget.onGroupsChanged(_groups);
    });
  }

  void _updateOptionGroupName(String oldName, String newName) {
    setState(() {
      for (var group in _groups) {
        if (group.name == oldName) {
          group.name = newName;
        }
      }
      widget.onGroupsChanged(_groups);
    });
  }

  void _addOptionValue(
      String groupName, String value, int stock, int extraPrice) {
    setState(() {
      final group = _groups.firstWhere((g) => g.name == groupName,
          orElse: () => OptionGroup(name: groupName));
      // 중복 체크: 동일 값이 없을 때만 추가
      if (!group.options.any((opt) => opt.value == value)) {
        group.options.add(ProductOption(
            value: value,
            stock: stock,
            extraPrice: extraPrice,
            name: groupName));
      }
      widget.onGroupsChanged(_groups);
    });
  }

  void _removeOptionValue(String groupName, String value) {
    setState(() {
      final group = _groups.firstWhere((g) => g.name == groupName,
          orElse: () => OptionGroup(name: groupName));
      group.options.removeWhere((opt) => opt.value == value);
      widget.onGroupsChanged(_groups);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._groups.map((group) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 그룹 헤더: 편집 가능한 그룹명과 삭제 버튼
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: group.name),
                      decoration: const InputDecoration(
                        labelText: "옵션 그룹 이름",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (newName) {
                        _updateOptionGroupName(group.name, newName);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeOptionGroup(group.name),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 그룹 내 옵션 값들을 Chip으로 표시 (추가 정보 포함)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: group.options.map((opt) {
                  return Chip(
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(opt.value),
                        Text(
                          "Stock: ${opt.stock}, Extra: ${opt.extraPrice}",
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                    onDeleted: () => _removeOptionValue(group.name, opt.value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              // 옵션 값 추가 버튼
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final TextEditingController valueController =
                          TextEditingController();
                      final TextEditingController stockController =
                          TextEditingController();
                      final TextEditingController extraPriceController =
                          TextEditingController();
                      return AlertDialog(
                        title: const Text("옵션 값 추가"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: valueController,
                              decoration:
                                  const InputDecoration(labelText: "옵션 값"),
                            ),
                            TextField(
                              controller: stockController,
                              decoration:
                                  const InputDecoration(labelText: "재고"),
                              keyboardType: TextInputType.number,
                            ),
                            TextField(
                              controller: extraPriceController,
                              decoration:
                                  const InputDecoration(labelText: "추가금액"),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("취소")),
                          TextButton(
                              onPressed: () {
                                final value = valueController.text.trim();
                                final stock =
                                    int.tryParse(stockController.text.trim()) ??
                                        0;
                                final extraPrice = int.tryParse(
                                        extraPriceController.text.trim()) ??
                                    0;
                                if (value.isNotEmpty) {
                                  _addOptionValue(
                                      group.name, value, stock, extraPrice);
                                }
                                Navigator.pop(context);
                              },
                              child: const Text("추가")),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("옵션 값 추가"),
              ),
              const Divider(),
            ],
          );
        }).toList(),
        // 새로운 옵션 그룹 추가 버튼
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final TextEditingController groupController =
                    TextEditingController();
                return AlertDialog(
                  title: const Text("새 옵션 그룹 추가"),
                  content: TextField(
                    controller: groupController,
                    decoration: const InputDecoration(labelText: "옵션 그룹 이름"),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("취소")),
                    TextButton(
                        onPressed: () {
                          final groupName = groupController.text.trim();
                          if (groupName.isNotEmpty &&
                              !_groups.any((g) => g.name == groupName)) {
                            _addOptionGroup(groupName);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("추가")),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.add),
          label: const Text("새 옵션 그룹 추가"),
        ),
      ],
    );
  }
}
