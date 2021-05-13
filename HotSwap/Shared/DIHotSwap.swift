import ZXYDIManager
import ZXYModuleProtocols
#if canImport(ZXYModuleA)
import ZXYModuleA
#endif
#if canImport(ZXYModuleB)
import ZXYModuleB
#endif
#if canImport(ZXYModuleC)
import ZXYModuleC
#endif

extension ZXYDIManager {
  func setupModulesAutoRegisterDI() {
    #if canImport(ZXYModuleA)
    container.register(ZXYModuleA.self) { _ in
      ZXYModuleAImp()
    }
    #endif
    #if canImport(ZXYModuleB)
    container.register(ZXYModuleB.self) { _ in
      ZXYModuleBImp()
    }
    #endif
    #if canImport(ZXYModuleC)
    container.register(ZXYModuleC.self) { _ in
      ZXYModuleCImp()
    }
    #endif
  }
}
