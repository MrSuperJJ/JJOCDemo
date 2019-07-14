//
//  DLNASourceViewController.m
//  JJOCDemo
//
//  Created by Mr.JJ on 2019/7/14.
//  Copyright © 2019 叶佳骏. All rights reserved.
//

#import "DLNASourceViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "DLNAPlayViewController.h"

static NSString *MainCellIdentifier = @"MainTableViewCell";

@interface DLNASourceViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableResultArray;
@property (strong, nonatomic) UIImagePickerController *pickerController;
@property (nonatomic, assign) DLNAPlayType playType;

@end

@implementation DLNASourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"DLNS数据源";
    self.tableResultArray = @[@"本地图片", @"本地视频"];
    [self.view addSubview:self.tableView];
    self.pickerController.delegate = self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableResultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _tableResultArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            self.playType = DLNAPlayTypeImage;
            self.pickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
            [self presentViewController:self.pickerController animated:YES completion:nil];
            break;
        case 1:
            self.playType = DLNAPlayTypeVideo;
            self.pickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, nil];
            self.pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
            [self presentViewController:self.pickerController animated:YES completion:nil];
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", info);
    DLNAPlayViewController *playViewController = [[DLNAPlayViewController alloc] init];
    playViewController.playType = self.playType;
    switch (self.playType) {
        case DLNAPlayTypeImage:
            playViewController.playURLPath = info[UIImagePickerControllerImageURL];
            break;
        case DLNAPlayTypeVideo:
            playViewController.playURLPath = info[UIImagePickerControllerMediaURL];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:playViewController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MainCellIdentifier];
    }
    return _tableView;
}

- (UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc]init];
    }
    return _pickerController;
}

@end
