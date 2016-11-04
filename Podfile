source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

target :BikeStations do
  pod 'Alamofire', '~> 4.0.0'
  pod 'MagicalRecord'
end

target :BikeStationsTests do
    pod 'Alamofire', '~> 4.0.0'
    pod 'MagicalRecord'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
