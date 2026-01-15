import 'package:flutter/foundation.dart';
import '../models/goods_plan.dart';
import '../utils/default_templates.dart';
import '../utils/storage_service.dart';

class GoodsPlanProvider with ChangeNotifier {
  List<GoodsPlan> _plans = [];
  bool _isLoading = false;

  List<GoodsPlan> get plans => _plans;
  bool get isLoading => _isLoading;

  List<GoodsPlan> get completedPlans =>
      _plans.where((plan) => plan.isCompleted).toList();
  List<GoodsPlan> get pendingPlans =>
      _plans.where((plan) => !plan.isCompleted).toList();

  GoodsPlanProvider() {
    loadPlans();
  }

  Future<void> loadPlans() async {
    _isLoading = true;
    notifyListeners();
    try {
      _plans = await StorageService.loadPlans();
      if (_plans.isEmpty) {
        _plans = DefaultTemplates.getTraditionalTemplates();
        await StorageService.savePlans(_plans);
      }
    } catch (e) {
      debugPrint('加载计划失败: $e');
      _plans = DefaultTemplates.getTraditionalTemplates();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPlan(GoodsPlan plan) async {
    _plans.add(plan);
    await StorageService.savePlans(_plans);
    notifyListeners();
  }

  Future<void> updatePlan(GoodsPlan plan) async {
    final index = _plans.indexWhere((p) => p.id == plan.id);
    if (index != -1) {
      _plans[index] = plan;
      await StorageService.savePlans(_plans);
      notifyListeners();
    }
  }

  Future<void> deletePlan(String id) async {
    _plans.removeWhere((plan) => plan.id == id);
    await StorageService.savePlans(_plans);
    notifyListeners();
  }

  Future<void> toggleComplete(String id) async {
    final index = _plans.indexWhere((p) => p.id == id);
    if (index != -1) {
      _plans[index] = _plans[index].copyWith(
        isCompleted: !_plans[index].isCompleted,
      );
      await StorageService.savePlans(_plans);
      notifyListeners();
    }
  }

  Future<void> addFromTemplate(GoodsPlan template) async {
    final newPlan = GoodsPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: template.name,
      category: template.category,
      isCustom: true,
      targetDate: template.targetDate,
      isCompleted: false,
      assessment: template.assessment,
      createdAt: DateTime.now(),
    );
    await addPlan(newPlan);
  }

  List<GoodsPlan> getPlansByCategory(String category) {
    return _plans.where((plan) => plan.category == category).toList();
  }
}