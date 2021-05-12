import ZXYDIManager
import ZXYModuleProtocols
import ZXYModuleA
import ZXYModuleB
import ZXYModuleC

extension ZXYDIManager {
  func setupModulesAutoRegisterDI() {
    // ⚠️⚠️ This file was automatically generated and should not be edited. ⚠️⚠️
  container.register(ZXYModuleA.self) { _ in
      ZXYModuleAImp()
    }
  container.register(ZXYModuleB.self) { _ in
      ZXYModuleBImp()
    }
  container.register(ZXYModuleC.self) { _ in
      ZXYModuleCImp()
    }
    // ⚠️⚠️ This file was automatically generated and should not be edited. ⚠️⚠️
  }
 }
