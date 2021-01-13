//
//  QRcodeViewController.m
//  Taidi
//
//  Created by eric on 2017/12/15.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "QRcodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <FMCategoryKit/FMCategoryKitNSString.h>
/**
 *  屏幕 高 宽 边界
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP ((SCREEN_HEIGHT-220)/2 - 64)
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

@interface QRcodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    int _num;
    BOOL _upOrdown;
    NSTimer * _timer;
    CAShapeLayer *_cropLayer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImageView * line;

@end

@implementation QRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
    [self setCropRect:kScanRect];
    [self setupCamera];
    self.navigationItem.title = @"扫一扫";
//    [self initNavigationBar];
}

//- (void)initNavigationBar
//{
//    //    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:-14 forBarMetrics:UIBarMetricsDefault];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"help_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
//}

-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"qr_pick_bg"];
    [self.view addSubview:imageView];
    
    _upOrdown = NO;
    _num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"qr_line"];
    [self.view addSubview:_line];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    [_session stopRunning];
    _session = nil;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)animation1
{
    if (_upOrdown == NO) {
        _num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*_num, 220, 2);
        if (2*_num == 200) {
            _upOrdown = YES;
        }
    }
    else {
        _num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*_num, 220, 2);
        if (_num == 0) {
            _upOrdown = NO;
        }
    }
    
}


- (void)setCropRect:(CGRect)cropRect{
    _cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [_cropLayer setFillRule:kCAFillRuleEvenOdd];
    [_cropLayer setPath:path];
    [_cropLayer setFillColor:[UIColor blackColor].CGColor];
    [_cropLayer setOpacity:0.6];
    
    
    [_cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:_cropLayer];
}

- (void)setupCamera
{
    
    // 在扫描之前加了判断相机的访问权限：
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到该应用后打开相机访问权限"preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SCREEN_HEIGHT;
    CGFloat left = LEFT/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        
        self.afterDoSomethingCallBack = ^(NSString *serialcode) {
            //停止扫描
            [_session stopRunning];
            [_timer setFireDate:[NSDate distantFuture]];
        };
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        NSLog(@"扫描结果：%@",stringValue);
        stringValue = [stringValue trimAllWhiteSpace];
        NSArray *arry = metadataObject.corners;
        for (id temp in arry) {
            NSLog(@"%@",temp);
        }
        
        if(stringValue && _scanResultCallBack){
            _scanResultCallBack(stringValue);
        }
      
        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}

-(void)dealloc{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

