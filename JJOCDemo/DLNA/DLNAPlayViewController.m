//
//  DLNAPlayViewController.m
//  JJOCDemo
//
//  Created by Mr.JJ on 2019/7/14.
//  Copyright © 2019 叶佳骏. All rights reserved.
//

#import "DLNAPlayViewController.h"
#import <GCDWebServer/GCDWebDAVServer.h>
#import "GCDWebServerDataResponse.h"
#import "GCDWebServerFileResponse.h"
#import "MRDLNA.h"

@interface DLNAPlayViewController () <GCDWebDAVServerDelegate>

@property (nonatomic, strong) GCDWebDAVServer *webDAVServer;  ///< 内置服务器
@property (nonatomic, strong) MRDLNA  *dlnaManager;           ///< DLNA工具类

@end

@implementation DLNAPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投屏中";
    [self setupServer];
}

- (void)setupServer {
    __weak typeof(self) weakSelf = self;
    [self.webDAVServer addHandlerForMethod:@"GET" pathRegex:@"/file" requestClass:[GCDWebServerRequest class] asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
        GCDWebServerFileResponse *response = [GCDWebServerFileResponse responseWithFile:weakSelf.playURLPath byteRange:request.byteRange];
        completionBlock(response);
    }];
    [self.webDAVServer start];
}

-(void)dealloc{
    [self.webDAVServer stop];
    self.webDAVServer = nil;
    [self.dlnaManager endDLNA];
}

#pragma mark - GCDWebDAVServerDelegate
- (void)webServerDidStart:(GCDWebServer *)server {
    switch (self.playType) {
        case DLNAPlayTypeImage:{
            self.dlnaManager.typeStr = @"1";
            break;
        }
        case DLNAPlayTypeVideo: {
            self.dlnaManager.typeStr = @"2";
            break;
        }
        default:
            break;
    }
    self.dlnaManager.playUrl = [NSString stringWithFormat:@"%@file", self.webDAVServer.serverURL.absoluteString];
    [self.dlnaManager startDLNA];
}

#pragma mark getters and setters
- (MRDLNA *)dlnaManager {
    if (nil == _dlnaManager) {
        _dlnaManager = [MRDLNA sharedMRDLNAManager];
    }
    return _dlnaManager;
}

- (GCDWebDAVServer *)webDAVServer {
    if (nil == _webDAVServer) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _webDAVServer = [[GCDWebDAVServer alloc] initWithUploadDirectory:documentsPath];
        _webDAVServer.delegate = self;
    }
    return _webDAVServer;
}

@end
