# 🚀 微软 App Center 完整使用教程

## 第一步：注册账号（2分钟）

### 1.1 访问网站
打开浏览器，访问：
```
https://appcenter.ms
```

### 1.2 选择登录方式
- 点击页面右上角的 **"Sign in"**
- 选择 **"Sign in with GitHub"**（推荐，因为代码在 GitHub）
- 或选择 **"Sign in with Microsoft"**

### 1.3 授权登录
- 输入您的 GitHub/Microsoft 账号密码
- 授权 App Center 访问您的账号信息
- 完成注册！

---

## 第二步：创建应用（3分钟）

### 2.1 进入 Dashboard
登录后，点击左侧菜单 **"Overview"** 或页面中间的 **"Add new"** 按钮

### 2.2 添加新应用
点击下拉菜单，选择 **"Add new app"**

### 2.3 填写应用信息
按照以下填写：

| 字段 | 填写内容 | 说明 |
|-----|---------|------|
| **App name** | `BeeCount` | 应用名称 |
| **OS** | `Android` | 操作系统 |
| **Platform** | `Flutter` | 开发框架 |
| **Release Type** | `Production` | 发布类型 |

### 2.4 创建应用
点击 **"Add new app"** 按钮完成创建

---

## 第三步：连接 GitHub 仓库（5分钟）

### 3.1 进入 Build 页面
在左侧菜单中，点击 **"Build"** 选项

### 3.2 选择代码托管平台
点击 **"GitHub"** 图标（如果之前用 GitHub 登录，应该已经显示）

### 3.3 授权访问仓库
- 点击 **"Authorize Visual Studio App Center"**
- 在 GitHub 授权页面点击 **"Authorize microsoft"**
- 可能需要输入 GitHub 密码确认

### 3.4 选择仓库
- 在列表中找到 `hcc9903/BeeCount`
- 点击仓库名称选中
- 点击 **"Select repository"**

### 3.5 选择分支
- 在 Branch 下拉框选择 `main`
- 点击 **"Select branch"**

---

## 第四步：配置构建设置（5分钟）

### 4.1 设置 Build Variant
找到 **"Build Variant"** 选项：
- 选择 `release`（发布版本，体积小）
- 或选择 `debug`（调试版本，方便测试）

💡 **建议选 release**，APK 体积更小

### 4.2 配置 Build Scripts
向下滚动，找到 **"Build scripts"** 部分：

勾选以下选项：
- ✅ **Post-build scripts**

### 4.3 配置 Environment Variables（可选）
如果需要签名 APK，配置以下变量：

点击 **"Environment variables"** 旁边的 **"Add"**：

| Variable Name | Value | 说明 |
|-------------|-------|------|
| `GRADLE_OPTS` | `-Xmx6g` | 内存配置 |

### 4.4 配置 Build Triggers
找到 **"Build triggers"** 部分：

勾选以下选项：
- ✅ **Automatically build this branch on every push**（每次推送自动构建）
- ✅ **Build this branch when a pull request is merged**（PR 合并后自动构建）

---

## 第五步：开始构建（等待15-20分钟）

### 5.1 保存配置
点击页面下方的 **"Save & Build"** 按钮

### 5.2 等待首次构建
- 系统会开始下载 Flutter SDK（约 5-8 分钟）
- 然后下载项目依赖（约 3-5 分钟）
- 最后构建 APK（约 5-10 分钟）

### 5.3 查看构建进度
- 点击左侧菜单 **"Build"** → **"Builds"**
- 可以看到构建队列和进度
- 点击正在运行的构建查看实时日志

### 5.4 构建成功标志
看到以下信息表示成功：
```
✅ Build succeeded
Generating APK...  
Build successful
```

---

## 第六步：下载 APK（1分钟）

### 6.1 找到构建记录
- 在 **"Builds"** 页面
- 找到状态为 ✅ **Succeeded** 的构建

### 6.2 下载 APK
点击构建记录，向下滚动到 **"Artifacts"** 部分：

