//
//  DLNAPlayViewController.h
//  JJOCDemo
//
//  Created by Mr.JJ on 2019/7/14.
//  Copyright © 2019 叶佳骏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DLNAPlayType) {
    DLNAPlayTypeImage,
    DLNAPlayTypeVideo
};

NS_ASSUME_NONNULL_BEGIN

@interface DLNAPlayViewController : UIViewController

@property (nonatomic, assign) DLNAPlayType playType;
@property (nonatomic, copy) NSString *playURLPath;

@end

NS_ASSUME_NONNULL_END
