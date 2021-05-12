//
//  ContentView.swift
//  Shared
//
//  Created by zhaoxiangyu on 2021/5/12.
//

import SwiftUI
import ZXYDIManager
import ZXYModuleProtocols

final class ViewModel {
  @Injected var moduleA: ZXYModuleA?
  @Injected var moduleB: ZXYModuleB?
  @Injected var moduleC: ZXYModuleC?
  
  func printAMsg() {
    if let moduleA = moduleA {
      moduleA.printMsg()
    } else {
      print("ModuleA's instance not find, go on")
    }
  }
  
  func printBMsg() {
    if let moduleB = moduleB {
      moduleB.printMsg()
    } else {
      print("ModuleB's instance not find, go on")
    }
  }
  
  func printCMsg() {
    if let moduleC = moduleC {
      moduleC.printMsg()
    } else {
      print("ModuleC's instance not find, go on")
    }
  }
}

struct ContentView: View {
  @State var vm = ViewModel()
  var body: some View {
    VStack {
      Button("moduleA") {
        vm.printAMsg()
      }
      Button("moduleB") {
        vm.printBMsg()
      }
      Button("moduleC") {
        vm.printCMsg()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
