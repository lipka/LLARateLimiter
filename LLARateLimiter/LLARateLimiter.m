//
//  LLARateLimter.m
//  LLARateLimiter
//
//  Created by Lukas Lipka on 11/11/13.
//  Copyright (c) 2013 Lukas Lipka. All rights reserved.
//

#import "LLARateLimiter.h"

@implementation LLARateLimiter

+ (BOOL)executeBlock:(void (^)())block name:(NSString *)name limit:(NSTimeInterval)limit {
    __block BOOL executeBlock = NO;
    dispatch_sync([self queue], ^{
        NSDate *lastExecution = [[self dictionary] objectForKey:name];
        if (!lastExecution || fabs(lastExecution.timeIntervalSinceNow) >= limit) {
            [[self dictionary] setObject:[NSDate date] forKey:name];
            executeBlock = YES;
        }
    });
    
    if (executeBlock) {
        block();
    }
    
    return executeBlock;
}

+ (void)resetLimitForName:(NSString *)name {
    dispatch_sync([self queue], ^{
        [[self dictionary] removeObjectForKey:name];
    });
}

+ (void)resetAllLimits {
    dispatch_sync([self queue], ^{
        [[self dictionary] removeAllObjects];
    });
}

#pragma mark - Private

+ (NSMutableDictionary *)dictionary {
    static NSMutableDictionary *dictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dictionary = [[NSMutableDictionary alloc] init];
    });
    return dictionary;
}


+ (dispatch_queue_t)queue {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.lukaslipka.llaratelimiter", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

@end
