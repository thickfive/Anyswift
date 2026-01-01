# SwiftGen 使用方式

## 手动安装
不能通过 Swift Package Manager 直接安装使用, 需要手动安装可执行文件 bin/swiftgen

### 1. 下载安装, 设置权限
下载解压安装到指定目录, 打开 bin/swiftgen 查看是否有执行权限, 如果没有需要到 `系统设置 > 隐私与安全性 > 允许以下来源的应用程序` 选择 `仍要打开` 

### 2. 在 `TARGETS > $TARGET_NAME > Build Phases` 中添加 `Run Script`
```
SWIFT_GEN_EXECUTABLE="${PROJECT_DIR}/${TARGET_NAME}/Resources/SwiftGen/swiftgen-6.6.3/bin/swiftgen"
SWIFT_GEN_CONFIG="${PROJECT_DIR}/${TARGET_NAME}/Resources/SwiftGen/Config/swiftgen.yml"
if [[ -f "$SWIFT_GEN_EXECUTABLE" ]]; then
  "$SWIFT_GEN_EXECUTABLE" config run -c "$SWIFT_GEN_CONFIG"
else
  echo "warning: SwiftGen is not installed. Run 'pod install --repo-update' to install it."
fi
```
### 3. `TARGETS > $TARGET_NAME > Build Settings > User Script Sandboxing` 设置为 `No` 

## 通过 CocoaPods 安装

### 1. 通过 pod 安装 SwiftGen
``` 
pod 'SwiftGen', '~> 6.0'
```

### 2. 在 `TARGET - Build Phases` 中添加 `Run Script`
必须指定正确的可执行程序和配置文件目录
```
if [[ -f "${PODS_ROOT}/SwiftGen/bin/swiftgen" ]]; then
  $PODS_ROOT/SwiftGen/bin/swiftgen config run -c $PROJECT_DIR/$TARGET_NAME/SwiftGen/Config/swiftgen.yml
else
  echo "warning: SwiftGen is not installed. Run 'pod install --repo-update' to install it."
fi
```

## 配置文件 `swiftgen.yml`
```
## Note: all of the config entries below are just examples with placeholders. Be sure to edit and adjust to your needs when uncommenting.

## In case your config entries all use a common input/output parent directory, you can specify those here.
##   Every input/output paths in the rest of the config will then be expressed relative to these.
##   Those two top-level keys are optional and default to "." (the directory of the config file).
input_dir: ../
output_dir: ../Classes/

## Generate constants for your localized strings.
##   Be sure that SwiftGen only parses ONE locale (typically Base.lproj, or en.lproj, or whichever your development region is); otherwise it will generate the same keys multiple times.
##   SwiftGen will parse all `.strings` files found in that folder.
strings:
  inputs:
    - en.lproj
  outputs:
    - templateName: structured-swift5
      output: Strings+Generated.swift


## Generate constants for your Assets Catalogs, including constants for images, colors, ARKit resources, etc.
##   This example also shows how to provide additional parameters to your template to customize the output.
##   - Especially the `forceProvidesNamespaces: true` param forces to create sub-namespace for each folder/group used in your Asset Catalogs, even the ones without "Provides Namespace". Without this param, SwiftGen only generates sub-namespaces for folders/groups which have the "Provides Namespace" box checked in the Inspector pane.
##   - To know which params are supported for a template, use `swiftgen template doc xcassets swift5` to open the template documentation on GitHub.
xcassets:
- inputs: Assets.xcassets
  outputs:
    output: Assets+Generated.swift
    templateName: swift5
    params:
      publicAccess: true
      forceProvidesNamespaces: true
      enumName: Assets
- inputs: Colors.xcassets
  outputs:
    output: Colors+Generated.swift
    templateName: swift5
    params:
      publicAccess: true
      forceProvidesNamespaces: true
      enumName: Colors # 存在多个输出时, 需要指定 enumName 避免符号重复
    

## Generate constants for your storyboards and XIBs.
##   This one generates 2 output files, one containing the storyboard scenes, and another for the segues.
##    (You can remove the segues entry if you don't use segues in your IB files).
##   For `inputs` we can use "." here (aka "current directory", at least relative to `input_dir` = "MyLib/Sources"),
##    and SwiftGen will recursively find all `*.storyboard` and `*.xib` files in there.
# ib:
#   inputs:
#     - .
#   outputs:
#     - templateName: scenes-swift5
#       output: IB-Scenes+Generated.swift
#     - templateName: segues-swift5
#       output: IB-Segues+Generated.swift


## There are other parsers available for you to use depending on your needs, for example:
##  - `fonts` (if you have custom ttf/ttc font files)
##  - `coredata` (for CoreData models)
##  - `json`, `yaml` and `plist` (to parse custom JSON/YAML/Plist files and generate code from their content)
## …
##
## For more info, use `swiftgen config doc` to open the full documentation on GitHub.
## https://github.com/SwiftGen/SwiftGen/tree/6.6.3/Documentation/
```

## 编译项目
编译成功即可生成对应文件, 第一次生成的文件可能不在工程里, 需要手动添加才能使用  
不需要参与编译或者拷贝的文件, 特别是比较大的二进制文件 bin/swiftgen, 可以在右侧 `Target Membership` 点击 `-` 剔除

## 参考链接
1. [SwiftGen](https://github.com/SwiftGen/SwiftGen)
2. [SwiftGen Releases](https://github.com/SwiftGen/SwiftGen/releases/download/6.6.3/swiftgen-6.6.3.zip)
