//
//  BGPopupView.m
//  furniture
//
//  Created by Binge on 2017/3/4.
//  Copyright © 2017年 zhaoxiaoling. All rights reserved.
//

#import "BGPopupView.h"

#define BGPopupViewDuration 0.2 // 动画时间


@interface BGPopupView ()
{
}

@property (nonatomic, strong) UIButton *backBtn; // 背景按钮（背景阴影效果，和点击事件）
@property (nonatomic, strong) NSString *hiddenKey; // 背景点击后消失KEY
@property (nonatomic, strong) UIView *popView; // 弹出的控件
@property (nonatomic, assign) BGPopupAnimationType animalType;
@property (nonatomic, assign) CGRect popFrame;
@property (nonatomic, assign) CGFloat popAlpha;


@end



@implementation BGPopupView


/// 返回单例
+(BGPopupView *)shareBGPopupView
{
    static BGPopupView *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[self alloc] init];
        [data loadBaceView];
    });
    if (data.popView)
    {
        [data hiddenPopView];
    }
    return data;
}

/// 加载化基础控件
-(void)loadBaceView
{
    // 获取当前window
    UIWindow *selfWindow = [[UIApplication sharedApplication].delegate window];
    self.frame = selfWindow.bounds;
    self.backgroundColor = [UIColor clearColor];
    
    self.backBtn = [[UIButton alloc] initWithFrame:self.bounds];
    _backBtn.backgroundColor = [UIColor blackColor];
    _backBtn.alpha = 0.5;
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
}

/// 消失弹出框
-(void)hiddenPopView
{
    for (UIView *subView in self.subviews)
    {
        if (subView != self.backBtn)
        {
            [subView removeFromSuperview];
        }
    }
    if (self.hiddenBlock)
    {
        self.hiddenBlock();
        self.hiddenBlock = nil;
    }
    self.popView.frame = self.popFrame;
    self.popView.alpha = 1;
    self.backBtn.alpha = 0;
    self.hiddenKey = @"";
    self.popFrame = CGRectZero;
    self.popView = nil;
    [self removeFromSuperview];
}


/**
 * @brief 弹出一个view
 *
 * @param  popView           UIView                需要弹出的view
 * @param  frame             CGRect                弹出框的位置
 * @param  animationType     BGPopupAnimationType  弹出动画
 *
 * @void
 */
+(void)showView:(UIView *)popView frame:(CGRect)frame animationType:(BGPopupAnimationType)animationType
{
    // 1.获取单例
    BGPopupView *contentView = [self shareBGPopupView];
    // 2.将要弹出的view加载到显示界面
    contentView.popView = popView;
    contentView.animalType = animationType;
    contentView.popFrame = frame;
    popView.frame = frame;
    [contentView addSubview:popView];
    contentView.backBtn.alpha = 0.3;
    // 3.加载到Window
    [[[UIApplication sharedApplication].delegate window] addSubview:contentView];
    // 4.开始动画
    [contentView animationShow];
    
}



/**
 * @brief 弹出一个view(带block)
 *
 * @param  popView           UIView                需要弹出的view
 * @param  frame             CGRect                弹出框的位置
 * @param  animationType     BGPopupAnimationType  弹出动画
 * @param  hiddenBlock       HiddenBlock           弹框隐藏时调用的block
 *
 * @void
 */
+(void)showView:(UIView *)popView frame:(CGRect)frame animationType:(BGPopupAnimationType)animationType hiddenBlock:(HiddenBlock)hiddenBlock
{
    // 1.获取单例
    BGPopupView *contentView = [self shareBGPopupView];
    contentView.hiddenBlock = hiddenBlock;
    // 2.将要弹出的view加载到显示界面
    contentView.popView = popView;
    contentView.animalType = animationType;
    contentView.popFrame = frame;
    popView.frame = frame;
    [contentView addSubview:popView];
    contentView.backBtn.alpha = 0.3;
    // 3.加载到Window
    [[[UIApplication sharedApplication].delegate window] addSubview:contentView];
    // 4.开始动画
    [contentView animationShow];
}



