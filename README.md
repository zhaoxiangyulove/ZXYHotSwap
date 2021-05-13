# ZXYHotSwap - 基于 DI 实现组件化热插拔

简单实现了下组件化热插拔，主要使用 **DI** 解耦。**pod install** 时根据白名单生成自动注册文件 **HotSwapApp.swift**

#### Demo 结构

![image-20210513121116138](https://github.com/zhaoxiangyulove/ZXYHotSwap/blob/main/Resource/image-20210513121116138.png?raw=true)

箭头是各组件之间的依赖关系，所有的 **Module 协议**都放在 **ZXYModuleProtocols** 中。

#### 实现

通过修改 Podfile 中 swap_white_array 的内容来控制插拔的组件，在 swapPods 中声明。

```ruby
def swapPods
  zxy_swap_pod 'ZXYModuleA', :path => './Modules/ZXYModuleA'
  zxy_swap_pod 'ZXYModuleB', :path => './Modules/ZXYModuleB'
  zxy_swap_pod 'ZXYModuleC', :path => './Modules/ZXYModuleC'
end

```

ModuleC 通过 DI 获取 ModuleA、ModuleB 的实现(Optional)，当 ModuleA 的实现被拔掉时，自动修改注册文件，ModuleC 获取是 nil，壳工程获取是 nil，ModuleA 相关的功能不再 work，但无需进行代码修改。

运行效果：

