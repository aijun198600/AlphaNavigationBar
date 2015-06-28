//
//  TaoBaPublishAlertView.h
//  IDou
//
//  Created by 刘沉 on 15/5/6.
//  Copyright (c) 2015年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaoBaPublishAlertView;

@protocol TaoBaPublishAlertViewDelegate <NSObject>

- (void)alertView:(TaoBaPublishAlertView *)alertView buttonClick:(NSInteger)tag;

@end

@interface TaoBaPublishAlertView : UIView

@property (strong, nonatomic) UIImage *snapshot;
@property (weak, nonatomic) id <TaoBaPublishAlertViewDelegate> delegate;

- (void)show;

- (void)dismiss;

@end
