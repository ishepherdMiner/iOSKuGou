//
//  KGPlayBarViewContainer.m
//  iOSKugou
//
//  Created by Jason on 17/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "PlayBarViewContainer.h"
#import "KGPlayBarScroller.h"

@implementation PlayBarViewContainer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        NSBundle *cBundle = [KGConfig sharedConfig].curThemeBundle;
        NSString *playbarBgPath = [cBundle pathForImageResourceWithName:@"playbar_bg"];
        UIImage *playbarImg = [UIImage imageWithContentsOfFile:playbarBgPath];
        UIImageView *playbarImgView = [[UIImageView alloc] initWithImage:playbarImg];
        playbarImgView.h = self.h;
        playbarImgView.w = self.w;
        [self addSubview:playbarImgView];
        
        _scroller = [[KGPlayBarScroller alloc] initWithFrame:CGRectMake(0, 0, KGScreenW, 70)];
        [self addSubview:_scroller];

    }
    return self;
}

@end
