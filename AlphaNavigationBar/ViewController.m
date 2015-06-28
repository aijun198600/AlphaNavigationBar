//
//  ViewController.m
//  AlphaNavigationBar
//
//  Created by 刘沉 on 15/6/28.
//  Copyright (c) 2015年 chengyi huatian org. All rights reserved.
//

//设备屏幕的宽
#define screen_width [UIScreen mainScreen].bounds.size.width
//设备屏幕的高
#define screen_height [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

#import "ViewController.h"
#import "UINavigationBar+Awesome.h"
#import "DT_DynamicCell.h"
#import "iCarousel.h"
#import "UIImage+blurring.h"
#import "TaoBaPublishAlertView.h"

@interface ViewController ()<iCarouselDataSource, iCarouselDelegate, UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation ViewController{
    
    UIButton *leftBtn;
    UIButton *rightBtn;
    
    UIView *topBarView;
    UIImageView *topAvatarView;    //顶部栏的头像
    UIImageView *avatarView;    //scrollview的头像
    
    UITableView *personalTableV;
    
    NSArray *photoList;     //照片数组
    NSMutableArray *dynamicList;    //动态内容数组
    NSMutableArray *dynamicExpandList;   //动态内容展开数组
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if (personalTableV) {
        personalTableV.delegate = self;
    }
    topBarView.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    personalTableV.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    topBarView.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBtnNavLeft];
    [self addBtnNavRight];
    
    [self initData];
    
     [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    personalTableV.delegate = nil;      //防止返回时，还在滚动导致崩溃
    [topBarView removeFromSuperview];
    
}

- (void)initData{
    
    photoList = @[
                  @"bbc_tr_ht_b",
                  @"bbc_tr_jz_b",
                  @"bbc_tr_nsns_b",
                  @"bbc_tr_st_b",
                  @"bbc_tr_zt_b",
                  @"bbc_th_msry"
                  ];
    
    dynamicList = [[NSMutableArray alloc] init];
    dynamicExpandList = [[NSMutableArray alloc] init];
    NSArray *list = @[
                      @{
                          @"avatar":@"bbc_tr_nsns_b",
                          @"uname":@"Mini!",
                          @"timebefore":@"今天12点",
                          @"from":@"[广州]顺德技术学院",
                          @"sex":@"1",
                          @"title":@"下周考试，听说不监考",
                          @"piclist":@[],
                          @"likenums":@(100),
                          @"clicknums":@(2000),
                          @"comtnums":@(10)
                          },
                      @{
                          @"avatar":@"bbc_tr_nsns_b",
                          @"uname":@"Max",
                          @"timebefore":@"今天12点",
                          @"from":@"[广州]顺德技术学院",
                          @"sex":@"0",
                          @"title":@"求约，无聊中~，蛋疼中国年·",
                          @"piclist":@[
                                  @"bbc_th_smdq"
                                  ],
                          @"likenums":@(100),
                          @"clicknums":@(2000),
                          @"comtnums":@(10)
                          },
                      @{
                          @"avatar":@"bbc_tr_nsns_b",
                          @"uname":@"NotMax!",
                          @"timebefore":@"今天12点",
                          @"from":@"[广州]顺德技术学院",
                          @"sex":@"1",
                          @"title":@"UI够熬高i骄傲丝光机农安三等功静安寺漏电开关记录卡大数据哦i按计划i瓯江爱菊哈紧迫感骄傲的回家啊圣诞节",
                          @"piclist":@[
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq",
                                  @"bbc_th_smdq"
                                  ],
                          @"likenums":@(100),
                          @"clicknums":@(2000),
                          @"comtnums":@(10)
                          }
                      ];
    
    [dynamicList addObjectsFromArray:list];
    
    for (int i=0; i<[dynamicList count]; i++) {
        [dynamicExpandList addObject:@(NO)];
    }
    
}

- (void)addBtnNavLeft{
    
    CGRect barRect = self.navigationController.navigationBar.bounds;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, barRect.size.height, barRect.size.height)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = barRect.size.height/2.0;
    [button setImage:[UIImage imageNamed:@"homepage_back_icon03"] forState:UIControlStateNormal];
    [button setBackgroundColor:RGBCOLOR(101, 101, 101)];
