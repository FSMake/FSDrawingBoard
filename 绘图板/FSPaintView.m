//
//  FSPaintView.m
//  绘图板
//
//  Created by 樊樊帅 on 5/6/15.
//  Copyright (c) 2015 樊樊帅. All rights reserved.
//

#import "FSPaintView.h"
#import "FSPaintPath.h"

@interface FSPaintView ()

@property (nonatomic, strong) FSPaintPath *path;

@property (nonatomic, strong) NSMutableArray *pathArray;

@end

@implementation FSPaintView
- (UIColor *)color {
    if (_color == nil) {
        _color = [UIColor blackColor];
    }
    return _color;
}

- (NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.pathArray addObject:_image];
    [self setNeedsDisplay];
}

- (CGPoint)touchPointWithTouches:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

#pragma mark 点击屏幕开始画线
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self touchPointWithTouches:touches];
    
    _path = [FSPaintPath paintPathWithLineWidth:_lineWidth color:_color];
    
    [self.pathArray addObject:_path];
    [_path moveToPoint:touchPoint];
}

#pragma mark 移动手指拖线
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self touchPointWithTouches:touches];
    [_path addLineToPoint:touchPoint];
    [self setNeedsDisplay];
}

- (void)awakeFromNib {
    _lineWidth = 2;
}

#pragma mark 清屏
- (void)clearBoard {
    _pathArray = nil;
    [self setNeedsDisplay];
}

#pragma mark 撤销
- (void)unDo {
    [_pathArray removeLastObject];
    [self setNeedsDisplay];
}

#pragma mark 橡皮擦
- (void)eraser {
    self.color = [UIColor whiteColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (FSPaintPath *path in _pathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawAtPoint:CGPointZero];
        } else {
            [path.color set];
            [path stroke];
        }
    }
}


@end
