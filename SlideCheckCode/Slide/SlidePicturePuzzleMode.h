//
//  SlidePicturePuzzleMode.h
//  SlideCheckCode
//
//  Created by ATH on 2019/10/16.
//  Copyright © 2019 WeiManYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SlidePicturePuzzleMode : NSObject
@property(nonatomic,strong)UIImage *bgImage;//背景图
@property(nonatomic,strong)UIImage *slideImage;//滑块
@property(nonatomic,strong)NSNumber *yCoordinate;//滑块的y坐标

@end

NS_ASSUME_NONNULL_END
