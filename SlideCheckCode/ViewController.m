//
//  ViewController.m
//  SlideCheckCode
//
//  Created by ATH on 2019/10/21.
//  Copyright © 2019 ath. All rights reserved.
//

#import "ViewController.h"
#import "SlidePicturePuzzleView.h"
@interface ViewController ()<SlidePicturePuzzleDelegate>
@property(nonatomic,strong)UIButton *showSlideBtn;
@property(nonatomic,strong)SlidePicturePuzzleView *slide;
@end

@implementation ViewController
-(SlidePicturePuzzleView*)slide{
    if(!_slide){
        _slide = [[SlidePicturePuzzleView alloc]initWithFrame:self.view.bounds];
        _slide.delegate = self;
        [self.view addSubview:_slide];
    }
    return _slide;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)initView{
    self.showSlideBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 90, 30)];
    [self.showSlideBtn setTitle:@"滑动验证" forState:UIControlStateNormal];
    [self.showSlideBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.showSlideBtn addTarget:self action:@selector(showSlideBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showSlideBtn];
    
}
-(void)showSlideBtnClick{
    SlidePicturePuzzleMode *model = [[SlidePicturePuzzleMode alloc]init];
    [model setBgImage:[UIImage imageNamed:@"bgImage"]];
    [model setSlideImage:[UIImage imageNamed:@"slideImage"]];
    [model setYCoordinate:[NSNumber numberWithFloat:280]];
    [self.slide setModel:model];
    [self.slide show];
}

- (void)showSuceessViewComplete:(SlidePicturePuzzleView * _Nonnull)slidePicturePuzzleView {
   
}

- (void)slidePicturePuzzleView:(SlidePicturePuzzleView * _Nonnull)slidePicturePuzzleView checkStateWithXCoordinate:(CGFloat)x {
    NSLog(@"positionX:%f",x);
    if(x>449&&x<469){
        [slidePicturePuzzleView slideSuccess];
    }else{
        [slidePicturePuzzleView slideError];;
    }
}


@end
