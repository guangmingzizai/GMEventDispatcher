//
//  NSArray+GMAdd.h
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/3/19.
//

#import <Foundation/Foundation.h>

typedef id(^GMMapBlock)(id item);
typedef BOOL(^GMFilterBlock)(id item);
typedef NSComparisonResult(^GMSortedBlock)(id item1, id item2);
typedef void(^GMForEachBlock)(NSUInteger i, id item , BOOL *stop);
typedef BOOL(^GMContainsBlock)(id item);
typedef id(^GMDistinctUnionBlock)(id);
typedef BOOL(^GMFetchBlock)(id item);

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (GMAdd)

@property (nonatomic, copy, readonly) NSArray * (^gm_map)(GMMapBlock block);
@property (nonatomic, copy, readonly) NSArray * (^gm_filter)(GMFilterBlock block);
@property (nonatomic, copy, readonly) NSArray * (^gm_sorted)(GMSortedBlock block);
@property (nonatomic, copy, readonly) NSArray * (^gm_forEach)(GMForEachBlock block);
@property (nonatomic, copy, readonly) BOOL (^gm_contains)(GMContainsBlock block);
@property (nonatomic, copy, readonly) NSArray * (^gm_distinctUnion)(GMDistinctUnionBlock block);
@property (nonatomic, copy, readonly) id (^gm_fetch)(GMFetchBlock block);
@property (nonatomic, copy, readonly) NSUInteger (^gm_indexOf)(GMContainsBlock block);

@end

NS_ASSUME_NONNULL_END
