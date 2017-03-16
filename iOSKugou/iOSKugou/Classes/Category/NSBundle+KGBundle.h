//
//  NSBundle+KGBundle.h
//  iOSKugou
//
//  Created by Jason on 16/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (KGBundle)

/**
 获取图片资源

 @param name 资源名
 @return 图片资源路径
 */
- (NSString *)pathForImageResourceWithName:(NSString *)name;
@end
