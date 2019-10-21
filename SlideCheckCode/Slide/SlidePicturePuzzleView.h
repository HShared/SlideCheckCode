//
//  SlidePicturePuzzleView.h
//  SlideCheckCode
//
//  Created by ATH on 2019/10/16.
//  Copyright © 2019 WeiManYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidePicturePuzzleMode.h"
#import "UIColor+HexColor.h"
@class SlidePicturePuzzleView;
@protocol SlidePicturePuzzleDelegate<NSObject>
-(void)slidePicturePuzzleView:(SlidePicturePuzzleView*_Nonnull)slidePicturePuzzleView  checkStateWithXCoordinate:(CGFloat)x;
-(void)showSuceessViewComplete:(SlidePicturePuzzleView*_Nonnull)slidePicturePuzzleView;
@end
NS_ASSUME_NONNULL_BEGIN
#define HORIZONTAL_MARGIN 25
#define IV_I_W(i) i.image.size.width
#define IV_I_H(i) i.image.size.height
@interface SlidePicturePuzzleView : UIView
@property(nonatomic,weak)id<SlidePicturePuzzleDelegate>delegate;
@property(nonatomic,strong)UIImageView *bgIV;//背景图
@property(nonatomic,strong)UIImageView *slideIV;//滑块
@property(nonatomic,strong)UIButton *slideBtn;//滑动按钮
@property(nonatomic,strong)UIView *btnBgView;
@property(nonatomic,strong)UILabel *slideTipsLabel;//提示拖动滑块
@property(nonatomic,strong)UIView *slideProgressView;//进度条
//需要的一些数据：拼图背景，滑块，滑块的y坐标
@property(nonatomic,strong)SlidePicturePuzzleMode *model;
//滑动条背景颜色
@property(nonatomic,strong)UIColor *progressBgNormalColor;
//滑动条边界颜色
@property(nonatomic,strong)UIColor *progressBorderNormalColor;
//滑动条失败时背景颜色
@property(nonatomic,strong)UIColor *progressBgErrorColor;
//滑动条失败时边界颜色
@property(nonatomic,strong)UIColor *progressBorderErrorColor;

//滑动组件背景颜色
@property(nonatomic,strong)UIColor *bgColor;
//滑动组件边界颜色
@property(nonatomic,strong)UIColor *borderColor;
//圆角
@property(nonatomic,assign)int borderRadius;

/**
 显示滑动成功布局
 */
-(void)slideSuccess;

/**
   显示滑动失败动画调用此方法
 */
-(void)slideError;

/**
  显示滑动失败动画调用此方法
 @param completeBlock 滑动错误动画完成后调用completeBlock，可以为空
 */
-(void)slideErrorComplete:(nullable void(^)(void))completeBlock;
//显示页面
-(void)show;
//隐藏页面
-(void)hide;
@end

NS_ASSUME_NONNULL_END
