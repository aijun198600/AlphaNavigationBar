//
//  DT_DynamicCell.m
//  DTPro
//
//  Created by 刘沉 on 15/6/19.
//  Copyright (c) 2015年 chengyi huatian org. All rights reserved.
//

//设备屏幕的宽
#define screen_width [UIScreen mainScreen].bounds.size.width
//设备屏幕的高
#define screen_height [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#import "DT_DynamicCell.h"

@implementation DT_DynamicCell{
    CGFloat screenW;
    CGFloat baseFontSize;       //基准字体大小
    CGFloat smallFontSize;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        screenW = [UIScreen mainScreen].bounds.size.width;
        baseFontSize = screenW*55.0/1080.0/1.2;
        smallFontSize = baseFontSize*50.0/55.0;
        
        self.isExpand = NO;
        
        self.frame = CGRectZero;
        
        
        self.containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.containerView];
        
        self.avasterV = [[UIImageView alloc] init];
        [self.containerView addSubview:self.avasterV];
        
        self.nameL = [[UILabel alloc] init];
        self.nameL.font = [UIFont systemFontOfSize:baseFontSize];
        [self.containerView addSubview:self.nameL];
        
        self.sexV = [[UIImageView alloc] init];
        [self.containerView addSubview:self.sexV];
        
        self.publishTimeV = [[UIImageView alloc] init];
        self.publishTimeV.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:self.publishTimeV];
        
        self.publishTimeL = [[UILabel alloc] init];
        self.publishTimeL.font = [UIFont systemFontOfSize:smallFontSize];
        self.publishTimeL.textColor = RGBCOLOR(147, 149, 152);
        [self.containerView addSubview:self.publishTimeL];
        
        self.fromL = [[UILabel alloc] init];
        self.fromL.font = [UIFont systemFontOfSize:smallFontSize];
        self.fromL.textColor = RGBCOLOR(147, 149, 152);
        [self.containerView addSubview:self.fromL];
        
        self.contentV = [[UIView alloc] init];
        [self.containerView addSubview:self.contentV];
        
        self.containerV = [[UIView alloc] init];
        [self.containerView addSubview:self.containerV];
        
        self.expandBtn = [[UIButton alloc] init];
        [self.expandBtn.titleLabel setFont:[UIFont systemFontOfSize:baseFontSize]];
        [self.expandBtn setTitleColor:RGBCOLOR(27, 188, 155) forState:UIControlStateNormal];
        [self.containerV addSubview:self.expandBtn];
        
        self.pictureV = [[UIView alloc] init];
        [self.containerV addSubview:self.pictureV];
        
        self.bottomV = [[UIView alloc] init];
        self.bottomV.backgroundColor = RGBCOLOR(245, 251, 254);
        [self.containerV addSubview:self.bottomV];
        
        self.bottomSepV1 = [[UIView alloc] init];
        self.bottomSepV1.backgroundColor = RGBCOLOR(209, 211, 212);
        [self.bottomV addSubview:self.bottomSepV1];
        
        self.bottomSepV2 = [[UIView alloc] init];
        self.bottomSepV2.backgroundColor = RGBCOLOR(209, 211, 212);
        [self.bottomV addSubview:self.bottomSepV2];
        
        self.likeBtn = [[UIButton alloc] init];
        [self.likeBtn.titleLabel setFont:[UIFont systemFontOfSize:smallFontSize]];
        [self.likeBtn setImage:[UIImage imageNamed:@"bbc_zan_icon_nol"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"bbc_zan_icon"] forState:UIControlStateSelected];
        [self.likeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -2.5, 0, 2.5)];
        [self.likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, -2.5)];
        [self.bottomV addSubview:self.likeBtn];
        
        self.watchBtn = [[UIButton alloc] init];
        [self.watchBtn.titleLabel setFont:[UIFont systemFontOfSize:smallFontSize]];
        [self.watchBtn setImage:[UIImage imageNamed:@"bbc_browse_icon"] forState:UIControlStateNormal];
        [self.watchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -2.5, 0, 2.5)];
        [self.watchBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, -2.5)];
        [self.bottomV addSubview:self.watchBtn];
        
        self.commentBtn = [[UIButton alloc] init];
        [self.commentBtn.titleLabel setFont:[UIFont systemFontOfSize:smallFontSize]];
        [self.commentBtn setImage:[UIImage imageNamed:@"bbc_comment_icon"] forState:UIControlStateNormal];
        [self.commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -2.5, 0, 2.5)];
        [self.commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, -2.5)];
        [self.bottomV addSubview:self.commentBtn];
        
    }
    
    return self;
}

- (void)initWithAttributes:(NSDictionary *)attributes expand:(BOOL)expand{
    
    self.isExpand = expand;
    [self initWithAttributes:attributes];
    
}

- (void)initWithAttributes:(NSDictionary *)attributes{
    
    self.attributes = attributes;
    
    [self updateUI];
    
}

