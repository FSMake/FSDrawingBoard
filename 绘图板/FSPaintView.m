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

- (CGPoint)touchPointWithTouches:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self touchPointWithTouches:touches];
    
    _path = [FSPaintPath paintPathWithLineWidth:_lineWidth color:_color];
    
    [self.pathArray addObject:_path];
    [_path moveToPoint:touchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self touchPointWithTouches:touches];
    [_path addLineToPoint:touchPoint];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (FSPaintPath *path in _pathArray) {
        [path.color set];
        [path stroke];
    }
}

- (void)awakeFromNib {
    _lineWidth = 2;
}

- (void)clearBoard {
    _pathArray = nil;
    [self setNeedsDisplay];
}

- (void)unDo {
    [_pathArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)eraser {
    self.color = [UIColor whiteColor];
}

@end