//    [button addTarget:self action:@selector(btnNavLeftAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn = button;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)addBtnNavRight{
    
    CGRect barRect = self.navigationController.navigationBar.bounds;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, barRect.size.height, barRect.size.height)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = barRect.size.height/2.0;
    [button setImage:[UIImage imageNamed:@"homepage_message_icon03"] forState:UIControlStateNormal];
    [button setBackgroundColor:RGBCOLOR(101, 101, 101)];
    [button addTarget:self action:@selector(btnNavRightAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn = button;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)initUI{
    
    personalTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    personalTableV.delegate = self;
    personalTableV.dataSource = self;
    personalTableV.backgroundColor = [UIColor clearColor];
    personalTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:personalTableV];
    
    personalTableV.tableHeaderView = [self obtainHeaderView];
    
}

- (UIView *)obtainHeaderView{
    
    UIView *headerView = [[UIView alloc] init];
    
    CGFloat screenW = screen_width;
    
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [headerView addSubview:bgImgView];
    
    CGFloat avatarW = screenW*250.0/1080.0;
    UIImage *img = [UIImage imageNamed:@"bbc_tr_nsns_b"];
    avatarView = [[UIImageView alloc] initWithFrame:CGRectMake((screenW-avatarW)/2.0, screenW*40.0/1080.0-44.0, avatarW, avatarW)];
    avatarView.image = img;
    topAvatarView.image = img;
    avatarView.contentMode = UIViewContentModeScaleAspectFill;
    avatarView.layer.masksToBounds = YES;
    avatarView.layer.cornerRadius = avatarW/2.0;
    avatarView.layer.borderWidth = 2.0;
    avatarView.layer.borderColor = [RGBCOLOR(45, 41, 40) CGColor];
    [headerView addSubview:avatarView];
    
    
    CGRect nameLFrame;
    NSString *nameStr = @"Mini";
    CGFloat baseFontSize = screenW*55.0/1080.0/1.2;
    CGFloat nameLW = [self TextWidth:nameStr Font:[UIFont systemFontOfSize:baseFontSize] Height:baseFontSize*1.2];
    CGFloat nameLMaxW = screenW - 2*screenW*140.0/1080.0;
    if (nameLW > nameLMaxW) {
        nameLFrame = CGRectMake(screenW*140.0/1080.0, avatarView.frame.origin.y+ avatarView.frame.size.height + screenW*40.0/1080.0, nameLMaxW, baseFontSize*1.2);
    }else{
        nameLFrame = CGRectMake((screenW-nameLW)/2.0, avatarView.frame.origin.y+ avatarView.frame.size.height + screenW*40.0/1080.0, nameLW, baseFontSize*1.2);
    }
    UILabel *nameL = [[UILabel alloc] initWithFrame:nameLFrame];
    nameL.font = [UIFont systemFontOfSize:baseFontSize];
    nameL.text = nameStr;
    nameL.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:nameL];
    
    CGFloat sexVW = screenW*55.0/1080.0;
    CGRect sexVFrame = CGRectMake(nameLFrame.origin.x+nameLFrame.size.width, nameLFrame.origin.y+(nameLFrame.size.height-sexVW)/2.0, sexVW, sexVW);
    NSString *sexStr = @"1";
    UIImageView *sexV = [[UIImageView alloc] initWithFrame:sexVFrame];
    if ([sexStr intValue] == 1) {
        //女
        sexV.image = [UIImage imageNamed:@"sex_woman01"];
    }else if ([sexStr intValue] == 0){
        sexV.image = [UIImage imageNamed:@"sex_man01"];
    }
    [headerView addSubview:sexV];
    
    CGFloat smallFontSize = baseFontSize*50.0/55.0;
    CGRect schoolLFrame = CGRectMake(0, nameLFrame.origin.y+nameLFrame.size.height + screenW*40.0/1080.0, screenW, smallFontSize*1.2);
    UILabel *schoolL = [[UILabel alloc] initWithFrame:schoolLFrame];
    schoolL.text = @"南方医科大学顺德校区[广州]";
    schoolL.font = [UIFont systemFontOfSize:smallFontSize];
    schoolL.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:schoolL];
    
    CGRect collegeLFrame = CGRectMake(0, schoolLFrame.origin.y+schoolLFrame.size.height, screenW, smallFontSize*1.2);
    UILabel *collegeL = [[UILabel alloc] initWithFrame:collegeLFrame];
    collegeL.text = @"经济管理学院";
    collegeL.font = [UIFont systemFontOfSize:smallFontSize];
    collegeL.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:collegeL];
    
    CGFloat leftPadding = screenW*30.0/1080.0;
    CGFloat userInfoBtnW = screenW*250.0/1080.0;
    CGFloat userInfoBtnH = screenW*60.0/1080.0;
    UIButton *userInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, collegeLFrame.origin.y+collegeLFrame.size.height, userInfoBtnW, userInfoBtnH)];
    [userInfoBtn setBackgroundColor:[UIColor clearColor]];
    [userInfoBtn.titleLabel setFont:[UIFont systemFontOfSize:smallFontSize]];
    [userInfoBtn setTitle:@"TA的资料" forState:UIControlStateNormal];
    [userInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    userInfoBtn.layer.masksToBounds = YES;
    userInfoBtn.layer.cornerRadius = 5.0;
    userInfoBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    userInfoBtn.layer.borderWidth = 1.0;
    [headerView addSubview:userInfoBtn];
    
    CGFloat numberLW = screenW*180.0/1080.0;
    CGFloat numberLH = screenW*60.0/1080.0;
    UILabel *numberL = [[UILabel alloc] initWithFrame:CGRectMake(screenW-leftPadding-numberLW, userInfoBtn.frame.origin.y+(userInfoBtnH-numberLH)/2.0, numberLW, numberLH)];
    numberL.text = @"12/20";
    numberL.textColor = [UIColor whiteColor];
    numberL.textAlignment = NSTextAlignmentCenter;
    numberL.font = [UIFont systemFontOfSize:screenW*45.0/1080.0/1.2];
    numberL.backgroundColor = RGBCOLOR(101, 101, 101);
    numberL.layer.masksToBounds = YES;
    numberL.layer.cornerRadius = 10.0;
    [headerView addSubview:numberL];
    
    CGRect bgImgViewFrame = CGRectMake(0, -64.0, screenW, userInfoBtn.frame.origin.y+userInfoBtn.frame.size.height+screenW*20.0/1080.0+64.0);
    bgImgView.frame = bgImgViewFrame;
    //    bgImgView.backgroundColor = [UIColor redColor];
    
    //异步模糊
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *fuzzyImg = [img blurring];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            bgImgView.image = fuzzyImg;
            
        });
    });
    
    CGFloat photoSelectVH = screenW*280.0/1080.0;
    iCarousel *photoSelectV = [[iCarousel alloc] initWithFrame:CGRectMake(0, bgImgViewFrame.origin.y+bgImgViewFrame.size.height, screenW, photoSelectVH)];
    photoSelectV.backgroundColor = RGBCOLOR(119, 115, 115);
    photoSelectV.delegate = self;
    photoSelectV.dataSource = self;
    photoSelectV.type = iCarouselTypeLinear;
    [photoSelectV reloadData];
    [headerView addSubview:photoSelectV];
    
    headerView.frame = CGRectMake(0, 0, screenW, photoSelectV.frame.origin.y+photoSelectV.frame.size.height);
    
    return headerView;
    
}

