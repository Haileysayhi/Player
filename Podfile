# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'Player' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Player

  # Pods for Rx
  pod 'RxWebKit', '~> 1.0.0'
  pod 'RxSwift', '~> 5.1.0'
  pod 'RxCocoa', '~> 5.1.0'
  pod 'RxDataSources', '~> 4.0.1'
  pod 'RxGesture', '~> 3.0.0'
  pod 'RxAVFoundation', '~> 3.0.0'


end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "13.0"
    end
  end
end
