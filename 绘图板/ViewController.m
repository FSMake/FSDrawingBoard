//
//  ViewController.m
//  绘图板
//
//  Created by 樊樊帅 on 5/6/15.
//  Copyright (c) 2015 樊樊帅. All rights reserved.
//

#import "ViewController.h"
#import "FSPaintView.h"
#import "MBProgressHUD+MJ.h"
#import "FSImageHandleView.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet FSPaintView *paintView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 清屏点击
- (IBAction)clearBoard:(UIBarButtonItem *)sender {
    [_paintView clearBoard];
}

#pragma mark 撤销点击
- (IBAction)unDo:(UIBarButtonItem *)sender {
    [_paintView unDo];
}

#pragma mark 橡皮点击
- (IBAction)eraser:(UIBarButtonItem *)sender {
    [_paintView eraser];
}

#pragma mark 照片点击
- (IBAction)photo:(UIBarButtonItem *)sender {
    UIImagePickerController *imagePc = [[UIImagePickerController alloc] init];
    
    imagePc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePc.delegate = self;
    
    [self presentViewController:imagePc animated:YES completion:^{
        
    }];
}

#pragma mark 保存点击
- (IBAction)save:(UIBarButtonItem *)sender {
    //截屏
    UIGraphicsBeginImageContextWithOptions(_paintView.bounds.size, NO, 0.0);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    [_paintView.layer renderInContext:contextRef];
    
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(screenShotImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    } else {
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

#pragma mark 滑块移动
- (IBAction)slider:(UISlider *)sender {
    _paintView.lineWidth = sender.value;
}

#pragma mark 颜色选择点击
- (IBAction)colorBtnClick:(UIButton *)sender {
    _paintView.color = sender.backgroundColor;
}

#pragma mark - UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    NSLog(@"%@", info);
    UIImage *pickImage = info[UIImagePickerControllerOriginalImage];
    
    FSImageHandleView *imageHandleView = [[FSImageHandleView alloc] initWithFrame:_paintView.frame];
    
    imageHandleView.block = ^(UIImage *image) {
        _paintView.image = image;
    };
    
    imageHandleView.image = pickImage;
    
    [self.view addSubview:imageHandleView];
    
//    _paintView.image = pickImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
