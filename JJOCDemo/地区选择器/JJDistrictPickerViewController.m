//
//  JJDistrictPickerViewController.m
//  JJOCDemo
//
//  Created by 叶佳骏 on 2018/12/4.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJDistrictPickerViewController.h"
#import "JJDistrictPickerView.h"

@interface JJDistrictPickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) JJDistrictPickerView *districtPickerView;

@property (nonatomic, strong) NSArray *districtNameArray;
@property (nonatomic, strong) NSMutableArray *selectedRowArray;

@end

@implementation JJDistrictPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.districtPickerView];
    self.districtNameArray = @[
                               @[
                                   @"北京市",
                                   @"天津市",
                                   @"河北省"
                                   ],
                               @[
                                   @[
                                       @"北京市"
                                       ],
                                   @[
                                       @"天津市",
                                       @"天津市1"
                                       ],
                                   @[
                                       @"石家庄",
                                       @"避暑山庄",
                                       @"事假山庄"
                                       ]
                                   ],
                               @[
                                    @[
                                        @[
                                            @"朝阳区",
                                            @"东城区"
                                            ]
                                        ],
                                    @[
                                        @[
                                            @"天津市1",
                                            @"天津市2"
                                            ],
                                        @[
                                            @"天津市3",
                                            @"天津市4"
                                            ]
                                        ],
                                    @[
                                        @[
                                            @"石家庄市1",
                                            @"石家庄市2"
                                            ],
                                        @[
                                            @"避暑山庄1",
                                            @"避暑山庄2"
                                            ],
                                        @[
                                            @"事假山庄1",
                                            @"事假山庄2"
                                            ]
                                        ]
                                   ]
                               ];
    self.selectedRowArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.districtNameArray.count; i++) {
        [self.selectedRowArray addObject:@(0)];
    }
}

#pragma mark - UIPickerViewDelegate & UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.districtNameArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.districtNameArray[component] count];
    } else if (component == 1) {
        return [self.districtNameArray[component][[self.selectedRowArray[0] intValue]] count];
    } else {
        return [self.districtNameArray[component][[self.selectedRowArray[0] intValue]][[self.selectedRowArray[1] intValue]] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.districtNameArray[component][row];
    } else if (component == 1) {
        return self.districtNameArray[component][[self.selectedRowArray[0] intValue]][row];
    } else {
        return self.districtNameArray[component][[self.selectedRowArray[0] intValue]][[self.selectedRowArray[1] intValue]][row];
    }
}
                               
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    for (NSInteger i = component + 1; i < self.selectedRowArray.count; i++) {
        self.selectedRowArray[i] = @(0);
        [pickerView selectRow:0 inComponent:i animated:NO];
    }
    self.selectedRowArray[component] = @(row);
    [pickerView reloadAllComponents];
    
    NSString *provinceName = self.districtNameArray[0][[self.selectedRowArray[0] intValue]];
    NSString *cityName = self.districtNameArray[1][[self.selectedRowArray[0] intValue]][[self.selectedRowArray[1] intValue]];
    NSString *districtName = self.districtNameArray[2][[self.selectedRowArray[0] intValue]][[self.selectedRowArray[1] intValue]][[self.selectedRowArray[2] intValue]];
    NSLog(@"%@", [NSString stringWithFormat:@"省：%@，市：%@，区：%@", provinceName, cityName, districtName]);
}

#pragma mark - getters and setters
- (JJDistrictPickerView *)districtPickerView {
    if (nil == _districtPickerView) {
        _districtPickerView = [[JJDistrictPickerView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300)];
        _districtPickerView.pickerView.delegate = self;
        _districtPickerView.pickerView.dataSource = self;
    }
    return _districtPickerView;
}

@end
