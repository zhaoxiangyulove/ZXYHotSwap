Pod::Spec.new do |s|
  s.name             = 'ZXYModuleA'
  s.version          = '0.0.1'
  s.summary          = 'ZXYModuleA'
  s.description      = 'ZXYModuleA'
  s.homepage         = 'https://github.com/zhaoxiangyulove/ZXYHotSwap'
  s.source           = { :git => '' } 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoxiangyu' => '44899845@qq.com'}
  s.source_files = 'Source/**/*.swift'
  s.ios.deployment_target = "11.0"

  s.dependency 'ZXYModuleProtocols'
end

