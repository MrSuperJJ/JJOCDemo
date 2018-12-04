//
//  JJImageBrowserViewController.h
//  JJOCDemo
//
//  Created by Mr.JJ on 2018/12/2.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJImageBrowserViewController : UIViewController

- (instancetype)initWithImageArray:(NSArray *)imageArray imageSize:(CGSize)imageSize currentIndex:(NSInteger)currentIndex;

@end
