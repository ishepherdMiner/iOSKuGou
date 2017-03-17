//
//  KGPlayBarScroller.m
//  iOSKugou
//
//  Created by Jason on 17/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGPlayBarScroller.h"
#import "KGThemeMutiTypeButton.h"
#import <AFNetworking.h>

#import "KxMovieViewController.h"

@interface KGPlayBarScroller ()

/// 光盘
@property (nonatomic,strong) UIImageView *cdImgView;

/// 光盘外的一圈颜色
@property (nonatomic,strong) UIImageView *cdCornerImgView;

@end

@implementation KGPlayBarScroller

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = true;
        self.contentOffset = CGPointMake(KGScreenW,0);
        self.showsHorizontalScrollIndicator = false;
        
        // 总要保证光盘能显示,所以对滚动距离是有限制的
        self.contentSize = CGSizeMake(KGScreenW * 2 - 70, KGPlayBarH);
        
        NSBundle *cBundle = [KGConfig sharedConfig].curThemeBundle;
        NSString *cdImgPath = [cBundle pathForImageResourceWithName:@"playbar_headimage_default"];
        UIImage *cdImg = [UIImage imageWithContentsOfFile:cdImgPath];
        _cdImgView = [[UIImageView alloc] initWithImage:cdImg];
        _cdImgView.frame = CGRectMake(12 + KGScreenW - 70 , 10, 55, 55);
        [self addSubview:_cdImgView];
        
        // KGTextRollView
        UILabel *music = [[UILabel alloc] initWithFrame:CGRectMake(81 + KGScreenW - 70, 29, 95, 16)];
#warning wait
        // 读取上一次播放的记录,如果没有显示默认的(未处理)
        music.text = @"酷狗音乐";
        music.font = [UIFont systemFontOfSize:13];
        [self addSubview:music];
        
        // KGTextRollView 音乐名称长了会滚动,是个自定义视图
        UILabel *actor = [[UILabel alloc] initWithFrame:CGRectMake(81 + KGScreenW - 70, 50, 110, 14)];
        actor.text = @"音乐总有新玩法";
        actor.font = [UIFont systemFontOfSize:12];
        actor.textColor = KGLightFontColor;
        [self addSubview:actor];
        ;
        KGThemeMutiTypeButton *playBtn = [KGThemeMutiTypeButton buttonWithType:UIButtonTypeCustom];
        playBtn.frame = CGRectMake(191 * KGScreenW / 320 + KGScreenW - 70, 30, 35, 35);
        
        NSString *playPath = [cBundle pathForImageResourceWithName:@"playbar_play"];
        UIImage *playImg = [UIImage imageWithContentsOfFile:playPath];
        [playBtn setImage:playImg forState:UIControlStateNormal];
        
        NSString *playlightPath = [cBundle pathForImageResourceWithName:@"playbar_play_on"];
        UIImage *playLightImg = [UIImage imageWithContentsOfFile:playlightPath];
        [playBtn setImage:playLightImg forState:UIControlStateHighlighted];
        
        // NSString *pausePath = [cBundle pathForImageResourceWithName:@"playbar_pause"];
        // UIImage *pauseImg = [UIImage imageWithContentsOfFile:pausePath];
        
        [self addSubview:playBtn];
        
        KGThemeMutiTypeButton *nextPlayBtn = [KGThemeMutiTypeButton buttonWithType:UIButtonTypeCustom];
        nextPlayBtn.frame = CGRectMake(237 * KGScreenW / 320 + KGScreenW - 70, 30, 35, 35);
        NSString *nextPlayPath = [cBundle pathForImageResourceWithName:@"playbar_next"];
        UIImage *nextPlayImg = [UIImage imageWithContentsOfFile:nextPlayPath];
        [nextPlayBtn setImage:nextPlayImg forState:UIControlStateNormal];
        
        NSString *nextPlaylightPath =[cBundle pathForImageResourceWithName:@"playbar_next_on"];
        UIImage *nextPlaylightImg = [UIImage imageWithContentsOfFile:nextPlaylightPath];
        [nextPlayBtn setImage:nextPlaylightImg forState:UIControlStateHighlighted];
        
        [self addSubview:nextPlayBtn];
        
        // 乐库list
        KGThemeMutiTypeButton *yuekulistBtn = [KGThemeMutiTypeButton buttonWithType:UIButtonTypeCustom];
        yuekulistBtn.frame = CGRectMake(283 * KGScreenW / 320 + KGScreenW - 70, 30, 35, 35);
        NSString *yuekulistPath = [cBundle pathForImageResourceWithName:@"playbar_yuekulist"];
        UIImage *yuekulistImg = [UIImage imageWithContentsOfFile:yuekulistPath];
        [yuekulistBtn setImage:yuekulistImg forState:UIControlStateNormal];
        
        [self addSubview:yuekulistBtn];
        
        // demo
        [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// 用Charles获取一个链接 先用FFmpeg测试一下播放的功能
// 用KxAudioManager,在这儿好像还不太容易调用,等大概看好KxMovie后再处理
//
- (void)play:(KGThemeMutiTypeButton *)btn {
    // http://fs.ios.kugou.com/201703170821/a4292c2f79853a381d530b9e9f72d645/G090/M08/0B/09/OpQEAFjBfJGAGJflADMHXsaxY2k182.mp3
    // 酷狗-曲婉婷的Moon and Back(JordanXl Remix
    
//    ViewController *vc;
//    NSString *path = @"http://192.168.5.101/~Jason/sample_iPod.m4v";
//    vc = [KxMovieViewController movieViewControllerWithContentPath:path parameters:nil];
//    [self presentViewController:vc animated:YES completion:nil];
}

@end
