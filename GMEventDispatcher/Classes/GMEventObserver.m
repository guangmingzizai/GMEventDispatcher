//
//  GMEventObserver.m
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/3/18.
//

#import "GMEventObserver.h"

@implementation GMEventObserver

@end

@implementation GMTargetSelectorEventObserver

+ (instancetype)observerWithTarget:(id)target selector:(SEL)selector {
    GMTargetSelectorEventObserver *observer = [[GMTargetSelectorEventObserver alloc] init];
    observer.target = target;
    observer.selector = selector;
    return observer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = GMEventObserverTargetSelector;
    }
    return self;
}

@end

@implementation GMBlockEventObserver

+ (instancetype)observerWithIdentifier:(id)identifier queue:(dispatch_queue_t)queue callback:(GMEventCallback)callback {
    GMBlockEventObserver *observer = [[GMBlockEventObserver alloc] init];
    observer.identifier = identifier;
    observer.queue = queue;
    observer.callback = callback;
    return observer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = GMEventObserverBlock;
    }
    return self;
}

@end
