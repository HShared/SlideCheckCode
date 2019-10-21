//
//  SlidePicturePuzzleView.m
//  SlideCheckCode
//
//  Created by ATH on 2019/10/16.
//  Copyright © 2019 WeiManYi. All rights reserved.
//

#import "SlidePicturePuzzleView.h"
@interface SlidePicturePuzzleView()<CAAnimationDelegate>{
       CGPoint panPoint;
}
@property(nonatomic,strong)UIPanGestureRecognizer *panGesture;
@property(nonatomic,assign)BOOL needLayout;
@property(nonatomic,assign)CGFloat slideTime;
@end
#define SLIDEBTN_ANIMATION_KEY @"slideBtnMoveAnimation"
#define SLIDEIMAGE_ANIMATION_KEY @"slideImageMoveAnimation"
@implementation SlidePicturePuzzleView

-(UIPanGestureRecognizer*)panGesture{
    if(!_panGesture){
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureTouch:)];
        [_panGesture setMaximumNumberOfTouches:1];
        [_panGesture setMinimumNumberOfTouches:1];
    }
    return _panGesture;
}
-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initData];
        [self initView];
        
    }
    return self;
}
//初始化数据
-(void)initData{
 
    self.needLayout =false;
    self.slideTime = 0.5;

    self.progressBgNormalColor = [UIColor colorWithHex:@"#98CDFC"];
    self.progressBorderNormalColor=[UIColor colorWithHex:@"#388DD7"];
    self.progressBgErrorColor =[UIColor colorWithHex:@"#FA96A0"];
    self.progressBorderErrorColor=[UIColor colorWithHex:@"#FE3D48"];
    self.bgColor =[UIColor colorWithHex:@"#F5F5F5"];
    self.borderColor=[UIColor colorWithHex:@"#999999"];
    self.borderRadius = 8;
}

/**
 初始化控件
 */
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    self.bgIV = [[UIImageView alloc]init];
    [self.bgIV setContentMode:UIViewContentModeScaleAspectFit];
    [self.bgIV setImage:[UIImage imageNamed:@"bgImage"]];
    [self.bgIV.layer setCornerRadius:self.borderRadius];
    [self.bgIV setClipsToBounds:YES];
    [self addSubview:self.bgIV];
    
    self.slideIV = [[UIImageView alloc]init];
    [self.slideIV setImage:[UIImage imageNamed:@"slideImage"]];
    [self.slideIV setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.slideIV];
    
    self.btnBgView = [[UIView alloc]init];
    self.btnBgView.layer.borderWidth = 1;
    self.btnBgView.layer.borderColor = self.borderColor.CGColor;
    [self.btnBgView setBackgroundColor:self.bgColor];
    self.btnBgView.layer.cornerRadius = self.borderRadius;
    [self addSubview:self.btnBgView];
    
    self.slideProgressView = [[UIView alloc]init];
    self.slideProgressView.layer.borderWidth = 1;
    self.slideProgressView.layer.borderColor = self.progressBorderNormalColor.CGColor;
    [self.slideProgressView setBackgroundColor:self.progressBgNormalColor];
    self.slideProgressView.layer.cornerRadius = self.borderRadius;
    [self addSubview:self.slideProgressView];
    
    
    self.slideTipsLabel = [[UILabel alloc]init];
    [self.slideTipsLabel setFont:[UIFont systemFontOfSize:14]];
    [self.slideTipsLabel setText:@"请拖动滑块至正确缺口"];
    [self.slideTipsLabel setTextAlignment:NSTextAlignmentCenter];
    [self.slideTipsLabel setTextColor:[UIColor colorWithHex:@"#999999"]];
    [self addSubview:self.slideTipsLabel];

    self.slideBtn = [[UIButton alloc]init];
    [self.slideBtn setImage:[UIImage imageNamed:@"slide_btn_normal"] forState:UIControlStateNormal];
    [self.slideBtn addGestureRecognizer:self.panGesture];
    [self addSubview:self.slideBtn];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if(self.bgIV.frame.origin.x!=0&&!self.needLayout){
        return;
    }
    self.needLayout = false;
    CGFloat bgIVW =CGRectGetWidth(self.frame)-2*HORIZONTAL_MARGIN;
    CGFloat bgIVH = bgIVW*(self.bgIV.image.size.height/self.bgIV.image.size.width);
    CGFloat slideBtnH = self.slideBtn.imageView.image.size.height;
    CGFloat slideBtnW = self.slideBtn.imageView.image.size.width;
    CGFloat marginTop = CGRectGetHeight(self.frame)/2-(bgIVH+slideBtnH)/2;
    
    self.bgIV.frame = CGRectMake(HORIZONTAL_MARGIN,marginTop, bgIVW,bgIVH);

    self.btnBgView.frame = CGRectMake(HORIZONTAL_MARGIN,CGRectGetMaxY(self.bgIV.frame)+20,CGRectGetWidth(self.frame)-2*HORIZONTAL_MARGIN, slideBtnH);
   
    self.slideProgressView.frame = self.btnBgView.frame;
    [self setViewFrameW:self.slideProgressView w:15];
    
    self.slideTipsLabel.frame  = self.btnBgView.frame;
    self.slideBtn.frame = CGRectMake(HORIZONTAL_MARGIN,CGRectGetMinY(self.btnBgView.frame),slideBtnW, slideBtnH);
    
    CGFloat slideImageW = 40;
    CGFloat slideImageH = 40;
    CGFloat slideImageY = CGRectGetHeight(self.bgIV.frame)/2-slideImageH/2+marginTop;
    if(self.slideIV.image&&self.bgIV.image){
        slideImageW = IV_I_W(self.slideIV)/IV_I_W(self.bgIV)*bgIVW;
        slideImageH = IV_I_H(self.slideIV)/IV_I_H(self.bgIV)*bgIVH;
        slideImageY = bgIVH/IV_I_H(self.bgIV)*[self.model.yCoordinate floatValue];
        slideImageY += marginTop;
    }
    self.slideIV.frame = CGRectMake(CGRectGetMidX(self.slideBtn.frame)-slideImageW/2,slideImageY,slideImageW,slideImageH);
    
}

