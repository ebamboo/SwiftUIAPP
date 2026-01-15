import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/goods_plan_provider.dart';
import '../models/assessment.dart';
import '../utils/default_templates.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({super.key});

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _manpowerController = TextEditingController();
  final _manpowerDetailController = TextEditingController();
  final _physicalController = TextEditingController();
  final _physicalDetailController = TextEditingController();
  final _financialController = TextEditingController();
  final _financialDetailController = TextEditingController();
  final _detailDescriptionController = TextEditingController();

  DateTime? _targetDate;
  String _selectedCategory = '食品';

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _manpowerController.dispose();
    _manpowerDetailController.dispose();
    _physicalController.dispose();
    _physicalDetailController.dispose();
    _financialController.dispose();
    _financialDetailController.dispose();
    _detailDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      setState(() {
        _targetDate = picked;
      });
    }
  }

  void _savePlan() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<GoodsPlanProvider>(context, listen: false);
      final plan = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text,
        'category': _selectedCategory,
        'isCustom': true,
        'targetDate': _targetDate?.toIso8601String(),
        'isCompleted': false,
        'assessment': {
          'manpower': _manpowerController.text,
          'manpowerDetail': _manpowerDetailController.text,
          'physical': _physicalController.text,
          'physicalDetail': _physicalDetailController.text,
          'financial': _financialController.text,
          'financialDetail': _financialDetailController.text,
          'detailDescription': _detailDescriptionController.text,
        },
        'createdAt': DateTime.now().toIso8601String(),
      };

      provider.addPlan({
        'id': plan['id'] as String,
        'name': plan['name'] as String,
        'category': plan['category'] as String,
        'isCustom': plan['isCustom'] as bool,
        'targetDate': plan['targetDate'] != null
            ? DateTime.parse(plan['targetDate'] as String)
            : null,
        'isCompleted': plan['isCompleted'] as bool,
        'assessment': Assessment.fromJson(plan['assessment'] as Map<String, dynamic>),
        'createdAt': DateTime.parse(plan['createdAt'] as String),
      } as dynamic);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('计划添加成功')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加年货计划'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '基本信息',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: '年货名称',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory_2),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入年货名称';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: '分类',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                      items: DefaultTemplates.getCategories()
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: _selectDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: '目标日期',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _targetDate != null
                              ? DateFormat('yyyy年MM月dd日').format(_targetDate!)
                              : '选择日期',
                          style: TextStyle(
                            color: _targetDate != null ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '人力评估',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _manpowerController,
                      decoration: const InputDecoration(
                        labelText: '所需人力',
                        border: OutlineInputBorder(),
                        hintText: '例如：1人、2人等',
                        prefixIcon: Icon(Icons.people),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _manpowerDetailController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '人力详情',
                        border: OutlineInputBorder(),
                        hintText: '详细说明所需人力和时间',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '物理评估',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _physicalController,
                      decoration: const InputDecoration(
                        labelText: '占用空间',
                        border: OutlineInputBorder(),
                        hintText: '例如：占用空间小、占用空间中等',
                        prefixIcon: Icon(Icons.storage),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _physicalDetailController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '物理详情',
                        border: OutlineInputBorder(),
                        hintText: '详细说明存储和运输要求',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '财力评估',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _financialController,
                      decoration: const InputDecoration(
                        labelText: '预算范围',
                        border: OutlineInputBorder(),
                        hintText: '例如：50-200元',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _financialDetailController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '财力详情',
                        border: OutlineInputBorder(),
                        hintText: '详细说明费用构成和预算建议',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '详细说明',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _detailDescriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: '详细描述',
                        border: OutlineInputBorder(),
                        hintText: '详细说明该年货的用途、购买建议等',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _savePlan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '保存计划',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}