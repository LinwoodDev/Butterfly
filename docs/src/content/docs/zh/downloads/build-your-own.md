---
title: 建立你自己的
---

1. 安装 git 和 flotter (测试版)
2. 复制资源库
3. 导航到应用目录
4. 使用流体工具编译应用程序
   - `flotter buildapk`
   - `flotter buildappbundle`
   - `flotter buildweb`
   - `flotter buildlinux`
   - `flotter buildwindows`
   - `flutter building ios --release --no-codesig`\
     在此后创建一个名为“Payload”的文件夹，复制Runner.app 到它并且zip payload文件夹。 然后将“.zip”重命名为“.ipa”。
5. 编译的文件在构建目录
