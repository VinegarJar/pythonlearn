//
//  BankCard.m
//  CardScan
//
//  Created by Keith on 16/8/26.
//  Copyright © 2016年 Keith. All rights reserved.
//

#import "BankCard.h"
#import "CameraManager.h"
#import "OverlayView.h"
#import "RectManager.h"

@interface BankCard ()<CameraManagerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) CameraManager *manager;
@property (nonatomic, strong) OverlayView *overlayView;
@end

@implementation BankCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"银行卡";
    
    [self.view insertSubview:self.overlayView atIndex:0];
    
    self.manager.delegate = self;
    self.manager.sessionPreset = AVCaptureSessionPreset1280x720;
    NSError *error = nil;
    if ([self.manager setupSession:&error]) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:view atIndex:0];
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.manager.captureSession];
        layer.frame = [[UIScreen mainScreen] bounds];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [view.layer addSublayer:layer];
        
        [self.manager startSession];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![self.manager.captureSession isRunning]) {
        [self.manager startSession];
        [self.manager resetParams];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if ([self.manager.captureSession isRunning]) {
        [self.manager stopSession];
    }
}

-(CameraManager *)manager{
    if (!_manager) {
        _manager = [[CameraManager alloc] init];
    }
    return _manager;
}

-(OverlayView *)overlayView{
    if (!_overlayView) {
        CGRect frame = [OverlayView getOverlayFrame:[[UIScreen mainScreen] bounds]];
        _overlayView = [[OverlayView alloc] initWithFrame:frame];
    }
    return _overlayView;
}

-(void)didEndRecNumber:(NSString *)number bank:(NSString *)bank image:(UIImage *)image{
       NSLog(@"========>%@ \n =====%@",number,bank);
    [self.manager stopSession];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:bank message:number delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (![self.manager.captureSession isRunning]) {
        [self.manager startSession];
        [self.manager resetParams];
    }

}

@end
