# BGPopupView
## 一行代码实现弹出控件（弹窗）




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


