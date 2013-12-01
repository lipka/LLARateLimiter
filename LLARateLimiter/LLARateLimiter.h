//
//  LLARateLimter.h
//  LLARateLimiter
//
//  Created by Lukas Lipka on 11/11/13.
//  Copyright (c) 2013 Lukas Lipka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLARateLimiter : NSObject

+ (BOOL)executeBlock:(void (^)())block name:(NSString *)name limit:(NSTimeInterval)limit;
+ (void)resetLimitForName:(NSString *)name;
+ (void)resetAllLimits;

@end
