//
//  NSArray+GMAdd.m
//  GMEventDispatcher
//
//  Created by JianFei Wang on 2019/3/19.
//

#import "NSArray+GMAdd.h"

@implementation NSArray (GMAdd)

- (NSArray *(^)(GMMapBlock))gm_map {
    return ^(GMMapBlock block) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
        for (id obj in self) {
            id rtn = block(obj);
            if (rtn) {
                [array addObject:rtn];
            }
        }
        return [array copy];
    };
}

- (NSArray *(^)(GMFilterBlock))gm_filter {
    return ^(GMFilterBlock block) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
        for (id obj in self) {
            if (block(obj)) {
                [array addObject:obj];
            }
        }
        return [array copy];
    };
}

- (NSArray *(^)(GMSortedBlock))gm_sorted {
    return ^(GMSortedBlock block) {
        return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return block(obj1, obj2);
        }];
    };
}

- (NSArray *(^)(GMForEachBlock))gm_forEach {
    return ^(GMForEachBlock block) {
        BOOL stop = NO;
        for (NSUInteger i = 0; i < self.count; i++) {
            block(i, self[i], &stop);
            if (stop) {
                break;
            }
        }
        return self;
    };
}

- (BOOL(^)(GMContainsBlock))gm_contains {
    return ^(GMContainsBlock block) {
        BOOL flag = NO;
        for (id obj in self) {
            if (block(obj)) {
                flag = YES;
                break;
            }
        }
        return flag;
    };
}

- (NSArray *(^)(GMDistinctUnionBlock))gm_distinctUnion {
    return ^(GMDistinctUnionBlock block) {
        NSMutableArray *array1 = [[NSMutableArray alloc] initWithCapacity:self.count];
        NSMutableArray *array2 = [[NSMutableArray alloc] initWithCapacity:self.count];
        for (id item in self) {
            id rtn = block(item);
            if (![array1 containsObject:rtn] && rtn) {
                [array1 addObject:rtn];
                [array2 addObject:item];
            }
        }
        return array2.copy;
    };
}

- (id (^)(GMFetchBlock))gm_fetch {
    return ^(GMFetchBlock block) {
        id item;
        for (id obj in self) {
            if (block(obj)) {
                item = obj;
                break;
            }
        }
        return item;
    };
}

- (NSUInteger (^)(GMContainsBlock _Nonnull))gm_indexOf {
    return ^(GMContainsBlock block) {
        NSUInteger index = NSNotFound;
        for (NSUInteger i = 0; i < self.count; i++) {
            if (block(self[i])) {
                index = i;
                break;
            }
        }
        return index;
    };
}

@end
