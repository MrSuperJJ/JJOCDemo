//
//  JJAnimationImageViewController.m
//  JJOCDemo
//
//  Created by 叶佳骏 on 2018/12/5.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJAnimationImageViewController.h"

@interface JJAnimationImageViewController ()

@property (nonatomic, strong) UIImageView *animationImageView;

@end

@implementation JJAnimationImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.animationImageView];
    [self.animationImageView startAnimating];
}

- (UIImageView *)animationImageView {
    if (nil == _animationImageView) {
        _animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 178, 178)];
        NSMutableArray *loadingImageArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 85; i++) {
            @autoreleasepool {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i]];
                [loadingImageArray addObject:image];
            }
        }
        _animationImageView.animationImages = loadingImageArray;
//        _animationImageView.animationDuration = 10;
        _animationImageView.animationRepeatCount = 1;
    }
    return _animationImageView;
}

@end