- (void)updateUI{
    
    NSString *avatarStr = [self.attributes objectForKey:@"avatar"];
    NSString *nameStr = [self.attributes objectForKey:@"uname"];
    NSString *timeStr = [self.attributes objectForKey:@"timebefore"];
    NSString *fromStr = [self.attributes objectForKey:@"from"];
    NSString *sexStr = [self.attributes objectForKey:@"sex"];
    NSString *contentStr = [self.attributes objectForKey:@"title"];
    NSArray *pictureList = [self.attributes objectForKey:@"piclist"];
    NSNumber *likeNum = [self.attributes objectForKey:@"likenums"];
    NSNumber *watchNum = [self.attributes objectForKey:@"clicknums"];
    NSNumber *commentNum = [self.attributes objectForKey:@"comtnums"];
    
    CGFloat cellPaddingTop = screenW*60.0/1080.0;
    CGFloat cellPaddingLeft = screenW*30.0/1080.0;
    CGFloat cellPaddingRight = screenW*20.0/1080.0;
    
    CGFloat avatarW = screenW*110.0/1080.0;
    CGRect avatarFrame = CGRectMake(cellPaddingRight, cellPaddingTop, avatarW, avatarW);
    self.avasterV.frame = avatarFrame;
    //    [self.avasterV sd_setImageWithURL:[NSURL URLWithString:avatarStr] placeholderImage:[UIImage imageNamed:@"default_image"]];
    [self.avasterV setImage:[UIImage imageNamed:avatarStr]];
    
    CGFloat timeLW = [self TextWidth:timeStr FontSize:smallFontSize Height:smallFontSize*1.2]+5;
    CGFloat timeVW = screenW*40.0/1080.0;
    CGFloat sexVW = screenW*40.0/1080.0;
    CGRect timeLFrame = CGRectMake(screenW-timeLW-cellPaddingLeft, cellPaddingTop+(baseFontSize-smallFontSize)*1.2, timeLW, smallFontSize*1.2);
    self.publishTimeL.text = timeStr;
    self.publishTimeL.frame = timeLFrame;
    
    CGRect timeVFrame = CGRectMake(timeLFrame.origin.x-timeVW, timeLFrame.origin.y+(timeLFrame.size.height - timeVW)/2.0, timeVW, timeVW);
    self.publishTimeV.image = [UIImage imageNamed:@"bbc_time_icon"];
    self.publishTimeV.frame = timeVFrame;
    
    CGFloat maxTitleW = timeVFrame.origin.x - avatarFrame.origin.x-sexVW-10;
    CGFloat titleLW = [self TextWidth:nameStr FontSize:baseFontSize Height:baseFontSize*1.2]+5;
    CGRect nameLFrame;
    if (titleLW < maxTitleW-sexVW) {
        nameLFrame = CGRectMake(cellPaddingLeft+avatarW+5, cellPaddingTop, titleLW, baseFontSize*1.2);
    }else{
        nameLFrame = CGRectMake(cellPaddingLeft+avatarW+5, cellPaddingTop, maxTitleW-sexVW, baseFontSize*1.2);
    }
    self.nameL.frame = nameLFrame;
    self.nameL.text = nameStr;
    
    CGRect sexVFrame = CGRectMake(nameLFrame.origin.x+nameLFrame.size.width, nameLFrame.origin.y+(nameLFrame.size.height-sexVW)/2.0, sexVW, sexVW);
    self.sexV.frame = sexVFrame;
    if ([sexStr intValue] == 0) {
        //男
        self.sexV.image = [UIImage imageNamed:@"sex_man01"];
    }else if([sexStr intValue] == 1){
        //女
        self.sexV.image = [UIImage imageNamed:@"sex_woman01"];
    }
    
    CGRect fromLFrame = CGRectMake(nameLFrame.origin.x, nameLFrame.origin.y+nameLFrame.size.height+5, screenW-nameLFrame.origin.x-cellPaddingLeft, smallFontSize*1.2);
    self.fromL.text = [NSString stringWithFormat:@"%@",fromStr];
    self.fromL.frame = fromLFrame;
    
    CGFloat contentW = screenW-nameLFrame.origin.x-cellPaddingLeft;
    //删除内容中所有的view,防止重复加载
    for (UIView *view in self.contentV.subviews) {
        [view removeFromSuperview];
    }
    UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentW, 100)];
    contentL.tag = 10001;
    if (self.isExpand == NO) {
        contentL.numberOfLines = 2;
    }else{
        contentL.numberOfLines = 0;
    }
    contentL.font= [UIFont systemFontOfSize:baseFontSize];
    contentL.text = contentStr;
    [self.contentV addSubview:contentL];
    [contentL sizeToFit];
    CGRect contentVFrame = CGRectMake(nameLFrame.origin.x, avatarFrame.origin.y+avatarFrame.size.height+5, contentW, contentL.frame.size.height);
    self.contentV.frame = contentVFrame;
    
    CGRect containerVFrame = CGRectMake(0, contentVFrame.origin.y+contentVFrame.size.height, screenW, 0);
    self.containerV.frame = containerVFrame;
    
    //如果内容的高度不够，应该隐藏expandBtn
    CGRect expandBtnFrame = CGRectMake(contentVFrame.origin.x,  0, baseFontSize*3, 0);
    CGFloat contentRealH = [self TextHeight:contentStr FontSize:baseFontSize Width:contentW];
    if(contentRealH>3*baseFontSize){
        self.expandBtn.hidden = NO;
        expandBtnFrame = CGRectMake(contentVFrame.origin.x,  0, baseFontSize*3, baseFontSize*1.2);
    }else{
        self.expandBtn.hidden = YES;
    }
    self.expandBtn.frame = expandBtnFrame;
    if (self.isExpand == NO) {
        [self.expandBtn setTitle:@"详情" forState:UIControlStateNormal];
    }else{
        [self.expandBtn setTitle:@"收起" forState:UIControlStateNormal];
    }
    
    //删除所有照片
    for (UIView *view in self.pictureV.subviews) {
        [view removeFromSuperview];
    }
    //图片宽度
    CGFloat picBorder = screenW*25.0/1080.0;
    CGFloat picW = (contentW-2*picBorder)/3.0;
    //行数
    NSInteger picRow;
    if (pictureList.count%3 == 0) {
        picRow = pictureList.count/3;
    }else{
        picRow = pictureList.count/3+1;
    }
    for(int i=0; i < pictureList.count; i++){
        
        UIImageView *picImgV = [[UIImageView alloc] initWithFrame:CGRectMake((i%3)*(picW+picBorder), picBorder+(picW+picBorder)*(i/3), picW, picW)];
        //        [picImgV sd_setImageWithURL:[NSURL URLWithString:[[pictureList objectAtIndex:i] objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"default_image"]];
        picImgV.image = [UIImage imageNamed:[pictureList objectAtIndex:i]];
        picImgV.userInteractionEnabled = YES;
        picImgV.layer.masksToBounds = YES;
        picImgV.contentMode = UIViewContentModeScaleAspectFill;
        //        [picImgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)]];
        [self.pictureV addSubview:picImgV];
        
    }
    CGRect pictureVFrame = CGRectMake(contentVFrame.origin.x, expandBtnFrame.origin.y+expandBtnFrame.size.height, contentW, picRow*(picW+picBorder)+picBorder);
    self.pictureV.frame = pictureVFrame;
    
    CGFloat bottomVH = screenW*100.0/1080.0;
    CGRect bottomVFrame = CGRectMake(0, pictureVFrame.size.height+pictureVFrame.origin.y+10, screenW, bottomVH);
    self.bottomV.frame = bottomVFrame;
    
    containerVFrame.size.height = bottomVFrame.size.height+bottomVFrame.origin.y;
    self.containerV.frame = containerVFrame;
    
    CGFloat sepH = bottomVH*0.7;
    CGRect sepFrame1 = CGRectMake(screenW/3.0, (bottomVH-sepH)/2.0, 1.6, sepH);
    self.bottomSepV1.frame = sepFrame1;
    CGRect sepFrame2 = CGRectMake(screenW*2.0/3.0, (bottomVH-sepH)/2.0, 1.6, sepH);
    self.bottomSepV2.frame = sepFrame2;
    
    self.likeBtn.frame = CGRectMake(0, 0, screenW/3.0, bottomVH);
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",likeNum] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:RGBCOLOR(240, 115, 171) forState:UIControlStateNormal];
    
    self.watchBtn.frame = CGRectMake(screenW/3.0, 0, screenW/3.0, bottomVH);
    [self.watchBtn setTitle:[NSString stringWithFormat:@"%@",watchNum] forState:UIControlStateNormal];
    [self.watchBtn setTitleColor:RGBCOLOR(245, 130, 31) forState:UIControlStateNormal];
    
    self.commentBtn.frame = CGRectMake(screenW*2.0/3.0, 0, screenW/3.0, bottomVH);
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%@",commentNum] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:RGBCOLOR(245, 130, 31) forState:UIControlStateNormal];
    
    self.containerView.frame = CGRectMake(0, 0, screenW, containerVFrame.origin.y+containerVFrame.size.height);
    
    self.frame = CGRectMake(0, 0, screenW, self.containerView.frame.origin.y+self.containerView.frame.size.height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (CGFloat)TextWidth:(NSString *)str2 FontSize:(CGFloat)fontsize Height:(CGFloat)height{
    NSString *str=[NSString stringWithFormat:@"%@",str2];
    CGSize constraint = CGSizeMake(MAXFLOAT, height);
    UILabel *lbl = [[UILabel alloc]init];
    UIFont *font =[UIFont fontWithName:lbl.font.familyName size:fontsize];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:dic context:nil].size;
    return size.width;
}

//固定宽度，获取字符串的高度
- (CGFloat)TextHeight:(NSString *)str2 FontSize:(CGFloat)fontsize Width:(CGFloat)width{
    NSString *str=[NSString stringWithFormat:@"%@",str2];
    CGSize constraint = CGSizeMake(width, MAXFLOAT);
    UILabel *lbl = [[UILabel alloc]init];
    UIFont *font =[UIFont fontWithName:lbl.font.familyName size:fontsize];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:dic context:nil].size;
    
    return size.height;
}

@end
