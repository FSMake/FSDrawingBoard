//
//  FSImageHandleView.m
//  绘图板
//
//  Created by 樊樊帅 on 5/7/15.
//  Copyright (c) 2015 樊樊帅. All rights reserved.
//

#import "FSImageHandleView.h"

@interface FSImageHandleView () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FSImageHandleView

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        _imageView = imageView;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.frame = self.bounds;
    self.imageView.image = image;
    
    [self addGesture];
}

#pragma mark - 添加手势
- (void)addGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    
    [_imageView addGestureRecognizer:rotation];
    [_imageView addGestureRecognizer:pinch];
    [_imageView addGestureRecognizer:pan];
    [_imageView addGestureRecognizer:longPress];
}

#pragma mark 旋转手势
- (void)rotation:(UIRotationGestureRecognizer *)rotationGr {
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotationGr.rotation);
    rotationGr.rotation = 0;
}

#pragma mark 捏合手势
- (void)pinch:(UIPinchGestureRecognizer *)pinchGr {
//    NSLog(@"捏合");
    _imageView.transform = CGAffineTransformScale(_imageView.transform, pinchGr.scale, pinchGr.scale);
    pinchGr.scale = 1;
}

#pragma mark 平移手势
- (void)pan:(UIPanGestureRecognizer *)panGr {
//    NSLog(@"拖动");
//    NSLog(@"%@", NSStringFromCGRect(self.frame));
    CGPoint trans = [panGr translationInView:self];
    
    NSLog(@"%@", NSStringFromCGPoint(trans));
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, trans.x, trans.y);
    
    [panGr setTranslation:CGPointZero inView:self];
}

#pragma mark 长按手势
- (void)longPress:(UIGestureRecognizer *)longPressGr {
    if (longPressGr.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"长按图片");
        [UIView animateWithDuration:0.25 animations:^{
            _imageView.alpha = 0.5;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                _imageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                UIGraphicsBeginImageContext(self.bounds.size);
                
                CGContextRef contextRef = UIGraphicsGetCurrentContext();
                
                [self.layer renderInContext:contextRef];
                
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
                
                _block(image);
                
                [self removeFromSuperview];
                NSLog(@"移除遮罩");
            }];
        }];
    }
}

#pragma mark - UIGestureRecognizer代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
