platform :ios, '15.0'
inhibit_all_warnings!

target 'SwiftUIAPP' do

  use_frameworks!

  pod 'Alamofire'
  pod 'KakaJSON'

  pod 'SDWebImage'
  pod 'FSPagerView'
  pod 'TZImagePickerController'
  pod 'BRPickerView'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
        end
    end
end