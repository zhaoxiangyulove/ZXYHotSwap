Pod::Spec.new do |s|
  s.name             = 'ZXYDIManager'
  s.version          = '0.0.1'
  s.summary          = 'ZXYDIManager'
  s.description      = 'ZXYDIManager'
  s.homepage         = 'https://github.com/zhaoxiangyulove/ZXYHotSwap'
  s.source           = { :git => '' }
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoxiangyu' => '44899845@qq.com'}
  s.source_files = 'Source/*.swift'
  s.ios.deployment_target = "11.0"

  s.dependency 'Swinject'
  s.dependency 'ZXYModuleProtocols'
end
