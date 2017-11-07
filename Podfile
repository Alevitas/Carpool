# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Carpool' do
  use_frameworks!

  pod 'CarpoolKit', :git => 'https://github.com/codebasesav/CarpoolKit.git', :branch =>   'master'
end

pre_install do |installer|
    def installer.verify_no_static_framework_transitive_dependencies; end
end
