//
//  GMEventDispatcher.h
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/3/15.
//

#import <Foundation/Foundation.h>
#import "GMEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMEventDispatcher : NSObject

/**
 * 添加观察者，一个观察者对象只能监听一次
 * @param observer 监听者对象，weak引用，dealloc时不需要移除监听
 * @param aSelector 事件发生时被调用的方法，参数为`id<GMEvent>`
 */
- (void)addObserver:(id)observer selector:(nonnull SEL)aSelector;

/**
 * 添加观察者, dealloc时应移除监听
 */
- (id <NSObject>)addObserverOnQueue:(dispatch_queue_t)queue usingBlock:(void (^)(id<GMEvent> event))block;

/**
 * 移除观察者
 */
- (void)removeObserver:(id)observer;

/**
 * dispatch the `event` to observers
 */
- (void)dispatchEvent:(id<GMEvent>)event;

@end

NS_ASSUME_NONNULL_END