/**
 * @brief 弹出一个view(带block,透明度)
 *
 * @param  popView           UIView                需要弹出的view
 * @param  frame             CGRect                弹出框的位置
 * @param  bgAlpa            CGFlot                背景颜色透明度
 * @param  animationType     BGPopupAnimationType  弹出动画
 * @param  hiddenBlock       HiddenBlock           弹框隐藏时调用的block
 *
 * @void
 */
+(void)showView:(UIView *)popView frame:(CGRect)frame bgAlpa:(CGFloat)bgAlpa animationType:(BGPopupAnimationType)animationType hiddenBlock:(HiddenBlock)hiddenBlock
{
    // 1.获取单例
    BGPopupView *contentView = [self shareBGPopupView];
    contentView.backBtn.alpha = bgAlpa==0?0.05:bgAlpa;
    contentView.hiddenBlock = hiddenBlock;
    // 2.将要弹出的view加载到显示界面
    contentView.popView = popView;
    contentView.animalType = animationType;
    contentView.popFrame = frame;
    popView.frame = frame;
    [contentView addSubview:popView];
    // 3.加载到Window
    [[[UIApplication sharedApplication].delegate window] addSubview:contentView];
    // 4.开始动画
    [contentView animationShow];
}



/**
 * @brief 弹出一个view到屏幕中心
 *
 * @param  popView           UIView                需要弹出的view
 * @param  animationType     BGPopupAnimationType  弹出动画
 *
 * @void
 */
+(void)showCenterView:(UIView *)popView animationType:(BGPopupAnimationType)animationType
{
    // 1.获取单例
    BGPopupView *contentView = [self shareBGPopupView];
    // 2.将要弹出的view加载到显示界面
    contentView.popView = popView;
    contentView.animalType = animationType;
    popView.frame = CGRectMake((contentView.frame.size.width - popView.frame.size.width)/2, (contentView.frame.size.height - popView.frame.size.height)/2, popView.frame.size.width, popView.frame.size.height);
    [contentView addSubview:popView];
    contentView.popFrame = popView.frame;
    contentView.backBtn.alpha = 0.3;
    // 3.加载到Window
    [[[UIApplication sharedApplication].delegate window] addSubview:contentView];
    // 4.开始动画
    [contentView animationShow];
}


/**
 * @brief 弹出一个view到屏幕中心(带block)
 *
 * @param  popView           UIView                需要弹出的view
 * @param  animationType     BGPopupAnimationType  弹出动画
 * @param  hiddenBlock       HiddenBlock           弹框隐藏时调用的block
 *
 * @void
 */
+(void)showCenterView:(UIView *)popView animationType:(BGPopupAnimationType)animationType hiddenBlock:(HiddenBlock)hiddenBlock
{
    // 1.获取单例
    BGPopupView *contentView = [self shareBGPopupView];
    contentView.hiddenBlock = hiddenBlock;
    // 2.将要弹出的view加载到显示界面
    contentView.popView = popView;
    contentView.animalType = animationType;
    popView.frame = CGRectMake((contentView.frame.size.width - popView.frame.size.width)/2, (contentView.frame.size.height - popView.frame.size.height)/2, popView.frame.size.width, popView.frame.size.height);
    [contentView addSubview:popView];
    contentView.popFrame = popView.frame;
    contentView.backBtn.alpha = 0.3;
    // 3.加载到Window
    [[[UIApplication sharedApplication].delegate window] addSubview:contentView];
    // 4.开始动画
    [contentView animationShow];
}



/**
 * @brief 弹出一个view到屏幕中心点击背景不消失
 *
 * @param  popView           UIView                需要弹出的view
 * @param  animationType     BGPopupAnimationType  弹出动画
 *
 * @void
 */
