import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/goods_plan_provider.dart';
import '../utils/default_templates.dart';

class TemplateSelectionScreen extends StatefulWidget {
  const TemplateSelectionScreen({super.key});

  @override
  State<TemplateSelectionScreen> createState() => _TemplateSelectionScreenState();
}

class _TemplateSelectionScreenState extends State<TemplateSelectionScreen> {
  final Set<String> _selectedTemplates = {};

  @override
  Widget build(BuildContext context) {
    final templates = DefaultTemplates.getTraditionalTemplates();

    return Scaffold(
      appBar: AppBar(
        title: const Text('选择习俗模板'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: _selectedTemplates.isEmpty
                ? null
                : () => _addSelectedTemplates(),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              '添加',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              backgroundColor: _selectedTemplates.isEmpty
                  ? Colors.grey
                  : Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final template = templates[index];
          final isSelected = _selectedTemplates.contains(template.id);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            elevation: isSelected ? 4 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isSelected
                  ? BorderSide(color: Colors.red[700]!, width: 2)
                  : BorderSide.none,
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedTemplates.remove(template.id);
                  } else {
                    _selectedTemplates.add(template.id);
                  }
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.red[700]
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(template.category),
                        color: isSelected ? Colors.white : Colors.red[700],
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            template.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.red[700] : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  template.category,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red[700],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.attach_money,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                template.assessment.financial,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedTemplates.add(template.id);
                          } else {
                            _selectedTemplates.remove(template.id);
                          }
                        });
                      },
                      activeColor: Colors.red[700],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _selectedTemplates.isEmpty
            ? null
            : () => _addSelectedTemplates(),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('添加 ${_selectedTemplates.length} 项'),
      ),
    );
  }

  void _addSelectedTemplates() {
    final provider = Provider.of<GoodsPlanProvider>(context, listen: false);
    final templates = DefaultTemplates.getTraditionalTemplates();

    for (var template in templates) {
      if (_selectedTemplates.contains(template.id)) {
        provider.addFromTemplate(template);
      }
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已添加 ${_selectedTemplates.length} 个年货计划'),
        backgroundColor: Colors.green,
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '装饰用品':
        return Icons.celebration;
      case '食品':
        return Icons.restaurant;
      case '礼品':
        return Icons.card_giftcard;
      case '娱乐用品':
        return Icons.toys_and_games;
      case '服装':
        return Icons.checkroom;
      default:
        return Icons.category;
    }
  }
}