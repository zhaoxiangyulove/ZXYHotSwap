import ZXYDIManager
import ZXYModuleProtocols
import ZXYModuleA
import ZXYModuleB
import ZXYModuleC

extension ZXYDIManager {
  func setupModulesAutoRegisterDI() {
    container.register(ZXYModuleA.self) { _ in
      ZXYModuleAImp()
    }
  }
}
