# ZXYHotSwap - 基于 DI 实现组件化热插拔

简单实现了下组件化热插拔，主要使用 **DI** 解耦。**pod install** 时根据白名单生成自动注册文件 **HotSwapApp.swift**

#### Demo 结构

![image-20210513121116138](/Users/zhaoxiangyu/Library/Application Support/typora-user-images/image-20210513121116138.png)

箭头是各组件之间的依赖关系，所有的 **Module 协议**都放在 **ZXYModuleProtocols** 中。

#### 实现

ModuleC 通过 DI 获取 ModuleA、ModuleB 的实现，是一个 Optional 的值，当 ModuleA 的实现被拔掉时，ModuleC 获取是 nil，ModuleA 相关的功能不再 work，但无需进行代码修改。