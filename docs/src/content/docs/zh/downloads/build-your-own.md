---
title: "建立你自己的"
---

1. 安装 git 和 flotter (测试版)
2. 复制资源库
3. 导航到应用目录
4. 使用流体工具编译应用程序
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. 编译的文件在构建目录
