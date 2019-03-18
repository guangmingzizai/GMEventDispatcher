#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GMEvent.h"
#import "GMEventDispatcher.h"
#import "GMEventObserver.h"
#import "NSArray+GMAdd.h"

FOUNDATION_EXPORT double GMEventDispatcherVersionNumber;
FOUNDATION_EXPORT const unsigned char GMEventDispatcherVersionString[];

