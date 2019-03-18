#
# Be sure to run `pod lib lint GMEventDispatcher.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GMEventDispatcher'
  s.version          = '0.1.0'
  s.summary          = 'Event dispatcher used for inter-module communication.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Like Flux's dispatcher, this library is a part of implementation of flux pattern.
It mainly be used for inter-module communication.
Consider the scene, module A calls module B, then A needs callbacks from B. MFRouter is not suitable for this scene, we want a type-safe, simple, easy to use solution.
This is a maybe solution, A calls B with a event dispatcher, you can consider it as a unidirection pipeline, A observes events from the event dispatcher, B dispatcher events to A with the event dispatcher.
To be type-safe, we encourage the called module defines events need to be dispatched.
                       DESC

  s.homepage         = 'https://github.com/guangmingzizai/GMEventDispatcher'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guangmingzizai' => 'guangmingzizai@qq.com' }
  s.source           = { :git => 'https://github.com/guangmingzizai/GMEventDispatcher.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GMEventDispatcher/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GMEventDispatcher' => ['GMEventDispatcher/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
