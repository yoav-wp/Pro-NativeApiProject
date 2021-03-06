//
//  Tools.h
//  NativeAPIProject
//
//  Created by Nir Gaiger on 12/20/16.
//  Copyright © 2016 Domain Planet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(NSString *)getDefaultWysiwygCSSFontSize:(NSString *)fontSize;
@end
