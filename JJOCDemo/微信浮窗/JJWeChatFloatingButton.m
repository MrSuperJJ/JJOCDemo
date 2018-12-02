//
//  JJWeChatFloatingButton.m
//  JJDemo
//
//  Created by Mr.JJ on 2018/11/28.
//  Copyright © 2018 yejiajun. All rights reserved.
//

#import "JJWeChatFloatingButton.h"
#import "JJSemiCircleView.h"
#import "JJNextViewController.h"
#import "JJAnimator.h"

@interface JJWeChatFloatingButton () <UINavigationControllerDelegate>

@end

@implementation JJWeChatFloatingButton
{
    CGPoint lastPoint;
    CGPoint pointInSelf;
}

static JJWeChatFloatingButton *floatingButton;
static JJSemiCircleView *semiCircleView;

#define fixedSpace 160.f

+ (void)show {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatingButton = [[JJWeChatFloatingButton alloc] initWithFrame:CGRectMake(10, 200, 60, 60)];
        semiCircleView = [[JJSemiCircleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace)];
    });

    /// 添加到界面上
    if (!semiCircleView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:semiCircleView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:semiCircleView];
    }
    if (!floatingButton.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:floatingButton];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:floatingButton];
    }

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - UITouch methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.superview];
    pointInSelf = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];

    ///四分之一圆动画展开
    if (CGRectEqualToRect(semiCircleView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace))) {
        [UIView animateWithDuration:0.2f animations:^{
            semiCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - fixedSpace, [UIScreen mainScreen].bounds.size.height - fixedSpace, fixedSpace, fixedSpace);
        }];
    }
    ///计算出来floatingButton的center坐标
    CGFloat centerX = currentPoint.x + (self.frame.size.width/2 - pointInSelf.x);
    CGFloat centerY = currentPoint.y + (self.frame.size.height/2 - pointInSelf.y);
    ///限制center坐标的范围值，不超过屏幕
//    30.f <= x <= [UIScreen mainScreen].bounds.size.width - 30.f
//    30.f <= y <= [UIScreen mainScreen].bounds.size.height - 30.f
    CGFloat x = MAX(30.f, MIN([UIScreen mainScreen].bounds.size.width - 30.f, centerX));
    CGFloat y = MAX(30.f, MIN([UIScreen mainScreen].bounds.size.height - 30.f, centerY));
    self.center = CGPointMake(x, y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    if (CGPointEqualToPoint(lastPoint, currentPoint)) {
        ///点击效果
        UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        navigationController.delegate = self;
        JJNextViewController *nextViewController = [[JJNextViewController alloc] init];
        [navigationController pushViewController:nextViewController animated:YES];
        return;
    }

    ///四分之一圆 动画收缩
    [UIView animateWithDuration:0.2f animations:^{
        /// 两个圆心的距离 <= 两个半径之差：说明了floatingButton在semiCircleView内部，就可以移除
        double distance = sqrt(pow([UIScreen mainScreen].bounds.size.width - self.center.x, 2) + pow([UIScreen mainScreen].bounds.size.height - self.center.y, 2));
        if (distance <= fixedSpace - 30.f) {
            [self removeFromSuperview];
        }
        semiCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace);
    }];

    ///离左右两侧的距离
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = [UIScreen mainScreen].bounds.size.width - leftMargin;

    if (leftMargin < rightMargin) {
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake(40.f, self.center.y);
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40.f, self.center.y);
        }];
    }
}

#pragma mark - UINavigationBarDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        JJAnimator *animator = [[JJAnimator alloc] init];
        animator.currentFrame = self.frame;
        return animator;
    }
    return nil;
}


@end
