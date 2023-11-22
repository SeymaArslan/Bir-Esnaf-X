# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Bir Esnaf' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Bir Esnaf

pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'FirebaseFirestoreSwift'
pod 'FirebaseAnalytics'
pod 'FirebaseStorage'

pod 'YPImagePicker'

pod 'ProgressHUD'
pod 'SKPhotoBrowser'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end
