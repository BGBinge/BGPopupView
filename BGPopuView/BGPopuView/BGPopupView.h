//
//  BGPopupView.h
//  furniture
//
//  Created by Binge on 2017/3/4.
//  Copyright © 2017年 zhaoxiaoling. All rights reserved.
//

#import <UIKit/UIKit.h>

//弹框弹出动画
typedef enum {
    BGPopupAnimationTypeNone = 0,   //无动画
    BGPopupAnimationTypeAlpha,      //透明到显示
    BGPopupAnimationTypeZoom,       //放大
    
    BGPopupAnimationTypeViewTop,     //弹框顶部出现
    BGPopupAnimationTypeViewBottom,     //弹框底部出现
    BGPopupAnimationTypeViewLeft,     //弹框左侧出现
    BGPopupAnimationTypeViewRight,     //弹框右侧出现
    
    BGPopupAnimationTypeWindowTop,     //屏幕顶部出现
    BGPopupAnimationTypeWindowBottom,     //屏幕底部出现
    BGPopupAnimationTypeWindowLeft,     //屏幕左侧出现
    BGPopupAnimationTypeWindowRight     //屏幕右侧出现
    
} BGPopupAnimationType;


typedef void(^HiddenBlock)(void);


// 自定义弹出框
@interface BGPopupView : UIView


@property (nonatomic, copy) HiddenBlock hiddenBlock;// 弹框隐藏时调用的block




/**
 * @brief 弹出一个view
 *
 * @param  popView           UIView                需要弹出的view
 * @param  frame             CGRect                弹出框的位置
 * @param  animationType     BGPopupAnimationType  弹出动画
 *
 * @void
 */
+(void)showView:(UIView *)popView frame:(CGRect)frame animationType:(BGPopupAnimationType)animationType;

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
+(void)showView:(UIView *)popView frame:(CGRect)frame animationType:(BGPopupAnimationType)animationType hiddenBlock:(HiddenBlock)hiddenBlock;

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
+(void)showView:(UIView *)popView frame:(CGRect)frame bgAlpa:(CGFloat)bgAlpa animationType:(BGPopupAnimationType)animationType hiddenBlock:(HiddenBlock)hiddenBlock;


/**
 * @brief 弹出一个view到屏幕中心
 *
 * @param  popView           UIView                需要弹出的view
 * @param  animationType     BGPopupAnimationType  弹出动画
 *
 * @void
 */
+(void)showCenterView:(UIView *)popView animationType:(BGPopupAnimationType)animationType;



/**
 * @brief 弹出一个view到屏幕中心(带block)
 *
 * @param  popView           UIView                需要弹出的view
 * @param  animationType     BGPopupAnimationType  弹出动画
 * @param  hiddenBlock       HiddenBlock           弹框隐藏时调用的block
 *
 * @void
 */
+(void)showCenterView:(UIView *)popView animationType:(BGPopupAnimationType)animationType hiddenBlock:(HiddenBlock)hiddenBlock;



/**
 * @brief 弹出一个view到屏幕中心点击背景不消失
 *
 * @param  popView           UIView                需要弹出的view
 * @param  animationType     BGPopupAnimationType  弹出动画
 *
 * @void
 */
+(void)showNOHiddenCenterView:(UIView *)popView animationType:(BGPopupAnimationType)animationType;



/**
 * @brief 消失弹窗
 */
+(void)hiddenPopView;

@end
