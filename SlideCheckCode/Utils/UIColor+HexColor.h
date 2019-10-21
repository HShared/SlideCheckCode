//
//  UIColor+HexColor.h
//  SlideCheckCode
//
//  Created by ATH on 2019/6/19.
//  Copyright © 2019 WeiManYi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColor)

/**
 输入十六进制颜色,以#号开头

 @param hex 十六进制颜色,如黑色:#000000
 @return 颜色对应的UIColor
 */
+(UIColor *)colorWithHex:(NSString *)hex;

/**
  输入十六进制颜色,以#号开头

 @param hex 十六进制颜色,如黑色:#000000
 @param alpha 颜色透明度
 @return 颜色对应的UIColor
 */
+(UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
