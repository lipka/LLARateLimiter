//
//  LLAPersistentRateLimiter.m
//  LLARateLimiter
//
//  Created by Lukas Lipka on 01/12/13.
//  Copyright (c) 2013 Lukas Lipka. All rights reserved.
//

#import "LLAPersistentRateLimiter.h"
#import "LLARateLimiter+Private.h"

@implementation LLAPersistentRateLimiter

+ (BOOL)executeBlock:(void (^)())block name:(NSString *)name limit:(NSTimeInterval)limit {
    BOOL result = [super executeBlock:block name:name limit:limit];
    [self synchronize];
    return result;
}

+ (void)resetLimitForName:(NSString *)name {
    [super resetLimitForName:name];
    [self synchronize];
}

+ (void)resetAllLimits {
    [super resetAllLimits];
    [self synchronize];
}

#pragma mark - Private

+ (NSMutableDictionary *)dictionary {
    static NSMutableDictionary *dictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dictionary = [NSMutableDictionary dictionaryWithContentsOfURL:[self fileURL]];
        if (!dictionary) {
            dictionary = [[NSMutableDictionary alloc] init];
        }
    });
    return dictionary;
}

+ (NSURL *)fileURL {
    static NSURL *fileURL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        fileURL = [fileURL URLByAppendingPathComponent:@"LLAPersistentRateLimiter.plist"];
    });
    return fileURL;
}

+ (void)synchronize {
    dispatch_async([self queue], ^{
        [[self dictionary] writeToURL:[self fileURL] atomically:YES];
    });
}

@end
