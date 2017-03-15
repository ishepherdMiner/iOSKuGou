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
#define KGDebugRGB KGHexRGB(0xffff00)

#define KGScreenH [UIScreen mainScreen].bounds.size.height
#define KGScreenW [UIScreen mainScreen].bounds.size.width

#endif /* KGMarcro_h */
