//
//  FSPaintPath.m
//  绘图板
//
//  Created by 樊樊帅 on 5/7/15.
//  Copyright (c) 2015 樊樊帅. All rights reserved.
//

#import "FSPaintPath.h"

@implementation FSPaintPath

+ (instancetype)paintPathWithLineWidth:(CGFloat)lineWidth color:(UIColor *)color {
    FSPaintPath *path = [[self alloc] init];
    path.lineWidth = lineWidth;
    path.color = color;
    
    return path;
}

@end
