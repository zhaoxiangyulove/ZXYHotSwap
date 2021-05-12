import ZXYModuleProtocols

public struct ZXYModuleBImp {
  public init() {
  }
}

extension ZXYModuleBImp: ZXYModuleB {
  public func printMsg() {
    print("[Module B] ModuleB's instance work")
  }
}
