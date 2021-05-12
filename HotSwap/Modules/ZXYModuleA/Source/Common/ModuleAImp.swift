import ZXYModuleProtocols

public struct ZXYModuleAImp {
  public init() {
  }
}

extension ZXYModuleAImp: ZXYModuleA {
  public func printMsg() {
    print("[Module A] ModuleA's instance work")
  }
}
