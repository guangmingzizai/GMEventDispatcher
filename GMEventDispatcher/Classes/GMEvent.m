//
//  GMEvent.m
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/4/3.
//

#import "GMEvent.h"

@implementation GMEvent

+ (instancetype)eventWithType:(NSString *)type {
    return [[self alloc] initWithType:type payload:nil];
}

+ (instancetype)eventWithType:(NSString *)type payload:(nullable id)payload {
    return [[self alloc] initWithType:type payload:payload];
}

- (instancetype)initWithType:(NSString *)type {
    return [self initWithType:type payload:nil];
}

- (instancetype)initWithType:(NSString *)type payload:(nullable id)payload {
    if (self = [super init]) {
        _type = [type copy];
        _payload = payload;
    }
    return self;
}

@end
