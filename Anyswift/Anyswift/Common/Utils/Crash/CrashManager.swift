//
//  CrashReport.swift
//  Mixing
//
//  Created by vvii on 2025/12/26.
//

#if canImport(KSCrash)
import Foundation
import KSCrash
import SmartCodable

/** CrashManager
 *  在 release 模式下崩溃日志没有 debug 详细, 关键信息缺失, 可能是内联函数优化导致的
 *  用 @inline(never) 修饰可能出问题的函数, 可以输出更多细节
 */
public class CrashManager {
    public static let shared = CrashManager()
    
    public func setup() {
        // 遇到系统调用显示为 <redacted> 如何处理
        // https://github.com/kstenerud/KSCrash/issues/86#issuecomment-185243609
        // https://github.com/Zuikyo/iOS-System-Symbols
        // 1. Build Settings - Debug Infomation Format - 设置为 DWARF with dSYM File，这样才能在编译产物目录拿到 dSYM 文件。Debug/Release 模式可以根据具体需要分别设置
        // 2. 以 Apple 格式发送崩溃日志
        // 3. 用 dSYM 文件和 Apple 格式崩溃日志手动解析即可
        #if DEBUG
        setupCrashInstallation(crashInstallationStandard())
        logCrashReportInfo()
        #else
        setupCrashInstallation(crashInstallationEmail())
        #endif
    }
    
    /// 不同的 CrashInstallation 有各自默认的 filters 设置方式，不能随意添加
    /// - Parameter installation: CrashInstallation
    func setupCrashInstallation(_ installation: CrashInstallation) {
        // Optional: Add an alert confirmation (recommended for email installation)
        installation.addConditionalAlert(
            withTitle: "Crash Detected",
            message: "The app crashed last time it was launched. Send a crash report?",
            yesAnswer: "Sure!",
            noAnswer: "No thanks"
        )

        // Install the crash reporting system
        let config = KSCrashConfiguration()
        config.monitors = [.all] //[.machException, .signal]
        // .onSuccess 会被内部修改为 .always, 因此只有 .never 一个额外选项
        config.reportStoreConfiguration.reportCleanupPolicy = .always
        do {
            try installation.install(with: config) // set `nil` for default config
            installation.sendAllReports()
        } catch {
            Log.error(error, tag: .crash)
        }
    }
    
    func crashInstallationEmail() -> CrashInstallationEmail {
        let installation = CrashInstallationEmail.shared
        installation.recipients = ["email@example.com"]
        installation.setReportStyle(.apple, useDefaultFilenameFormat: true)
        return installation
    }
    
    func crashInstallationStandard() -> CrashInstallationStandard {
        let installation = CrashInstallationStandard.shared
        installation.url = URL(string: "https://www.example.com/crash")!
        // Optional: 以 Apple 格式发送崩溃日志
        let filter = CrashReportFilterAppleFmt.init(reportStyle: AppleReportStyle.symbolicatedSideBySide)
        installation.addPreFilter(filter)
        return installation
    }
    
    func logCrashReportInfo() {
        if let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first, let bundleName = Bundle.main.infoDictionary?["CFBundleName"] {
            let reportsDirectoryPath = "\(cachesDirectory)/KSCrash/\(bundleName)/Reports"
            if let reportsDirectoryUrl = URL(string: reportsDirectoryPath) {
                do {
                    let reportUrls = try FileManager.default.contentsOfDirectory(at: reportsDirectoryUrl, includingPropertiesForKeys: [.creationDateKey])
                    reportUrls
                        .map({ (url: $0, date: try! $0.resourceValues(forKeys: [.creationDateKey]).creationDate!) })
                        .sorted(by: { $0.date < $1.date })
                        .filter({ $0.date > Date(timeIntervalSince1970: 0) })
                        .forEach { (url: URL, date: Date) in
                            do {
                                let data = try Data(contentsOf: url)
                                // let jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                                if let report = CrashReport.deserialize(from: data) {
                                    let crash_info_message = report.binary_images.map({ $0.crash_info_message }).filter({ !$0.isEmpty })
                                    let crash_threads = report.crash.threads.filter({ $0.crashed }).map({ $0.toJSONString(prettyPrint: true) }).compactMap({ $0 })
                                    let crash_report_info = [crash_info_message, crash_threads].flatMap({ $0 }).joined(separator: "\n")
                                    Log.error(crash_report_info)
                                }
                            } catch {
                                Log.error(error)
                            }
                        }
                } catch {
                    Log.error(error)
                }
            }
        }
    }
}
#else
import Foundation

public class CrashManager {
    public static let shared = CrashManager()
    
    public func setup() {
    }
}
#endif

