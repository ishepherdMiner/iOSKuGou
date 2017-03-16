//
//  NSBundle+KGBundle.m
//  iOSKugou
//
//  Created by Jason on 16/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSBundle+KGBundle.h"

@implementation NSBundle (KGBundle)

- (NSString *)pathForImageResourceWithName:(NSString *)name{
    
    NSString *imagePath = [self pathForImageResourceWithName:name ext:@"png"];
    if (imagePath) {
        return imagePath;
    }else {
        imagePath = [self pathForImageResourceWithName:name ext:@"jpg"];
        NSAssert(imagePath, @"图片资源只支持png/jpg");
    }
    return imagePath;
}

- (NSString *)pathForImageResourceWithName:(NSString *)name
                                       ext:(NSString *)ext {
    
    NSString *suffix = @"@2x";
    NSString *realPath = [NSString stringWithFormat:@"%@%@",name,suffix];
    NSString *imagePath = [self pathForResource:realPath ofType:ext];
    
    // plus
    if (KGScreenW > 375) {
        suffix = @"@3x";
        realPath = [NSString stringWithFormat:@"%@%@",name,suffix];
        imagePath = [self pathForResource:realPath ofType:ext];
    }
    return imagePath;
}

@end
