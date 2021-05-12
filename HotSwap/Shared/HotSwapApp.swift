import SwiftUI
import ZXYDIManager

@main
struct HotSwapApp: App {
  init() {
    ZXYDIManager.shared = .init(parentContainer: nil)
    setupModulesAutoRegisterDI()
  }
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