找到文件：`app-release.apk`

点击 **"Download"** 按钮下载到电脑

### 6.3 安装测试
- 将 APK 传到安卓手机
- 点击安装
- 开始使用蜜蜂记账！

---

## 第七步：设置自动分发（可选，2分钟）

### 7.1 进入 Distribute 页面
左侧菜单点击 **"Distribute"** → **"Groups"**

### 7.2 创建测试组
点击 **"New group"**：
- **Group name**: `测试团队`
- **Allow public access**: 勾选（方便分享）
- 点击 **"Create group"**

### 7.3 添加测试人员
- 点击创建的测试组
- 点击 **"Invite testers"**
- 输入测试人员的邮箱地址
- 点击 **"Add testers"**

### 7.4 自动分发设置
回到 **"Build"** 配置页面：
- 找到 **"Distribute builds"**
- 选择刚创建的测试组
- 保存设置

**效果**：每次构建成功后，自动邮件通知测试人员下载 APK

---

## 第八步：查看崩溃分析（高级功能）

### 8.1 集成 SDK（已在项目中配置）
您的项目已经集成了 App Center SDK，无需额外操作

### 8.2 查看崩溃报告
左侧菜单 **"Diagnostics"** → **"Issues"**
- 查看应用崩溃信息
- 查看错误堆栈
- 查看影响用户数

### 8.3 查看分析统计
左侧菜单 **"Analytics"** → **"Overview"**
- 活跃用户数
- 使用时长
- 地理位置分布
- 设备型号统计

---

## 常见问题解决

### ❌ 问题 1：构建失败显示 "Java heap space"
**解决**：增加内存配置
1. 在 Environment variables 添加：
   - Name: `GRADLE_OPTS`
   - Value: `-Xmx6g -XX:MaxMetaspaceSize=4g`

### ❌ 问题 2：找不到 Flutter 命令
**解决**：等待首次构建完成，系统会自动安装 Flutter

### ❌ 问题 3：构建超时（超过 30 分钟）
**解决**：
1. 点击 **"Cancel build"**
2. 重新点击 **"Build now"**
3. 或检查网络连接

### ❌ 问题 4：APK 无法安装
**解决**：
1. 检查是否开启了 **"未知来源应用"** 安装权限
2. 检查 APK 是否完整下载
3. 尝试重新构建

---

## 与其他方案对比

| 功能 | App Center | GitHub Actions | 本地构建 |
|-----|-----------|----------------|---------|
| **费用** | ✅ 免费 | 2000分钟/月 | 免费 |
| **配置难度** | ⭐ 简单 | ⭐⭐⭐ 复杂 | ⭐⭐⭐ 复杂 |
| **构建速度** | ⚡ 快 | 一般 | 看配置 |
| **成功率** | ⭐⭐⭐⭐⭐ 高 | ⭐⭐⭐ 一般 | ⭐⭐ 低 |
| **分发测试** | ✅ 内置 | ❌ 需额外配置 | ❌ 无 |
| **崩溃分析** | ✅ 内置 | ❌ 无 | ❌ 无 |
| **内存需求** | 云端 | 云端 | 16GB+ |
| **磁盘需求** | 云端 | 云端 | 50GB+ |

**结论**：App Center 是最适合您的方案！

---

## 现在就开始！

### ✅ 立即行动清单：
1. [ ] 访问 https://appcenter.ms
2. [ ] 用 GitHub 账号登录
3. [ ] 创建应用（按上面步骤填写）
4. [ ] 连接 hcc9903/BeeCount 仓库
5. [ ] 配置构建设置
6. [ ] 点击 "Save & Build"
7. [ ] 等待 15-20 分钟
8. [ ] 下载 APK 安装测试

---

## 需要帮助？

如果在配置过程中遇到问题：
1. 截图错误信息
2. 描述您的操作步骤
3. 发给我，我帮您解决！

**开始构建您的第一个 APK 吧！** 🚀
