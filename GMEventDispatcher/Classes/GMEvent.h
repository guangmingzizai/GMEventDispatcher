//
//  GMEvent.h
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Empty protocol, in fact, you can dispatch any object.
 */
@protocol GMEvent <NSObject>

@end

@interface GMEvent : NSObject <GMEvent>

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong, nullable) id payload;

+ (instancetype)eventWithType:(NSString *)type;
+ (instancetype)eventWithType:(NSString *)type payload:(nullable id)payload;

- (instancetype)initWithType:(NSString *)type;
- (instancetype)initWithType:(NSString *)type payload:(nullable id)payload;

@end

NS_ASSUME_NONNULL_END
