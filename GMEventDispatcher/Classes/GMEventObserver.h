//
//  GMEventObserver.h
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/3/18.
//

#import <Foundation/Foundation.h>
#import "GMEvent.h"

typedef NS_ENUM(NSUInteger, GMEventObserverType) {
    GMEventObserverTargetSelector,
    GMEventObserverBlock,
};

typedef void(^GMEventCallback)(id<GMEvent>);

NS_ASSUME_NONNULL_BEGIN

@interface GMEventObserver : NSObject

@property (nonatomic, assign) GMEventObserverType type;

@end

@interface GMTargetSelectorEventObserver : GMEventObserver

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

+ (instancetype)observerWithTarget:(id)target selector:(SEL)selector;

@end

@interface GMBlockEventObserver : GMEventObserver

@property (nonatomic, strong) id identifier;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, copy) GMEventCallback callback;

+ (instancetype)observerWithIdentifier:(id)identifier queue:(dispatch_queue_t)queue callback:(GMEventCallback)callback;

@end

NS_ASSUME_NONNULL_END