+(void)showNOHiddenCenterView:(UIView *)popView animationType:(BGPopupAnimationType)animationType
{
    // 1.获取单例
    BGPopupView *contentView = [self shareBGPopupView];
    contentView.hiddenKey = @"notHidden";
    // 2.将要弹出的view加载到显示界面
    contentView.popView = popView;
    contentView.animalType = animationType;
    popView.frame = CGRectMake((contentView.frame.size.width - popView.frame.size.width)/2, (contentView.frame.size.height - popView.frame.size.height)/2, popView.frame.size.width, popView.frame.size.height);
    [contentView addSubview:popView];
    contentView.popFrame = popView.frame;
    // 3.加载到Window
    [[[UIApplication sharedApplication].delegate window] addSubview:contentView];
    // 4.开始动画
    [contentView animationShow];
}


/**
 * @brief 消失弹窗
 */
+(void)hiddenPopView
{
    // 1.获取单例
    BGPopupView *contentView = [self shareBGPopupView];
    [contentView animationHidden];
}



/**
 显示动画
 */
-(void)animationShow
{
    BGPopupAnimationType type = self.animalType;
    UIView *popView = self.popView;
    
    switch (type) {
        case 0:
        {
            //无动画效果
        }
            break;
        case 1:
        {
            // 透明渐变
            popView.alpha = 0;
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.alpha = 1.0;
            }];
        }
            break;
        case 2:
        {
            // 放大
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2, 0, 0);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
            
        }
            break;
        case 3:
        {
            //弹框顶部出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
        case 4:
        {
            //弹框底部出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 0);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
        case 5:
        {
            //弹框左侧出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.origin.x, frame.origin.y, 0, frame.size.height);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
        case 6:
        {
            //弹框右侧出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, 0, frame.size.height);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
        case 7:
        {
            //屏幕顶部出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
        case 8:
        {
            //屏幕底部出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.origin.x, self.frame.size.height, frame.size.width, frame.size.height);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
        case 9:
        {
            //屏幕左侧出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
        case 10:
        {
            //屏幕右侧出现
            CGRect frame = popView.frame;
            popView.frame = CGRectMake(frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = frame;
            }];
        }
            break;
            
        default:
            break;
    }
}


/**
 消失动画

 */
-(void)animationHidden
{
    BGPopupAnimationType type = self.animalType;
    UIView *popView = self.popView;
    __weak BGPopupView *weakSelf = self;
    CGRect frame = popView.frame;
    
    switch (type) {
        case 0:
        {
            //无动画效果
            [self hiddenPopView];
        }
            break;
        case 1:
        {
            // 透明渐变
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.alpha = 0;
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 2:
        {
            // 放大
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
                popView.frame = CGRectMake(frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2, 0, 0);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
            
        }
            break;
        case 3:
        {
            //弹框顶部出现
            
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                //                self.backBtn.alpha = 0.5;
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 4:
        {
            //弹框底部出现
            
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 0);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 5:
        {
            //弹框左侧出现
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(frame.origin.x, frame.origin.y, 0, frame.size.height);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 6:
        {
            //弹框右侧出现
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, 0, frame.size.height);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 7:
        {
            //屏幕顶部出现
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 8:
        {
            //屏幕底部出现
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(frame.origin.x, self.frame.size.height, frame.size.width, frame.size.height);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 9:
        {
            //屏幕左侧出现
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
        case 10:
        {
            //屏幕右侧出现
            [UIView animateWithDuration:BGPopupViewDuration animations:^{
                
//                CGRect frame = popView.frame;
                popView.frame = CGRectMake(frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
            } completion:^(BOOL finished) {
                [weakSelf hiddenPopView];
            }];
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - 阴影背景被点击
-(void)backBtnAction
{
    if ([self.hiddenKey isEqualToString:@"notHidden"]) {
        return;
    }
    [self animationHidden];
}




@end
