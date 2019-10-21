//
//  UIColor+HexColor.m
//  SlideCheckCode
//
//  Created by ATH on 2019/6/19.
//  Copyright © 2019 WeiManYi. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)
+(UIColor *)colorWithHex:(NSString *)hex{

    return [UIColor colorWithHex:hex alpha:1];
}
+(UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha{
    if(!hex||![hex hasPrefix:@"#"]||[hex length]!=7){
        return [UIColor whiteColor];
    }
    int red = [UIColor convertHexToByte:[hex substringWithRange:NSMakeRange(1, 2)]];
    int green = [UIColor convertHexToByte:[hex substringWithRange:NSMakeRange(3, 2)]];
    int blue = [UIColor convertHexToByte:[hex substringWithRange:NSMakeRange(5, 2)]];
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
//两位十六进制转成byte
+(Byte)convertHexToByte:(NSString *)hex{
    if([hex length]!=2){
        return 0;
    }
     hex = [hex lowercaseString];
    char hex1 = [hex characterAtIndex:0];
    int hight = 0;
    if(hex1>=48&&hex1<=57){
        hight = hex1-48;
    }else if(hex1>=97&&hex1<=102){
         hight = hex1- 97+10;
    }else{
        hight = 0;
    }
    
    char hex2 = [hex characterAtIndex:1];
    int low = 0;
    if(hex2>=48&&hex2<=57){
        low = hex2-48;
    }else if(hex2>=97&&hex2<=102){
        low = hex2- 97+10;
    }else{
        low = 0;
    }
    
    return 16*hight +low;
}
@end
