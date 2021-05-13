import ZXYModuleProtocols
import ZXYDIManager

public class ZXYModuleCImp {
  @Injected var moduleA: ZXYModuleA?
  @Injected var moduleB: ZXYModuleB?
  public init() {
  }
}

extension ZXYModuleCImp: ZXYModuleC {
  public func printMsg() {
    if let moduleA = moduleA {
      moduleA.printMsg()
    } else {
      print("[Module C] ModuleA's instance not find, go on")
    }
    if let moduleB = moduleB {
      moduleB.printMsg()
    } else {
      print("[Module C] ModuleB's instance not find, go on")
    }
    print("[Module C] ModuleC's instance work")
  }
}
