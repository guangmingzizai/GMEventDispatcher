# GMEventDispatcher

[![CI Status](https://img.shields.io/travis/guangmingzizai/GMEventDispatcher.svg?style=flat)](https://travis-ci.org/guangmingzizai/GMEventDispatcher)
[![Version](https://img.shields.io/cocoapods/v/GMEventDispatcher.svg?style=flat)](https://cocoapods.org/pods/GMEventDispatcher)
[![License](https://img.shields.io/cocoapods/l/GMEventDispatcher.svg?style=flat)](https://cocoapods.org/pods/GMEventDispatcher)
[![Platform](https://img.shields.io/cocoapods/p/GMEventDispatcher.svg?style=flat)](https://cocoapods.org/pods/GMEventDispatcher)

Like Flux's dispatcher, this library is a part of implementation of flux pattern.

It mainly be used for inter-module communication. Consider the scene, module A calls module B, then A needs callbacks from B. MFRouter is not suitable for this scene, we want a type-safe, simple, easy to use solution.

This is a maybe solution, A calls B with a event dispatcher, you can consider it as a unidirection pipeline, A observes events from the event dispatcher, B dispatcher events to A with the event dispatcher.

To be type-safe, we encourage the called module defines events need to be dispatched.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

GMEventDispatcher is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GMEventDispatcher'
```

## Author

guangmingzizai, guangmingzizai@qq.com

## License

GMEventDispatcher is available under the MIT license. See the LICENSE file for more info.
