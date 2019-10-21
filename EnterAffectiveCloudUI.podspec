Pod::Spec.new do |s|
  s.name             = 'EnterAffectiveCloudUI'
  s.version          = '1.2.0'
  s.summary          = 'Entertech 情感云UI SDK'
  s.description      = <<-DESC
情感云 SDK关联的UI，可以实时显示注意力、专注度、放松度、愉悦度和压力值等情绪相关的一些数据，也可以显示最终报表。
                       DESC

  s.homepage         = 'https://github.com/EnterTech'
  s.author           = { 'ET_LINK' => 'like@entertch.cn' }
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'git@github.com:Entertech/Enter-AffectiveComputing-iOS-SDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'EnterAffectiveCloudUI/**/*.swift'
  s.dependency 'RxSwift', '5.0'
  s.dependency 'SnapKit'
  s.dependency 'Charts'
end
