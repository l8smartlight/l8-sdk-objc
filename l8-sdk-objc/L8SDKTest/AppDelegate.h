//
//  AppDelegate.h
//  L8SDKTest
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "l8_sdk_objc.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) id<L8> l8;

@end
