# 年货购置计划应用

一个用于安排和提醒过年期间购置年货的跨平台应用（iOS + Android）。

## 功能特性

1. **年货计划管理** - 列表展示所有年货购置计划，支持待完成和已完成分类
2. **自定义计划** - 支持用户添加自定义年货项目
3. **习俗模板** - 预设中国传统过年习俗年货计划（如：对联、灯笼、年糕、糖果、坚果等）
4. **详细评估** - 每项计划包含：
   - 人力评估（所需人力、时间）
   - 物理评估（存储空间、运输方式）
   - 财力评估（预算范围）
   - 详细说明
5. **提醒功能** - 设置购置时间提醒
6. **本地数据持久化** - 数据保存在本地设备

## 技术栈

- **Flutter** - 跨平台UI框架
- **Provider** - 状态管理
- **shared_preferences** - 本地数据存储
- **flutter_local_notifications** - 本地通知提醒
- **intl** - 日期格式化

## 项目结构

```
lib/
├── main.dart                 # 应用入口
├── models/                   # 数据模型
│   ├── assessment.dart      # 评估信息模型
│   └── goods_plan.dart      # 年货计划模型
├── providers/               # 状态管理
│   └── goods_plan_provider.dart
├── screens/                 # 页面
│   ├── home_screen.dart          # 主页面
│   ├── add_plan_screen.dart      # 添加计划页面
│   ├── plan_detail_screen.dart   # 计划详情页面
│   └── template_selection_screen.dart  # 模板选择页面
└── utils/                   # 工具类
    ├── default_templates.dart   # 默认模板数据
    ├── storage_service.dart     # 存储服务
    └── notification_service.dart # 通知服务
```

## 运行应用

### 前置要求

- Flutter SDK (3.0.0 或更高版本)
- Android Studio / Xcode
- 对于 iOS：macOS 和 Xcode
- 对于 Android：Android SDK 和模拟器/真机

### 安装依赖

```bash
cd new_year_goods_planner
flutter pub get
```

### 运行应用

```bash
# 运行在所有连接的设备
flutter run

# 运行在特定设备
flutter run -d <device_id>

# 运行在Android模拟器
flutter run -d android

# 运行在iOS模拟器（仅macOS）
flutter run -d ios
```

### 构建应用

```bash
# 构建Android APK
flutter build apk

# 构建Android App Bundle
flutter build appbundle

# 构建iOS应用（仅macOS）
flutter build ios
```

## 使用说明

1. **首次启动** - 应用会自动加载预设的习俗年货模板
2. **添加计划** - 点击右下角的"+"按钮添加自定义计划
3. **使用模板** - 在主页面点击"添加模板"按钮从习俗模板中选择
4. **查看详情** - 点击任意计划卡片查看详细评估信息
5. **设置提醒** - 在详情页面点击"设置提醒"按钮设置购置时间提醒
6. **标记完成** - 在详情页面点击"标记为已完成"按钮
7. **删除计划** - 在详情页面点击右上角的删除图标

## 预设习俗模板

应用包含以下传统年货模板：

1. **春联** - 装饰用品，预算50-200元
2. **灯笼** - 装饰用品，预算100-500元
3. **年糕** - 食品，预算50-300元
4. **糖果** - 食品，预算100-500元
5. **坚果** - 食品，预算100-400元
6. **红包** - 礼品，预算50-200元
7. **烟花爆竹** - 娱乐用品，预算200-1000元
8. **新衣服** - 服装，预算500-3000元
9. **水果** - 食品，预算200-800元
10. **酒水饮料** - 食品，预算300-1500元

每个模板都包含详细的人力、物理、财力评估和购买建议。

## 主题设计

- **主色调**：红色（#D32F2F）- 象征春节喜庆氛围
- **辅助色**：橙色 - 增添温暖感
- **设计风格**：Material Design 3.0
- **卡片式布局**：清晰展示信息
- **渐变背景**：提升视觉效果

## 权限说明

- **Android**:
  - `POST_NOTIFICATIONS` - 发送通知提醒
  - `SCHEDULE_EXACT_ALARM` - 精确闹钟权限
  - `USE_EXACT_ALARM` - 使用精确闹钟

- **iOS**:
  - 通知权限 - 发送本地通知

## 注意事项

1. 首次使用时需要授予通知权限才能使用提醒功能
2. 数据保存在本地设备，卸载应用后数据会丢失
3. 提醒功能依赖于系统通知设置，请确保通知已开启
4. Android 12+ 需要手动授予通知权限

## 许可证

本项目仅供学习和个人使用。

## 作者

iFlow CLI