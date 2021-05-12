import SwiftUI
import ZXYDIManager

@main
struct HotSwapApp: App {
  init() {
    ZXYDIManager.shared = .init(parentContainer: nil)
    ZXYDIManager.shared?.setupModulesAutoRegisterDI()
  }
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

