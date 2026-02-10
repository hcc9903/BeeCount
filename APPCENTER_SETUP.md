# App Center 配置指南

## 步骤 1: 注册并登录

1. 访问: https://appcenter.ms
2. 使用 Microsoft 账号或 GitHub 账号登录
3. 完全免费，无需信用卡

## 步骤 2: 创建应用

1. 点击 "Add new" → "Add new app"
2. 填写信息：
   - **App name**: BeeCount
   - **OS**: Android
   - **Platform**: Flutter
   - **Release Type**: Production

## 步骤 3: 连接 GitHub

1. 在左侧菜单选择 "Build"
2. 选择 "GitHub"
3. 授权并选择您的仓库: `hcc9903/BeeCount`
4. 分支选择: `main`

## 步骤 4: 配置构建设置

### 构建设置：
- **Project**: `android/app/build.gradle`
- **Build Variant**: `release`
- **Build scripts**: 启用 "Post-build scripts"

### 环境变量（可选）：
如果需要签名：
- `SIGNING_KEY_PASSWORD`: 您的密钥密码
- `SIGNING_KEY_ALIAS`: 密钥别名
- `SIGNING_KEY`: Base64 编码的密钥文件（在 App Center 上传）

## 步骤 5: 自动构建触发

选择触发方式：
- ✅ **Automatically build this branch on every push**（推荐）
- ✅ **Build this branch when a pull request is merged**

## 步骤 6: 开始构建

1. 点击 "Save & Build"
2. 第一次构建可能需要 15-20 分钟（下载 Flutter SDK）
3. 后续构建 5-10 分钟

## 步骤 7: 下载 APK

构建完成后：
1. 点击 "Build" 标签
2. 找到成功的构建
3. 点击 "Download" → 下载 APK 文件

## 额外功能

### 自动分发测试：
1. 在构建设置中启用 "Distribute builds"
2. 选择测试组
3. 每次构建成功后自动发送给测试人员

### 崩溃分析：
1. 安装 App Center SDK（已集成）
2. 自动收集崩溃报告
3. 查看实时统计数据

## 优势对比

| 功能 | App Center | GitHub Actions |
|-----|-----------|----------------|
| 价格 | ✅ 完全免费 | 每月2000分钟 |
| Flutter 支持 | ✅ 官方支持 | 需手动配置 |
| 构建速度 | ⚡ 快（专用服务器）| 一般 |
| 分发测试 | ✅ 内置 | 需额外配置 |
| 崩溃分析 | ✅ 内置 | 无 |
| 配置难度 | ⭐ 简单 | ⭐⭐⭐ 复杂 |

## 常见问题

**Q: 构建失败怎么办？**
A: 查看 "Build Logs"，通常是：
- 内存不足（增加 gradle.properties 中的 -Xmx 值）
- Flutter 版本不匹配（在 pre-build 脚本中指定版本）

**Q: 如何签名 APK？**
A: 
1. 在 App Center 上传 keystore 文件
2. 在构建设置中启用 "Sign builds"
3. 填写密钥别名和密码

**Q: 可以同时构建 iOS 吗？**
A: 可以！创建新应用选择 iOS 平台，同样配置即可。

## 配置文件说明

已创建文件：`appcenter-pre-build.sh`
- 自动安装 Flutter 3.27.3
- 设置环境变量
- 获取项目依赖

如需修改 Flutter 版本，编辑此文件即可。
