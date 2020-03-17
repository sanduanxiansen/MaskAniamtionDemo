//
//  ViewController.m
//  maskDemo
//
//  Created by CC on 2018/7/18.
//  Copyright © 2018年 CC. All rights reserved.
//

#import "ViewController.h"

#import <GPUImage/GPUImage.h>

@interface ViewController ()

@property (nonatomic, strong) CAGradientLayer *maskImageViewLayer;

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 236, 40)];
    imageView.image = [UIImage imageNamed:@"live_gift_combo_blue"];
    [self.view addSubview:imageView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    button.center = self.view.center;
    [button addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];

    self.maskImageViewLayer.frame = imageView.bounds;
    imageView.layer.mask = self.maskImageViewLayer;



    

}

- (void)startAnimation {
    CGFloat duration = .3;

    self.maskImageViewLayer.startPoint = CGPointMake(0, 0);
    self.maskImageViewLayer.endPoint = CGPointMake(0.1, 0);

    CAKeyframeAnimation *startAnimation = [CAKeyframeAnimation animationWithKeyPath:@"startPoint"];
//    startAnimation.fromValue = ;
//    startAnimation.toValue = ;
    startAnimation.beginTime = .2*duration;
    startAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)], [NSValue valueWithCGPoint:CGPointMake(1, 0)]];
    startAnimation.duration = duration;
    startAnimation.fillMode = kCAFillModeForwards;

    startAnimation.removedOnCompletion = NO;
    startAnimation.repeatCount = 0;



    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"endPoint"];
    endAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.2, 0)];
    endAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 0)];
    endAnimation.duration = duration;
    endAnimation.fillMode = kCAFillModeForwards;
    endAnimation.removedOnCompletion = NO;
    endAnimation.repeatCount = 0;

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    [animationGroup setAnimations:@[startAnimation, endAnimation]];
    animationGroup.duration = duration + duration*.2;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;

    [self.maskImageViewLayer addAnimation:animationGroup forKey:@"123"];
}



- (void)resetMaskLayer {

}

- (CAGradientLayer *)maskImageViewLayer {
    if (!_maskImageViewLayer) {
        _maskImageViewLayer = [[CAGradientLayer alloc] init];
        // 颜色分配
        _maskImageViewLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor];

        // 颜色分割线
        //        _blueLayer.locations  = @[@(0.25), @(0.5), @(0.75)];

        // 起始点
        _maskImageViewLayer.startPoint = CGPointMake(0, 0);
        _maskImageViewLayer.endPoint   = CGPointMake(0.2, 0);
    }
    return _maskImageViewLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