/**
 根据手势的滑动距离移动按钮的位置

 @param panGesture panGesture
 */
-(void)panGestureTouch:(UIPanGestureRecognizer*)panGesture{
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        panPoint = [panGesture locationInView:self.slideBtn];
    }
    if (panGesture.state != UIGestureRecognizerStateEnded && panGesture.state != UIGestureRecognizerStateFailed){
        CGPoint inViewLoction = [panGesture locationInView:self];//sender.view.superview
        CGFloat offsetX = inViewLoction.x-panPoint.x;
        if(offsetX<[self slideBtnMinOffsetX]){
            offsetX = [self slideBtnMinOffsetX];
        }else if(offsetX>[self slideBtnMaxOffsetX]){
            offsetX = [self slideBtnMaxOffsetX];
        }
        CGFloat centerX = offsetX+CGRectGetWidth(self.slideBtn.frame)/2;
        [self setViewFrameW:self.slideProgressView w:offsetX-[self slideBtnMinOffsetX]+15];
        [self setViewCenterX:self.slideIV x:centerX];
        [self setViewCenterX:self.slideBtn x:centerX];
        [panGesture setTranslation:CGPointZero inView:self];
       
    }
    if(panGesture.state == UIGestureRecognizerStateEnded){
        [self checkSlideImageState];
    }
}

/**
 通过代理让外部判断本次滑动是否正确
 */
-(void)checkSlideImageState{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(slidePicturePuzzleView:checkStateWithXCoordinate:)]){
        [self.slideBtn setUserInteractionEnabled:NO];
        [self.delegate slidePicturePuzzleView:self checkStateWithXCoordinate:[self getCurrentSlideImagePositionX]];
    }
}


/**
 获取当前拼图的X坐标
 @return 获取的坐标
 */
-(CGFloat)getCurrentSlideImagePositionX{
   CGFloat positionX = CGRectGetMinX(self.slideIV.frame)-CGRectGetMinX(self.bgIV.frame);
    return positionX/ CGRectGetWidth(self.bgIV.frame)*IV_I_W(self.bgIV);
}

/**
  显示滑动成功页面
 */
-(void)slideSuccess{
    [self.slideBtn setUserInteractionEnabled:YES];
    [self.slideTipsLabel setTextColor:[UIColor colorWithHex:@"#005FB2"]];
    [self.slideTipsLabel setFont:[UIFont systemFontOfSize:18]];
    UIImage *successImage = [UIImage imageNamed:@"check_success"];
    NSTextAttachment *textAttach = [[NSTextAttachment alloc]init];
    textAttach.image = successImage;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithAttributedString:[NSMutableAttributedString attributedStringWithAttachment:textAttach]];
    [str appendAttributedString:[[NSAttributedString alloc]initWithString:@" 验证成功"]];
//    [self.slideTipsLabel setBackgroundColor:[UIColor redColor]];
    [self.slideTipsLabel setAttributedText:str];
    [self setViewFrameW:self.slideProgressView w:CGRectGetWidth(self.btnBgView.frame)];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideBtn.alpha = 0;
        [self.slideProgressView setBackgroundColor:self.progressBgNormalColor];
        [self.slideProgressView.layer setBorderColor: self.progressBorderNormalColor.CGColor];
    } completion:^(BOOL finished){
        [self hide]; dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(self.delegate&&[self.delegate respondsToSelector:@selector(showSuceessViewComplete:)]){
                    [self.delegate showSuceessViewComplete:self];
                }
            });
        });
    }];
    
}
/**
 滑动验证错误调用此方法
 */
-(void)slideError{
    [self slideErrorComplete:nil];
}
/**
 滑动验证错误调用此方法
 @param completeBlock 滑动错误动画完成后调用completeBlock，可以为空
 */
