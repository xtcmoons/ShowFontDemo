//
//  StorageFont.h
//  ShowFontDemo
//
//  Created by 陈明 on 9/24/15.
//  Copyright © 2015 XTM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageFont : NSObject

@property (nonatomic, strong) NSMutableArray<NSString *> *fontNames;

+ (StorageFont *)sharedInstanceStorageFont;

- (void)saveFontName:( NSString *)fontName;

- (void)cancelFontName:(NSString *)fontName;


@end
