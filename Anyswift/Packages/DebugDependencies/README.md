# DebugDependencies
通过 `Run Script` 根据不同编译条件, 生成不同的 `Package.swift`, 从而实现自动添加或者移除依赖. 统一管理, 比修改 `EXCLUDED_SOURCE_FILE_NAMES` 方便

## 使用方式
1. `PROJECT > Package Dependencies > Add Local` 中添加 `Packages/DebugDependencies`

2. `TARGETS > $TARGET_NAME > Build Phases` 中添加 `Run Script`
``` shell
DEBUG_PACKAGE_DIR="${PROJECT_DIR}/Packages/DebugDependencies"
if [ "$CONFIGURATION" = "Debug" ]; then
    echo "CONFIGURATION = $CONFIGURATION"
    cat "$DEBUG_PACKAGE_DIR/Package@debug.swift" > "$DEBUG_PACKAGE_DIR/Package.swift"
else
    echo "CONFIGURATION = $CONFIGURATION"
    cat "$DEBUG_PACKAGE_DIR/Package@release.swift" > "$DEBUG_PACKAGE_DIR/Package.swift"
fi
```

3. `TARGETS > $TARGET_NAME > Build Settings > User Script Sandboxing` 设置为 `No`

4. 主工程中使用(可选)
``` swift
import DebugDependencies

func setup() {
    DebugDependencies.shared.setup()
}
```

## 注意事项
⚠️ 修改 scheme 后, 需要 `Product > Clean Build Folder (⇧⌘K)` 清除缓存重新编译, 然后再运行, 不能直接运行  
⚠️ 直接运行只是在编译完成后修改了 `Package.swift`, Xcode 还来不及导入/删除相关依赖, 编译和运行分开是比较推荐的做法 
- 第一次编译触发 `Swift Package Manager` 的 `Reload Package 'DebugDependencies'`
- 第二次编译就能导入/删除相关依赖   

⚠️ 如果不清楚相关依赖是否会对上架包产生影响, 建议上架打包前在 `PROJECT > Package Dependencies` 中去掉 `Packages/DebugDependencies`  
