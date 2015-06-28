//
//  DT_DynamicCell.h
//  DTPro
//
//  Created by 刘沉 on 15/6/19.
//  Copyright (c) 2015年 chengyi huatian org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DT_DynamicCell : UITableViewCell
/**
 *  cell的属性
 */
@property (nonatomic, assign) NSDictionary *attributes;
/**
 *  内容
 */
@property (strong, nonatomic) UIView *containerView;
/**
 *  头像
 */
@property (strong, nonatomic) UIImageView *avasterV;
/**
 *  用户名
 */
@property(strong, nonatomic)UILabel *nameL;
/**
 *  性别图片
 */
@property(strong, nonatomic)UIImageView *sexV;
/**
 *  发表时间前的图标
 */
@property(strong, nonatomic)UIImageView *publishTimeV;
/**
 *  发表时间
 */
@property(strong, nonatomic)UILabel *publishTimeL;
/**
 *  来源
 */
@property(strong, nonatomic)UILabel *fromL;
/**
 *  内容
 */
@property(strong, nonatomic)UIView *contentV;
/**
 *  装载内容一下的控件，用于动画的平移
 */
@property(strong, nonatomic)UIView *containerV;
/**
 *  展开按钮
 */
@property(strong, nonatomic)UIButton *expandBtn;
/**
 *  照片内容
 */
@property(strong, nonatomic)UIView *pictureV;
/**
 *  底部交互区域
 */
@property(strong, nonatomic)UIView *bottomV;
/**
 *  底部区域分割线
 */
@property(strong, nonatomic)UIView *bottomSepV1;
/**
 *  底部区域分割线
 */
@property(strong, nonatomic)UIView *bottomSepV2;
/**
 *  喜欢按钮
 */
@property(strong, nonatomic)UIButton *likeBtn;
/**
 *  查看按钮
 */
@property(strong, nonatomic)UIButton *watchBtn;
/**
 *  评价按钮
 */
@property(strong, nonatomic)UIButton *commentBtn;
/**
 *  是否展开,YES为展开，NO为不展开，默认为NO
 */
@property(nonatomic)BOOL isExpand;

/**
 *  初始化数据
 *
 *  @param attributes 初始化内容字典
 *  @param expand     是否展开
 */
- (void)initWithAttributes:(NSDictionary *)attributes expand:(BOOL)expand;

/**
 *  初始化数据
 *
 *  @param attributes 初始化字典
 */
- (void)initWithAttributes:(NSDictionary *)attributes;

@end
