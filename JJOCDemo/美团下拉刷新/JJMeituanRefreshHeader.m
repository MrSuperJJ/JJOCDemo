//
//  JJMeituanRefreshHeader.m
//  JJOCDemo
//
//  Created by 叶佳骏 on 2018/11/29.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJMeituanRefreshHeader.h"

@interface JJMeituanRefreshHeader ()

@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation JJMeituanRefreshHeader

- (void)prepare {
    [super prepare];
    
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pulling_0%zd", i]];
        [pullingImages addObject:image];
    }
    [self setImages:pullingImages forState:MJRefreshStateIdle];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
//    NSLog(@"%lf, %lf, %lf, %lf", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    UIImageView *gifView = [self valueForKey:@"gifView"];
    gifView.contentMode = UIViewContentModeScaleAspectFit;
    [gifView setFrame:CGRectMake(gifView.frame.origin.x, self.mj_h + self.offsetY, gifView.frame.size.width, -self.offsetY)];
    NSLog(@"%lf, %lf, %lf, %lf", gifView.frame.origin.x, gifView.frame.origin.y, gifView.frame.size.width, gifView.frame.size.height);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    CGPoint new = [change[@"new"] CGPointValue];
    self.offsetY = - MIN(self.mj_h, -new.y);
    [self setNeedsLayout];
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    UIImageView *gifView = [self valueForKey:@"gifView"];
//    NSLog(@"%lf, %lf, %lf, %lf", gifView.frame.origin.x, gifView.frame.origin.y, gifView.frame.size.width, gifView.frame.size.height);
}

@end
