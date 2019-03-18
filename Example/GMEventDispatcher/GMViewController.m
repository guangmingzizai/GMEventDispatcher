//
//  GMViewController.m
//  GMEventDispatcher
//
//  Created by guangmingzizai on 03/18/2019.
//  Copyright (c) 2019 guangmingzizai. All rights reserved.
//

#import "GMViewController.h"
#import <GMEventDispatcher/GMEventDispatcher.h>

@interface GMDemoEvent : NSObject<GMEvent>

@end

@implementation GMDemoEvent

@end

@interface GMViewController ()

@property (nonatomic, strong) GMEventDispatcher *eventDispatcher;
@property (nonatomic, strong) NSMutableArray *blockObservers;

@end

@implementation GMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _eventDispatcher = [GMEventDispatcher new];
    _blockObservers = [NSMutableArray array];
}

#pragma mark - Action

- (IBAction)addTargetActionObserver:(id)sender {
    [_eventDispatcher addObserver:self selector:@selector(onEvent:)];
}

- (IBAction)addBlockObserver:(id)sender {
    id observer =
    [_eventDispatcher addObserverOnQueue:dispatch_get_main_queue() usingBlock:^(id<GMEvent>  _Nonnull event) {
        NSLog(@"on block event: %@", event);
    }];
    [_blockObservers addObject:observer];
}

- (IBAction)removeTargetActionObserver:(id)sender {
    [_eventDispatcher removeObserver:self];
}

- (IBAction)removeBlockObserver:(id)sender {
    for (id observer in _blockObservers.copy) {
        [_eventDispatcher removeObserver:observer];
    }
    [_blockObservers removeAllObjects];
}

- (IBAction)dispatchEvent:(id)sender {
    GMDemoEvent *event = [GMDemoEvent new];
    [_eventDispatcher dispatchEvent:event];
}

#pragma mark - Handle event

- (void)onEvent:(id<GMEvent>)event {
    NSLog(@"on event: %@", event);
}

@end
