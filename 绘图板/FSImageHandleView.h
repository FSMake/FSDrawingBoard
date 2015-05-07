//
//  FSImageHandleView.h
//  绘图板
//
//  Created by 樊樊帅 on 5/7/15.
//  Copyright (c) 2015 樊樊帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FSImageHandleViewBlock)(UIImage *);

@interface FSImageHandleView : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) FSImageHandleViewBlock block;

@end
