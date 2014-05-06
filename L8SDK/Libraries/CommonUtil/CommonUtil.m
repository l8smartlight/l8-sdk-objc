//
//  CommonUtil.m
//  bootstrap-ios
//
//  Created by Marcos Pinazo on 2/1/13.
//  Copyright (c) 2013 [WE ARE] DEVELAPPERS. All rights reserved.
//

#import "CommonUtil.h"

#import <UIKit/UIKit.h>
#include <sys/sysctl.h>
#import <QuartzCore/QuartzCore.h>

@implementation CommonUtil

+ (NSString *)getDocumentsPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString*)getSysInfoByName: (char*) typeSpecifier {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char* answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString* results = [NSString stringWithCString: answer encoding: NSUTF8StringEncoding];
    free(answer);
    return results;
}

+ (NSString*)platform {
    return [CommonUtil getSysInfoByName: "hw.machine"];
}

+ (BOOL)isVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window != nil);
}

+ (void)addShadowToView:(UIView *)view withColor:(UIColor *)color alpha:(CGFloat)alpha radius:(CGFloat)radius offset:(CGSize)offset
{
    CGRect shadowFrame = view.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    view.layer.shadowPath = shadowPath;
	view.layer.shadowOpacity = alpha;
	view.layer.shadowRadius = radius;
	view.layer.shadowOffset = offset;
	if (color) {
		view.layer.shadowColor = [color CGColor];
	}
	view.layer.masksToBounds = NO;
    //view.layer.shouldRasterize = YES;
    //view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

+ (void)removeShadowFromView:(UIView *)view
{
	view.layer.shadowOpacity = 0.0;
	view.layer.shadowRadius = 0.0;
	view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowColor = nil;

}

+ (void)updateShadowOfView:(UIView *)view toBounds:(CGRect)bounds withDuration:(NSTimeInterval)duration
{
	CGPathRef oldPath = view.layer.shadowPath;
	CGPathRef newPath = CGPathCreateWithRect(bounds, NULL);
	
	if (oldPath && duration > 0) {
		CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
		theAnimation.duration = duration;
		theAnimation.fromValue = (__bridge id)oldPath;
		theAnimation.toValue = (__bridge id)newPath;
		theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		[view.layer addAnimation:theAnimation forKey:@"shadowPath"];
	}
    
	view.layer.shadowPath = newPath;
    
	CGPathRelease(newPath);    
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIColor *)lighterColorForColor:(UIColor *)color delta:(CGFloat)delta
{
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + delta, 1.0)
                               green:MIN(g + delta, 1.0)
                                blue:MIN(b + delta, 1.0)
                               alpha:a];
    return nil;
}

+ (UIColor *)darkerColorForColor:(UIColor *)color delta:(CGFloat)delta
{
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - delta, 0.0)
                               green:MAX(g - delta, 0.0)
                                blue:MAX(b - delta, 0.0)
                               alpha:a];
    
    return nil;
}

+(UIColor *)inverseColor:(UIColor *)color
{
    const CGFloat *componentColors = CGColorGetComponents(color.CGColor);
    
    return [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                               green:(1.0 - componentColors[1])
                                                blue:(1.0 - componentColors[2])
                                               alpha:componentColors[3]];
}

+ (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (NSString *)hexToString:(NSString *)string {
    NSMutableString * newString = [[NSMutableString alloc] init];
    NSScanner *scanner = [[NSScanner alloc] initWithString:string];
    unsigned value;
    while([scanner scanHexInt:&value]) {
        [newString appendFormat:@"%c",(char)(value & 0xFF)];
    }
    string = [newString copy];
    return string;
}

@end