#pragma mark - iCarousel methods
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return photoList.count;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    CGFloat screenW = screen_width;
    UIImageView *imgView = nil;
    if (view == nil){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW/4.0, screenW*280.0/1080.0)];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-screenW*260.0/1080.0)/2.0, screenW*10.0/1080.0, screenW*260.0/1080.0, screenW*260.0/1080.0)];
        imgView.tag = 2001;
        [view addSubview:imgView];
    }else{
        imgView = (UIImageView *)[view viewWithTag:2001];
    }
    
    imgView.image = [UIImage imageNamed:[photoList objectAtIndex:index]];
    
    return view;
    
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value;
        }
        case iCarouselOptionFadeMax:
        {
            return 0.0f;
        }
        case iCarouselOptionShowBackfaces:
        {
            return YES;
        }
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return 5;
        }
    }
    //return value;
}

# pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dynamicList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

# pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"DT_ DynamicCell";
    DT_DynamicCell *cell=(DT_DynamicCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[DT_DynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *attributes = [dynamicList objectAtIndex:indexPath.section];
    [cell initWithAttributes:attributes expand:[[dynamicExpandList objectAtIndex:indexPath.section] boolValue]];
    [cell.expandBtn addTarget:self action:@selector(expandBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

# pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor whiteColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat distance = offsetY + 64.0;
    CGFloat screenW = screen_width;
    CGFloat avatarW = screenW*250.0/1080.0;
    if (distance < avatarW && avatarW - distance >44.0 && offsetY > -64.0 && avatarView) {
        
        CGFloat aw = avatarW - distance;
        avatarView.frame = CGRectMake((screenW-aw)/2.0, screenW*40.0/1080.0-44.0 + distance, aw, aw);
        avatarView.layer.cornerRadius = aw/2.0;
        
    }
    
    CGFloat oldY = - 20.0- (screenW*40.0/1080.0-44.0) ;
    CGFloat offsetYL = avatarW - 64.0 - 44.0;
    
    if (offsetY > offsetYL + oldY) {
        
        avatarView.hidden = YES;
        topAvatarView.hidden = NO;
        
        //64的距离，alpha从0到1。
        CGFloat alpha;
        CGFloat btnAlpha;
        if (offsetY-(offsetYL + oldY) < 64.0) {
            alpha = (offsetY-(offsetYL + oldY))/64.0;
            if (offsetY-(offsetYL + oldY) < 32.0) {
                btnAlpha = 1 - (offsetY-(offsetYL + oldY))/32.0;
                [self btnStartState];
            }else{
                btnAlpha =  (offsetY-(offsetYL + oldY) - 32.0)/32.0;
                [self btnSwitchState];
            }
        }else{
            alpha = 1.0;
            btnAlpha = 1.0;
            [self btnSwitchState];
        }
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        leftBtn.alpha = btnAlpha;
        rightBtn.alpha = btnAlpha;
        
    }else{
        topAvatarView.hidden = YES;
        avatarView.hidden = NO;
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        [self btnStartState];
        leftBtn.alpha = 1.0;
        rightBtn.alpha = 1.0;
        
    }
    
}

//按钮初始状态
- (void)btnStartState{
    
    [leftBtn setImage:[UIImage imageNamed:@"homepage_back_icon03"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = RGBCOLOR(101, 101, 101);
    [rightBtn setImage:[UIImage imageNamed:@"homepage_message_icon03"] forState:UIControlStateNormal];
    rightBtn.backgroundColor = RGBCOLOR(101, 101, 101);
    
}

//按钮下拉切换图片状态
- (void)btnSwitchState{
    
    [leftBtn setImage:[UIImage imageNamed:@"homepage_back_icon02"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"homepage_message_icon02"] forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor clearColor];
    
}


//展开按钮点击
- (void)expandBtn:(UIButton *)sender{
    
    CGRect rect = [sender convertRect:sender.bounds toView:personalTableV];
    NSIndexPath *cellPath = [personalTableV indexPathsForRowsInRect:rect][0];
    BOOL isExpand = [[dynamicExpandList objectAtIndex:cellPath.section] boolValue];
    [dynamicExpandList replaceObjectAtIndex:cellPath.section withObject:@(!isExpand)];
    [personalTableV reloadData];
    
}

- (void)btnNavRightAction{
    TaoBaPublishAlertView *alertView = [[TaoBaPublishAlertView alloc] init];
    [alertView show];
}

#pragma mark - 通用方法
- (CGFloat)TextWidth:(NSString *)str2 Font:(UIFont *)font Height:(CGFloat)height{
    NSString *str=[NSString stringWithFormat:@"%@",str2];
    CGSize constraint = CGSizeMake(MAXFLOAT, height);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:dic context:nil].size;
    return size.width;
}
@end
