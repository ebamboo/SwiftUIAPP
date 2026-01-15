import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/goods_plan.dart';

class StorageService {
  static const String _plansKey = 'goods_plans';

  static Future<void> savePlans(List<GoodsPlan> plans) async {
    final prefs = await SharedPreferences.getInstance();
    final plansJson = plans.map((plan) => plan.toJson()).toList();
    await prefs.setString(_plansKey, json.encode(plansJson));
  }

  static Future<List<GoodsPlan>> loadPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final plansJson = prefs.getString(_plansKey);
    if (plansJson == null) return [];
    
    try {
      final List<dynamic> decoded = json.decode(plansJson);
      return decoded.map((json) => GoodsPlan.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}