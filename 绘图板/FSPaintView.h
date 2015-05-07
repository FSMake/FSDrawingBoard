//
//  FSPaintView.h
//  绘图板
//
//  Created by 樊樊帅 on 5/6/15.
//  Copyright (c) 2015 樊樊帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSPaintView : UIView

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIImage *image;

- (void)clearBoard;

- (void)unDo;

- (void)eraser;

@end
