# ReleaseDependencies
通过 `Package.swift` 统一管理 `Package Dependencies`，用 `@_exported` 暴露给外部使用。
``` swift
@_exported import Moya
@_exported import CocoaLumberjack
```
