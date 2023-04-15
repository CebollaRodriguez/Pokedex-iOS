source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '15.5'

target 'Pokedex-iOS' do
  use_frameworks!

  pod 'Alamofire','~> 4.9.1'	
  pod 'GoogleMaps', '7.3.0'

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.5'
         end
    end
  end
end
