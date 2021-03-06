//
//  Tools.m
//  NativeAPIProject
//
//  Created by Nir Gaiger on 12/20/16.
//  Copyright © 2016 Domain Planet Limited. All rights reserved.
//

#import "Tools.h"

@implementation Tools


+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString *)getDefaultWysiwygCSSFontSize:(NSString *)fontSize{
    NSString *style = [NSString stringWithFormat:@"<style>span{font-family:Montserrat;color:#75768A;font-size:%@;}h1,h2,h3,h4,h5,h6{line-height:0.5;color:#000;}h4,h5,h6{margin-bottom:5px;}a{color:#CD0000;}dt{color:#000;}img{max-width:90vw;}</style>",fontSize];
    return style;
}

@end
