//
//  JJWeChatViewController.m
//  JJOCDemo
//
//  Created by Mr.JJ on 2018/12/2.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJWeChatViewController.h"
#import "JJWeChatFloatingButton.h"

@interface JJWeChatViewController ()

@end

@implementation JJWeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [JJWeChatFloatingButton show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
