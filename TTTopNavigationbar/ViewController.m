//
//  ViewController.m
//  TTTopNavigationbar
//
//  Created by TT_code on 16/4/22.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "ViewController.h"
#import "BaseTabelviewVC.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSArray* titlearray;//数组
@property(nonatomic,strong)UIScrollView* scrollveiw;//滚动试图
@property(nonatomic,strong)UIScrollView* contentscrollveiw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基础设置
    self.titlearray=@[@"推荐",@"热点",@"上海",@"视频",@"社会",@"订阅",@"娱乐",@"图片",@"科技",@"汽车",@"体育",@"财经",@"军事",@"国际",@"段子",@"趣图",@"美女",@"健康",@"正能量",@"特卖"];
    
    
    //自定义导航条
    [self addtopview];
    
    //增加滚动试图
    [self addnavigationItem];
    
    
    //布局内容试图
    [self addcontentviews];
    
    
    // 默认显示第0个子控制器
    [self scrollViewDidScroll:self.contentscrollveiw];
    
}



-(void)addtopview
{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor=RGBCOLOR(199, 39, 47);
    [self.view addSubview:view];
    
    self.scrollveiw=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth-44, 44)];
    self.scrollveiw.showsHorizontalScrollIndicator=NO;
    self.scrollveiw.showsVerticalScrollIndicator=NO;
    self.scrollveiw.backgroundColor=[UIColor greenColor];
    [view addSubview:self.scrollveiw];
    
    //增加按钮
    UIButton* addBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-44, 20, 44, 44)];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(Add:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    
    //contnet scrollview
    self.contentscrollveiw=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.contentscrollveiw.delegate=self;
    self.contentscrollveiw.backgroundColor=[UIColor blueColor];
    [self.view addSubview:self.contentscrollveiw];
    
}


/**
 *  增加按钮
 *
 *  @param sender
 */
-(void)Add:(UIButton*)sender
{
    
}



-(void)addnavigationItem
{
    CGFloat height=44;
    CGFloat angle=20;//间隔
    CGFloat X=angle;
    for (int i=0; i< self.titlearray.count; i++) {
        CGRect fram=[self laysetWordsize:CGSizeMake(1000000, height) font:[UIFont systemFontOfSize:15] text: self.titlearray[i]];
        
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(X, 0, fram.size.width, height)];
        [button setTitle: self.titlearray[i] forState:UIControlStateNormal];
        button.tag=i;
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        X+=angle+fram.size.width;
        [self.scrollveiw addSubview:button];
    }
    [self.scrollveiw setContentSize:CGSizeMake(X,self.scrollveiw.bounds.size.height)];
    
}

/**
 *  点击事件
 *
 *  @param sender
 */
-(void)Click:(UIButton*)sender
{
    NSInteger index=sender.tag;
    [self.contentscrollveiw setContentOffset:CGPointMake(index * self.contentscrollveiw.frame.size.width, 0) animated:YES];
}


/**
 *  设置所有控制器
 */
-(void)addcontentviews
{
    for (NSString* title in self.titlearray) {
        BaseTabelviewVC* VC=[[BaseTabelviewVC alloc]init];
        VC.title=title;
        [self addChildViewController:VC];
    }
    self.contentscrollveiw.contentSize=CGSizeMake(self.contentscrollveiw.bounds.size.width * self.childViewControllers.count, self.contentscrollveiw.bounds.size.height);
    self.contentscrollveiw.pagingEnabled=YES;
    //默认一开始显示第一页
    [self scrollViewDidEndScrollingAnimation:self.contentscrollveiw];
}



/**
 *  计算文字大小
 *
 */
-(CGRect)laysetWordsize:(CGSize)size font:(UIFont*)font text:(NSString*)text
{
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : font} context:nil];
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //改变左右label文字的颜色
    CGFloat width=self.contentscrollveiw.bounds.size.width;
    CGFloat height=scrollView.bounds.size.height;
    CGFloat offsetX=scrollView.contentOffset.x;
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    NSInteger index = (int)scale;
    
    
    for (UIButton* button in self.scrollveiw.subviews) {
        [button setTitleColor:RGBCOLOR(243, 200, 201) forState:UIControlStateNormal];
    }
    
    if(index>=self.childViewControllers.count-1) return;
    
    
    NSLog(@"当前值:%ld",index);
    UIButton* prebutton=self.scrollveiw.subviews[index];
    UIButton* currentbutton=self.scrollveiw.subviews[index+1];
        
    NSInteger R=255-243;
    NSInteger G=255-200;
    NSInteger B=255-201;


    
//    CGFloat red = XMGRed + (1 - XMGRed) * scale;
//    CGFloat green = XMGGreen + (0 - XMGGreen) * scale;
//    CGFloat blue = XMGBlue + (0 - XMGBlue) * scale;
//    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

    
    // 243  200 201
    UIColor* pretitlecolor=RGBCOLOR(243+R*(scale-index), 200+G*(scale-index), 201+B*(scale-index));
    UIColor* currenttitlecolor=RGBCOLOR(255-R*(scale-index), 255-G*(scale-index), 255-B*(scale-index));
    
    [currentbutton setTitleColor:pretitlecolor forState:UIControlStateNormal];
    [prebutton setTitleColor:currenttitlecolor forState:UIControlStateNormal];
    
    
    
    
    CGFloat transformpre = 1 + (scale-index) * 0.2; // [1, 1.3]
    currentbutton.transform = CGAffineTransformMakeScale(transformpre, transformpre);
    
    
    CGFloat transformcurrent = 1 + (1-(scale-index)) * 0.2; // [1, 1.3]
    prebutton.transform = CGAffineTransformMakeScale(transformcurrent, transformcurrent);
    
    
    
    
}

#pragma mark --- 《scrollviewdelegate》

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width=scrollView.bounds.size.width;
    CGFloat height=scrollView.bounds.size.height;
    CGFloat offsetX=scrollView.contentOffset.x;
   
    
    //计算显示第几页
    NSInteger index=offsetX/width;
    CGFloat topwidth=self.scrollveiw.bounds.size.width;
    
    UIButton* currenbutton=self.scrollveiw.subviews[index];
    CGPoint titleoffsetpoint=self.scrollveiw.contentOffset;
    titleoffsetpoint.x = currenbutton.center.x - topwidth * 0.5;
    // 左边超出处理
    if (titleoffsetpoint.x < 0) titleoffsetpoint.x = 0;
      CGFloat maxTitleOffsetX = self.scrollveiw.contentSize.width - topwidth;
    if (titleoffsetpoint.x > maxTitleOffsetX) titleoffsetpoint.x = maxTitleOffsetX;
    
    [self.scrollveiw setContentOffset:titleoffsetpoint animated:YES];
    
    //显示试图
    UINavigationController* VC=self.childViewControllers[index];
    if([VC isViewLoaded]) return;//如果已经显示过了就不要显示了
    VC.view.frame=CGRectMake(width*index, 0, width, height);
    [self.contentscrollveiw addSubview:VC.view];
    
}



/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}





@end
