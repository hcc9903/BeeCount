# App Center 构建配置
# 保存为: appcenter-pre-build.sh（放在项目根目录）

#!/usr/bin/env bash
# App Center Pre-Build Script

# 设置 Flutter 版本
FLUTTER_VERSION="3.27.3"

# 安装 Flutter
if [ -z "$CI" ]; then
    echo "Not in CI environment"
    exit 0
fi

echo "Setting up Flutter $FLUTTER_VERSION..."
git clone -b stable https://github.com/flutter/flutter.git $APPCENTER_BUILD_REPOSITORY/flutter
cd $APPCENTER_BUILD_REPOSITORY/flutter
git checkout $FLUTTER_VERSION

# 添加到 PATH
export PATH=$PATH:$APPCENTER_BUILD_REPOSITORY/flutter/bin

# 验证安装
flutter --version
flutter doctor

# 获取依赖
cd $APPCENTER_BUILD_REPOSITORY
flutter pub get

# 升级依赖（可选）
# flutter pub upgrade

echo "Pre-build setup completed!"
