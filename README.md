# ZXYHotSwap - 基于 DI 实现组件化热插拔

简单实现了下组件化热插拔，主要使用 **DI** 解耦。

#### Demo 结构

![image-20210513135644022](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/image-20210513135644022.png?raw=true)

箭头是各组件之间的依赖关系(咖啡色表示并非实际依赖，是通过 DI 获取了协议对应的实现)，所有的 **Module 协议**都放在 **ZXYModuleProtocols** 中。

#### 为什么要热插拔

随着代码量的增加，编译时间越来越长，将必要代码二进制，不必要代码做热插拔，会大大提高编译速度。当然换个顶配垃圾桶也可以（钞能力）。

#### 终极目标

工程是空壳文件，只负责初始化 Router、DI 等必要的逻辑。service 层不能热插拔，但是做成二进制库。业务层支持热插拔。所有模块应支持 UT，完备的日志系统，性能标准（等等等等）。

#### 实现

通过修改 Podfile 中 **swap_white_array** 的内容来控制插拔的组件，在 **swapPods** 中声明。

```ruby
def swapPods
  zxy_swap_pod 'ZXYModuleA', :path => './Modules/ZXYModuleA'
  zxy_swap_pod 'ZXYModuleB', :path => './Modules/ZXYModuleB'
  zxy_swap_pod 'ZXYModuleC', :path => './Modules/ZXYModuleC'
end

```

ModuleC 通过 DI 获取 ModuleA、ModuleB 的实现(**Optional**)，当 ModuleA 的实现被拔掉时，自动修改注册文件，ModuleC 获取是 nil，壳工程获取是 nil，ModuleA 相关的功能不再 work，但无需进行代码修改。

**Podfile 前后对比：**

![origin1](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/origin1.png?raw=true)

![origin2](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/origin2.png?raw=true)

![current1](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/current1.png?raw=true)

![current2](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/current2.png?raw=true)

**代码运行：**

![origin3](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/origin3.png?raw=true)

![current3](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/current3.png?raw=true)

可以看出通过修改一行 Podfile 代码，即可拔掉 ModuleA。

#### 原理

整个过程可以分成两个阶段： **register** 和 **resolve**。

##### register

支持热插拔的组件是在 **DIHotSwap.swift** 来进行 **register** 的，通过 **canImport()** 来进行  **import**，代码如下：

```swift
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
```

##### resolve

通过 Swift 特性 **@propertyWrapper**，实现 **Injected** 语法糖。

```swift
@propertyWrapper
public struct Injected<Service> {
  private var service: Service?
  public init() {
    service = ZXYDIManager.shared?.container.resolve(Service.self)
  }
  public init(name: String? = nil, container: Resolver? = nil) {
    if let container = container {
      service = container.resolve(Service.self, name: name)
    } else {
      service = ZXYDIManager.shared?.container.resolve(Service.self, name: name)
    }
  }
  public var wrappedValue: Service? {
    mutating get {
      service
    }
    mutating set { service = newValue  }
  }
  public var projectedValue: Injected<Service> {
    get { return self }
    mutating set { self = newValue }
  }
}

```

使用起来会比较方便，属性中写上 **@Injected**，则会触发属性包裹器。

```swift
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
```

当拔掉 A 后，**wrappedValue** get 为 nil，对代码编译无影响。

#### 总结

建议尽早组件化开发，不要等到代码编译量过大时才做考虑，因为这时候很多代码的不规范导致组件化过程非常缓慢，同时也有同学不愿意把错误代码修复。😊