import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/goods_plan_provider.dart';
import '../models/goods_plan.dart';
import 'add_plan_screen.dart';
import 'plan_detail_screen.dart';
import 'template_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('年货购置计划'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _selectedIndex == 0 ? _buildPendingPlans() : _buildCompletedPlans(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlanScreen()),
          );
        },
        backgroundColor: Colors.red[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: '待完成',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: '已完成',
          ),
        ],
        selectedItemColor: Colors.red[700],
      ),
    );
  }

  Widget _buildPendingPlans() {
    return Consumer<GoodsPlanProvider>(
      builder: (context, provider, child) {
        final plans = provider.pendingPlans;
        
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (plans.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  '暂无年货计划',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TemplateSelectionScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.playlist_add),
                  label: const Text('从习俗模板添加'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.red[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '待完成: ${plans.length} 项',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TemplateSelectionScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.playlist_add, size: 18),
                    label: const Text('添加模板'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red[700],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return _buildPlanCard(plans[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCompletedPlans() {
    return Consumer<GoodsPlanProvider>(
      builder: (context, provider, child) {
        final plans = provider.completedPlans;
        
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (plans.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  '暂无已完成的计划',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.green[50],
              child: Text(
                '已完成: ${plans.length} 项',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return _buildPlanCard(plans[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlanCard(GoodsPlan plan) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanDetailScreen(plan: plan),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getCategoryIcon(plan.category),
                  color: Colors.red[700],
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                            plan.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red[700],
                            ),
                          ),
                        ),
                        if (plan.targetDate != null) ...[
                          const SizedBox(width: 8),
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(plan.targetDate!),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Checkbox(
                value: plan.isCompleted,
                onChanged: (value) {
                  Provider.of<GoodsPlanProvider>(context, listen: false)
                      .toggleComplete(plan.id);
                },
                activeColor: Colors.red[700],
              ),
            ],
          ),
        ),
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
        return.toys_and_games;
      case '服装':
        return Icons.checkroom;
      default:
        return Icons.category;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month}月${date.day}日';
  }
}