-(void)slideErrorComplete:(nullable void(^)(void))completeBlock{
    [self.slideBtn setUserInteractionEnabled:YES];
    //开始错误
    CGFloat endSlideBtnPositionX = [self slideBtnMinOffsetX]+CGRectGetWidth(self.slideBtn.frame)/2;
    [self.slideBtn.layer addAnimation:[self createMovePositionAnimation:self.slideBtn.layer.position endPosition:CGPointMake(endSlideBtnPositionX,self.slideBtn.layer.position.y)] forKey:@"position"];
    [self.slideIV.layer addAnimation:[self createMovePositionAnimation:self.slideIV.layer.position endPosition:CGPointMake(endSlideBtnPositionX, self.slideIV.layer.position.y)] forKey:@"position"];
     [self.slideProgressView.layer addAnimation:[self createMovePositionAnimation:self.slideProgressView.layer.position endPosition:CGPointMake([self slideBtnMinOffsetX], self.slideProgressView.layer.position.y)] forKey:@"position"];
    [self.slideProgressView.layer addAnimation:[self createSlideLeftViewWidthAnimation] forKey:@"bounds"];
    
    [self.slideProgressView.layer setBorderColor:[UIColor colorWithHex:@"#FE3D48"].CGColor];
    [self.slideProgressView.layer setBackgroundColor:[UIColor colorWithHex:@"#FA96A0"].CGColor];
    [self.slideBtn setImage:[UIImage imageNamed:@"slide_btn_uncorrect"] forState:UIControlStateNormal];
    if(completeBlock!=nil){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [NSThread sleepForTimeInterval:self.slideTime+0.1];
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock();
            });
        });
    }
}


/**
 创建移动动画
 @param startPosition 动画开始的位置
 @param endPosition 动画结束位置
 @return 动画CABasicAnimation
 */
-(CABasicAnimation *)createMovePositionAnimation:(CGPoint)startPosition endPosition:(CGPoint)endPosition{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = self.slideTime;
    animation.repeatCount = 1;
    animation.fromValue = [NSValue valueWithCGPoint:startPosition];//
    animation.toValue = [NSValue valueWithCGPoint:endPosition];
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}

/**
 创建缩放动画：修改SlideLeftView的宽度
 @return CABasicAnimation
 */
-(CABasicAnimation *)createSlideLeftViewWidthAnimation{

    CGRect oldBounds = self.slideProgressView.bounds;
    CGRect newBounds = oldBounds;
    newBounds.size = CGSizeMake(1, oldBounds.size.height);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.duration = self.slideTime;
    animation.repeatCount = 1;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.fromValue = [NSValue valueWithCGRect:oldBounds];
    animation.toValue = [NSValue valueWithCGRect:newBounds];
    return animation;
}

/**
 设置控件中心的x坐标

 @param view 要设置的控件
 @param x 要设置的控件中心的x坐标
 */
-(void)setViewCenterX:(UIView*)view x:(CGFloat)x{
    CGPoint centerP = view.center;
    if(centerP.x==x){
        return;
    }
    centerP.x = x;
    view.center = centerP;
}

/**
  设置控件的宽度

 @param view 要设置的控件
 @param w 要设置的宽度
 */
-(void)setViewFrameW:(UIView*)view w:(CGFloat)w{
    CGRect frame = view.frame;
    if(frame.size.width == w){
        return;
    }
    frame.size.width = w;
    view.frame = frame;
    
    CGRect bounds = view.bounds;
    bounds.size.width = w;
    view.bounds = bounds;
}


/**
 滑动按钮的左边界坐标
 @return 左边界坐标
 */
-(CGFloat)slideBtnMinOffsetX{
    return CGRectGetMinX(self.btnBgView.frame);
}

/**
  滑动按钮的右边界坐标
 @return 右边界坐标
 */
-(CGFloat)slideBtnMaxOffsetX{
     return CGRectGetMaxX(self.btnBgView.frame)-CGRectGetWidth(self.slideBtn.frame);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self reset];
}


/**
 重置页面：滑块x坐标回到原点，各个控件的背景颜色回到初始值
 */
-(void)reset{
    CGFloat centerX = [self slideBtnMinOffsetX]+CGRectGetWidth(self.slideBtn.frame)/2;
    [self setViewCenterX:self.slideBtn x:centerX];
    [self setViewCenterX:self.slideIV x:centerX];
    [self setViewFrameW:self.slideProgressView w:15];

    [self.slideProgressView setBackgroundColor:self.progressBgNormalColor];
    [self.slideProgressView.layer setBorderColor:self.progressBorderNormalColor.CGColor];
    
    [self.slideBtn setImage:[UIImage imageNamed:@"slide_btn_normal"] forState:UIControlStateNormal];
    
    [self.slideTipsLabel setFont:[UIFont systemFontOfSize:14]];
    [self.slideTipsLabel setText:@"请拖动滑块至正确缺口"];
    [self.slideTipsLabel setTextColor:[UIColor colorWithHex:@"#999999"]];
    self.slideBtn.alpha =1;
    [self.slideBtn setUserInteractionEnabled:YES];
}
-(void)show{
    [self setHidden:NO];
    [self reset];
}
-(void)hide{
    [self setHidden:YES];
}

-(void)setModel:(SlidePicturePuzzleMode *)model{
    _model = model;
    [self.bgIV setImage:model.bgImage];
    [self.slideIV setImage:model.slideImage];
    self.needLayout = true;
    [self setNeedsLayout];
    
}

@end
