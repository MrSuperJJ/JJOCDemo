//
//  JJImageBrowserViewController.m
//  JJOCDemo
//
//  Created by Mr.JJ on 2018/12/2.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJImageBrowserViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JJImageBrowserViewController ()

@property (nonatomic, strong) UIScrollView *imageScrollView;

@property (nonatomic, copy) NSArray *imageArray;        ///<图片数组
@property (nonatomic, assign) CGSize imageSize;         ///<图片大小
@property (nonatomic, assign) NSInteger currentIndex;   ///<当前显示图片的索引


@end

@implementation JJImageBrowserViewController

- (instancetype)initWithImageArray:(NSArray *)imageArray imageSize:(CGSize)imageSize currentIndex:(NSInteger)currentIndex {
    self = [super init];
    if (self) {
        _imageArray = imageArray;
        _imageSize = imageSize;
        _currentIndex = currentIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:self.imageScrollView];

    self.imageScrollView.contentSize = CGSizeMake(_imageArray.count * self.view.frame.size.width, self.view.frame.size.height);
    self.imageScrollView.contentOffset = CGPointMake(_currentIndex * self.view.frame.size.width, 0);

    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _imageSize.width, _imageSize.height)];
        imageView.center = CGPointMake(_imageScrollView.frame.size.width * (i + 0.5) , _imageScrollView.frame.size.height * 0.5);
        imageView.backgroundColor = [UIColor grayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_imageScrollView addSubview:imageView];

        id image = _imageArray[i];
        if ([image isKindOfClass:[UIImage class]]) {
            imageView.image = image;
        } else if ([image isKindOfClass:[NSData class]]) {
            imageView.image = [UIImage imageWithData:image];
        } else if ([image isKindOfClass:[NSURL class]]) {
            [imageView sd_setImageWithURL:image];
        } else if ([image isKindOfClass:[NSString class]]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event responses
- (void)imageScrollViewTapped:(UITapGestureRecognizer *)recoginzer {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters and setters
- (UIScrollView *)imageScrollView {
    if (nil == _imageScrollView) {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _imageScrollView.backgroundColor = [UIColor grayColor];
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.bounces = NO;
        _imageScrollView.pagingEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageScrollViewTapped:)];
        [_imageScrollView addGestureRecognizer:tapGestureRecognizer];
    }
    return _imageScrollView;
}

@end
