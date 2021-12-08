//
//  HotSwapTests.swift
//  HotSwapTests
//
//  Created by zhaoxiangyu on 2021/12/8.
//

import XCTest
@testable import HotSwap
import ZXYDIManager
import ZXYModuleProtocols

class HotSwapTests: XCTestCase {
  
  @Injected var moduleC: ZXYModuleC?
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testInjectWork() {
    XCTAssertNotNil(moduleC)
  }
  
}
