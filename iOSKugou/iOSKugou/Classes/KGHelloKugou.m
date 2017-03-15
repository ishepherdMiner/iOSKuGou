//
//  KGHelloKugou.m
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGHelloKugou.h"
#import "KGConfig.h"
#import <AVFoundation/AVFoundation.h>

@interface KGHelloKugou ()
@property (nonatomic,strong) AVAudioPlayer *player;
@end

@implementation KGHelloKugou

- (void)hello {
    KGConfig *cg = [KGConfig sharedConfig];
#warning 声音分3种,1.经典版,bundle,2.明星版,需下载,3.录音版,需录音
    if ([cg.helloVoice isEqualToString:KGClassicVoice]) {
        [self _helloClassic];
    }
}

- (void)_helloClassic {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"classic" ofType:@"wav"];
    
   NSError *error = nil;
    
   // 只能播放本地音频,多种API都试试吧
   _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:musicPath] error:&error];
    if (error == nil) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        _player.volume = 0.6;
        [_player prepareToPlay];
        [_player play];
    }else {
        NSLog(@"error:%@",error);
    }
}

- (void)_helloStar {
    
}

- (void)_helloRecord {
    
}

@end
