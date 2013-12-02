//
//  LLARateLimiter+Private.h
//  LLARateLimiter
//
//  Created by Lukas Lipka on 02/12/13.
//  Copyright (c) 2013 Lukas Lipka. All rights reserved.
//

#import "LLARateLimiter.h"

@interface LLARateLimiter (Private)

+ (NSMutableDictionary *)dictionary;
+ (dispatch_queue_t)queue;

@end
