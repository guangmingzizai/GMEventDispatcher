//
//  GMEventDispatcher.m
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/3/15.
//

#import "GMEventDispatcher.h"
#import "GMEventObserver.h"
#import "NSArray+GMAdd.h"
#import <pthread.h>

#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

@interface GMEventDispatcher ()

@property (nonatomic, assign) pthread_mutex_t lock;
@property (nonatomic, strong) NSMutableArray<GMEventObserver *> *observers;
@property (nonatomic, assign) NSUInteger observerIdentifier;

@end

@implementation GMEventDispatcher

#pragma mark - Lifetime

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observers = [NSMutableArray array];
        _observerIdentifier = 0;
    }
    return self;
}

#pragma mark - Add Observer

- (void)addObserver:(id)observer selector:(nonnull SEL)aSelector {
    Lock();
    
    NSArray<GMEventObserver *> *observers = _observers.copy;
    
    NSArray<GMTargetSelectorEventObserver *> *targetSelectorObservers = observers.gm_filter(^BOOL(GMEventObserver *item) {
        return (item.type == GMEventObserverTargetSelector);
    });
    BOOL exists = targetSelectorObservers.gm_contains(^BOOL(GMTargetSelectorEventObserver *item) {
        return (item.target == observer);
    });
    if (!exists) {
        [_observers addObject:[GMTargetSelectorEventObserver observerWithTarget:observer selector:aSelector]];
    } else {
        NSLog(@"Duplicate observer: %@", observer);
    }
    [self _compactObservers];
    Unlock();
}

- (id <NSObject>)addObserverOnQueue:(dispatch_queue_t)queue usingBlock:(void (^)(id<GMEvent> event))block {
    NSParameterAssert(queue);
    
    Lock();
    NSArray<GMEventObserver *> *observers = _observers.copy;
    NSArray<GMBlockEventObserver *> *blockObservers = observers.gm_filter(^BOOL(GMEventObserver *item) {
        return (item.type == GMEventObserverBlock);
    });
    BOOL exists = blockObservers.gm_contains(^BOOL(GMBlockEventObserver *item) {
        return ([item.queue isEqual:queue] && [item.callback isEqual:block]);
    });
    if (!exists) {
        self.observerIdentifier += 1;
        [_observers addObject:[GMBlockEventObserver observerWithIdentifier:@(self.observerIdentifier) queue:queue callback:block]];
    } else {
        NSLog(@"Duplicate block observer");
    }
    Unlock();
    return @(self.observerIdentifier);
}

#pragma mark - Remove Observer

- (void)removeObserver:(id)observer {
    Lock();
    
    NSArray<GMEventObserver *> *observers = _observers.copy;
    NSUInteger index = observers.gm_indexOf(^BOOL(GMEventObserver *aObserver) {
        if ([observer isKindOfClass:[NSNumber class]]) {
            if (aObserver.type == GMEventObserverBlock) {
                GMBlockEventObserver *blockEventObserver = (GMBlockEventObserver *)aObserver;
                return (blockEventObserver.identifier == observer);
            }
        } else {
            if (aObserver.type == GMEventObserverTargetSelector) {
                GMTargetSelectorEventObserver *targetSelectorEventObserver = (GMTargetSelectorEventObserver *)aObserver;
                return (targetSelectorEventObserver.target == observer);
            }
        }
        return NO;
    });
    if (index != NSNotFound) {
        [_observers removeObjectAtIndex:index];
    }
    
    [self _compactObservers];
    Unlock();
}

#pragma mark - Dispatch

- (void)dispatchEvent:(id<GMEvent>)event {
    NSArray<GMEventObserver *> *observers = _observers.copy;
    NSArray<GMTargetSelectorEventObserver *> *targetSelectorObservers = observers.gm_filter(^BOOL(GMEventObserver *aObserver) {
        return (aObserver.type == GMEventObserverTargetSelector);
    });
    NSArray<GMBlockEventObserver *> *blockObservers = observers.gm_filter(^BOOL(GMEventObserver *aObserver) {
        return (aObserver.type == GMEventObserverBlock);
    });
    for (GMTargetSelectorEventObserver *observer in targetSelectorObservers) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // Start executing the requested task
        [observer.target performSelector:observer.selector withObject:event];
#pragma clang diagnostic pop
    }
    for (GMBlockEventObserver *observer in blockObservers) {
        dispatch_async(observer.queue, ^{
            observer.callback(event);
        });
    }
}

#pragma mark - Utility

- (void)_compactObservers {
    NSArray<GMEventObserver *> *observers = _observers.copy;
    NSArray<GMTargetSelectorEventObserver *> *targetSelectorObservers = observers.gm_filter(^BOOL(GMEventObserver *aObserver) {
        return (aObserver.type == GMEventObserverTargetSelector);
    });
    NSArray<GMTargetSelectorEventObserver *> *releasedObservers = targetSelectorObservers.gm_filter(^BOOL(GMTargetSelectorEventObserver *item) {
        return (item.target == nil);
    });
    [_observers removeObjectsInArray:releasedObservers];
}

@end
