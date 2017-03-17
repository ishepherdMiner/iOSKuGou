//
//  KGConfig.m
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGConfig.h"

NSString *KGClassicVoice = @"classic.wav";

@implementation KGConfig

+ (instancetype)sharedConfig {
    static KGConfig *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KGConfig alloc] init];
#warning 需要持久化读取文件,先简单处理,目前各项都往简单的写
        // 主题下面有一个json文件,各种配色可以在那上面做
        instance.canHello = true;
        instance.helloVoice = KGClassicVoice;
        
        NSString *theme = @"defaultTheme";
        instance.curThemeBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:theme ofType:@"bundle"]];
    });
    
    return instance;
}

@end
