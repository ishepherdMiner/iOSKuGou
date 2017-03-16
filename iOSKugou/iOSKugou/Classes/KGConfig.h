//
//  KGConfig.h
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *KGClassicVoice;

@interface KGConfig : NSObject

/// 是否播放欢迎声音
@property (nonatomic,assign) BOOL canHello; 

/// 欢迎声音,默认是经典类型
@property (nonatomic,copy) NSString *helloVoice;

/// 当前的主题包
@property (nonatomic,strong) NSBundle *curThemeBundle;

+ (instancetype)sharedConfig;

@end
