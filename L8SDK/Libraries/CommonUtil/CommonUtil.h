//
//  CommonUtil.h
//  bootstrap-ios
//
//  Created by Marcos Pinazo on 2/1/13.
//  Copyright (c) 2013 [WE ARE] DEVELAPPERS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define float_equal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define float_equal_zero(a) (fabs(a) < FLT_EPSILON)

#define keyAppVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]

typedef void(^OnEndAnimationHandler)(void);

@interface CommonUtil : NSObject

+ (NSString *)getDocumentsPath;

+ (NSString*)getSysInfoByName:(char *)typeSpecifier;

+ (NSString*)platform;

+ (BOOL)isVisible:(UIViewController *)viewController;

+ (void)addShadowToView:(UIView *)view withColor:(UIColor *)color alpha:(CGFloat)alpha radius:(CGFloat)radius offset:(CGSize)offset;

+ (void)removeShadowFromView:(UIView *)view;

+ (void)updateShadowOfView:(UIView *)view toBounds:(CGRect)bounds withDuration:(NSTimeInterval)duration;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *) imageWithView:(UIView *)view;

+ (UIColor *)lighterColorForColor:(UIColor *)color delta:(CGFloat)delta;

+ (UIColor *)darkerColorForColor:(UIColor *)color delta:(CGFloat)delta;

+(UIColor *)inverseColor:(UIColor *)color;

+ (BOOL)validateEmail:(NSString *)candidate;

+ (NSString *)hexToString:(NSString *)string;

@end
