//
//  StorageFont.m
//  ShowFontDemo
//
//  Created by 陈明 on 9/24/15.
//  Copyright © 2015 XTM. All rights reserved.
//

#import "StorageFont.h"

#define FontNamesType @"FontNamesType"

#define STR_SINGLETON @"STR_SINGLETON"

static StorageFont *_sharedInstance = nil;

@interface StorageFont ()


@end

@implementation StorageFont

+ (StorageFont *)sharedInstanceStorageFont {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = (StorageFont *)STR_SINGLETON;
        _sharedInstance = [[StorageFont alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    NSString *string = (NSString *)_sharedInstance;
    if ([string isKindOfClass:[NSString class]] && [string isEqualToString:STR_SINGLETON]) {
        self = [super init];
        if (self) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            id obj = [userDefaults objectForKey:FontNamesType];
            if (obj != nil) {
                self.fontNames = [NSMutableArray arrayWithArray:(NSArray *)obj];
            } else {
                self.fontNames = [NSMutableArray array];
            }
        }
        return self;
        
    } else {
        return nil;
    }
}

- (void)saveFontName:(NSString *)fontName {
    [self.fontNames addObject:fontName];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.fontNames forKey:FontNamesType];
    [userDefault synchronize];
}

- (void)cancelFontName:(NSString *)fontName {
    
    [self.fontNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([fontName isEqualToString:obj]) {
            [self.fontNames removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.fontNames forKey:FontNamesType];
    [userDefaults synchronize];
    
}

@end
