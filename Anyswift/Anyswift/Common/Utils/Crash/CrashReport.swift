//
//  CrashReport.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

#if canImport(SmartCodable)
import SmartCodable

struct CrashReport : SmartCodable {

    var binary_images: [BinaryImages] = []
    var crash: Crash = Crash()
    var debug: Debug = Debug()
    var process: Process = Process()
    var report: Report = Report()
    var system: System = System()
    var user: User = User()
}

extension CrashReport {
    
    struct User : SmartCodable {
        
    }
    
    struct System : SmartCodable {
        
        var CFBundleExecutable: String = ""
        var CFBundleExecutablePath: String = ""
        var CFBundleIdentifier: String = ""
        var CFBundleName: String = ""
        var CFBundleShortVersionString: String = ""
        var CFBundleVersion: String = ""
        var app_memory: AppMemory = AppMemory()
        var app_start_time: String = ""
        var app_uuid: String = ""
        var application_stats: ApplicationStats = ApplicationStats()
        var binary_cpu_subtype: Int = 0
        var binary_cpu_type: Int = 0
        var build_type: String = ""
        var cpu_arch: String = ""
        var cpu_subtype: Int = 0
        var cpu_type: Int = 0
        var device_app_hash: String = ""
        var jailbroken: Bool = false
        var kernel_version: String = ""
        var machine: String = ""
        var memory: Memory = Memory()
        var model: String = ""
        var os_version: String = ""
        var parent_process_id: Int = 0
        var process_id: Int = 0
        var process_name: String = ""
        var storage: Int = 0
        var system_name: String = ""
        var system_version: String = ""
        var time_zone: String = ""
    }
    
    struct Memory : SmartCodable {
        
        var free: Int = 0
        var size: Int = 0
        var usable: Int = 0
    }
    
    struct ApplicationStats : SmartCodable {
        
        var active_time_since_last_crash: Double = 0.0
        var active_time_since_launch: Double = 0.0
        var application_active: Bool = false
        var application_in_foreground: Bool = false
        var background_time_since_last_crash: Double = 0.0
        var background_time_since_launch: Double = 0.0
        var launches_since_last_crash: Int = 0
        var sessions_since_last_crash: Int = 0
        var sessions_since_launch: Int = 0
    }
    
    struct AppMemory : SmartCodable {
        
        var app_transition_state: String = ""
        var memory_footprint: Int = 0
        var memory_level: String = ""
        var memory_limit: Int = 0
        var memory_pressure: String = ""
        var memory_remaining: Int = 0
    }
    
    struct Report : SmartCodable {
        
        var id: String = ""
        var process_name: String = ""
        var timestamp: String = ""
        var type: String = ""
        var version: String = ""
    }
    
    struct Process : SmartCodable {
        
    }
    
    struct Debug : SmartCodable {
        
    }
    
    struct Crash : SmartCodable {
        
        var error: Error = Error()
        var threads: [Threads] = []
    }
    
    struct Threads : SmartCodable {
        
        var backtrace: Backtrace = Backtrace()
        var crashed: Bool = false
        var current_thread: Bool = false
        var index: Int = 0
        var registers: Registers = Registers()
        var stack: Stack = Stack()
    }
    
    struct Stack : SmartCodable {
        
        var contents: String = ""
        var dump_end: Int = 0
        var dump_start: Int = 0
        var grow_direction: String = ""
        var overflow: Bool = false
        var stack_pointer: Int = 0
    }
    
    struct Registers : SmartCodable {
        
        var basic: Basic = Basic()
        var exception: Exception = Exception()
    }
    
    struct Exception : SmartCodable {
        
        var err: Int = 0
        var faultvaddr: Int = 0
        var trapno: Int = 0
    }
    
    struct Basic : SmartCodable {
        
        var cs: Int = 0
        var fs: Int = 0
        var gs: Int = 0
        var r10: Int = 0
        var r11: Int = 0
        var r12: Int = 0
        var r13: Int = 0
        var r14: Int = 0
        var r15: Int = 0
        var r8: Int = 0
        var r9: Int = 0
        var rax: Int = 0
        var rbp: Int = 0
        var rbx: Int = 0
        var rcx: Int = 0
        var rdi: Int = 0
        var rdx: Int = 0
        var rflags: Int = 0
        var rip: Int = 0
        var rsi: Int = 0
        var rsp: Int = 0
    }
    
    struct Backtrace : SmartCodable {
        
        var contents: [Contents] = []
        var skipped: Int = 0
    }
    
    struct Contents : SmartCodable {
        
        var instruction_addr: Int = 0
        var object_addr: Int = 0
        var object_name: String = ""
        var symbol_addr: Int = 0
        var symbol_name: String = ""
    }
    
    struct Error : SmartCodable {
        
        var address: Int = 0
        var mach: Mach = Mach()
        var signal: Signal = Signal()
        var type: String = ""
    }

    struct Signal : SmartCodable {
        
        var code: Int = 0
        var code_name: String = ""
        var name: String = ""
        var signal: Int = 0
    }
    
    struct Mach : SmartCodable {
        
        var code: Int = 0
        var code_name: String = ""
        var exception: Int = 0
        var exception_name: String = ""
        var subcode: Int = 0
    }
    
    struct BinaryImages : SmartCodable {
        
        var cpu_subtype: Int = 0
        var cpu_type: Int = 0
        var image_addr: Int = 0
        var image_size: Int = 0
        var image_vmaddr: Int = 0
        var major_version: Int = 0
        var minor_version: Int = 0
        var name: String = ""
        var revision_version: Int = 0
        var uuid: String = ""
        var crash_info_message: String = ""
    }
    
}
#endif
