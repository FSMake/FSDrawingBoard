//
//  ViewController.m
//  绘图板
//
//  Created by 樊樊帅 on 5/6/15.
//  Copyright (c) 2015 樊樊帅. All rights reserved.
//

#import "ViewController.h"
#import "FSPaintView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet FSPaintView *paintView;

@end

@implementation ViewController

- (IBAction)clearBoard:(UIBarButtonItem *)sender {
    [_paintView clearBoard];
}

- (IBAction)unDo:(UIBarButtonItem *)sender {
    [_paintView unDo];
}

- (IBAction)eraser:(UIBarButtonItem *)sender {
    [_paintView eraser];
}

- (IBAction)photo:(UIBarButtonItem *)sender {
}

- (IBAction)save:(UIBarButtonItem *)sender {
}

- (IBAction)slider:(UISlider *)sender {
    _paintView.lineWidth = sender.value;
}

- (IBAction)colorBtnClick:(UIButton *)sender {
    _paintView.color = sender.backgroundColor;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
