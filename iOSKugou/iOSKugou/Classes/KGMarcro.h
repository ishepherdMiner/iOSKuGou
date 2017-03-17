//
//  KGMarcro.h
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#ifndef KGMarcro_h
#define KGMarcro_h

// 颜色
#define KGHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >> 8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]

#define KGRGBWhite KGHexRGB(0xffffff) // 白色
#define KGRGBBlack KGHexRGB(0x000000) // 黑色
#define KGDebugRGB KGHexRGB(0xffff00)

#define KGScreenBounds [UIScreen mainScreen].bounds
#define KGScreenH KGScreenBounds.size.height
#define KGScreenW KGScreenBounds.size.width

#define KGNavH 64     // 导航条高度
#define KGPlayBarH 70 // 播放器高度

// 浅色字体颜色
#define KGLightFontColor KGHexRGB(0xaaaaaa)

#endif /* KGMarcro_h */
