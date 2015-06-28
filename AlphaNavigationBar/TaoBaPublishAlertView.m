//
//  TaoBaPublishAlertView.m
//  IDou
//
//  Created by 刘沉 on 15/5/6.
//  Copyright (c) 2015年 developer. All rights reserved.
//

#import "TaoBaPublishAlertView.h"
#import <Accelerate/Accelerate.h>

@implementation TaoBaPublishAlertView{
    UIImageView *bgImgV;
    UIView *_coverView;      //遮盖层
    UIView *_alertView;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self screenShot];
        
        [self initUI];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    return self;
}

- (void)initUI{
    
    self.frame = [UIScreen mainScreen].bounds;
    bgImgV = [[UIImageView alloc]initWithFrame:self.frame];
    bgImgV.image = [self accelerateBlurWithImage:self.snapshot];
    bgImgV.alpha = 1.0;
    [self addSubview:bgImgV];
    
    _coverView = [[UIView alloc]initWithFrame:self.frame];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.0;
    [self addSubview:_coverView];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat btnW = screenW*270.0/1080.0;
    
    CGRect btnVFrame = CGRectMake(0, screenH, screenW, btnW);
    _alertView = [[UIView alloc] initWithFrame:btnVFrame];
    [_alertView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_alertView];
    
    CGFloat btnPadding = screenW*140.0/1080.0;
    
    CGRect goodBtnFrame = CGRectMake((screenW-btnPadding)/2.0-btnW, 0, btnW, btnW);
    UIButton *goodBtn = [[UIButton alloc] initWithFrame:goodBtnFrame];
    [goodBtn setImage:[UIImage imageNamed:@"amoy_goods"] forState:UIControlStateNormal];
    [goodBtn setTag:66+0];
    [goodBtn addTarget:self action:@selector(btnClick:) forControlEvents:64];
    [_alertView addSubview:goodBtn];
    
    CGRect personBtnFrame = CGRectMake((screenW+btnPadding)/2.0, 0, btnW, btnW);
    UIButton *personBtn = [[UIButton alloc] initWithFrame:personBtnFrame];
    [personBtn setImage:[UIImage imageNamed:@"amoy_people"] forState:UIControlStateNormal];
    [personBtn setTag:66+1];
    [personBtn addTarget:self action:@selector(btnClick:) forControlEvents:64];
    [_alertView addSubview:personBtn];
}

- (void)btnClick:(UIButton *)sender
{
    NSInteger tag = sender.tag-66;
    if ([self.delegate respondsToSelector:@selector(alertView:buttonClick:)]) {
        [self dismiss];
        [self.delegate alertView:self buttonClick:tag];
    }
}

- (void)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        _coverView.alpha = 0.6;
        
    } completion:^(BOOL finished) {
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *topView = window.subviews[0];
        [topView addSubview:self];
        [self showAnimation];
        
    }];
    
}

- (void)showAnimation {
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat btnW = screenW*270.0/1080.0;
        CGFloat btnPB = screenW*440.0/1080.0;
        
        CGRect btnVFrame = CGRectMake(0, screenH-btnW-btnPB, screenW, btnW);
        
        _alertView.frame = btnVFrame;
    } completion:nil];
    
}

- (void)dismiss{
    [self hideAnimation];
}

- (void)hideAnimation{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat btnW = screenW*270.0/1080.0;
        
        CGRect btnVFrame = CGRectMake(0, screenH, screenW, btnW);
        _alertView.frame = btnVFrame;
        bgImgV.alpha = 0.0;
        _coverView.alpha = 0.0;
        
    } completion:^(BOOL finished){
        
        [self removeFromSuperview];
        
    }];
    
}

- (void)screenShot
{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = window.subviews[0];
    
    CGSize size = topView.frame.size;
    UIGraphicsBeginImageContext(size);
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    // 裁剪的关键代码,要裁剪的矩形范围
    CGRect rect = CGRectMake(0, 0, size.width, size.height  );
    [topView drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    
    self.snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
}

- (UIImage *)accelerateBlurWithImage:(UIImage *)image
{
    //模糊度
    NSInteger boxSize = (NSInteger)(10 * 1);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer, rgbOutBuffer;
    vImage_Error error;
    
    void *pixelBuffer, *convertBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    convertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    rgbOutBuffer.width = CGImageGetWidth(img);
    rgbOutBuffer.height = CGImageGetHeight(img);
    rgbOutBuffer.rowBytes = CGImageGetBytesPerRow(img);
    rgbOutBuffer.data = convertBuffer;
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    
    if (pixelBuffer == NULL) {
        NSLog(@"No pixelbuffer");
    }
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    void *rgbConvertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    vImage_Buffer outRGBBuffer;
    outRGBBuffer.width = CGImageGetWidth(img);
    outRGBBuffer.height = CGImageGetHeight(img);
    outRGBBuffer.rowBytes = 3;
    outRGBBuffer.data = rgbConvertBuffer;
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    const uint8_t mask[] = {2, 1, 0, 3};
    
    vImagePermuteChannels_ARGB8888(&outBuffer, &rgbOutBuffer, mask, kvImageNoFlags);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(rgbOutBuffer.data,
                                             rgbOutBuffer.width,
                                             rgbOutBuffer.height,
                                             8,
                                             rgbOutBuffer.rowBytes,
                                             colorSpace,
                                             kCGBitmapAlphaInfoMask &kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    
    free(pixelBuffer);
    free(convertBuffer);
    free(rgbConvertBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


@end
