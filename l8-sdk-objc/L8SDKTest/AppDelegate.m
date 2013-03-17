//
//  AppDelegate.m
//  L8SDKTest
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import "AppDelegate.h"

#import "l8_sdk_objc.h"
#import "ColorUtils.h"
#import "RESTFulL8.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    L8VoidOperationHandler success = ^() {
        NSLog(@"Created L8 with id: %@ accesible at %@", [self.l8 l8Id], [self.l8 connectionURL]);
        
        L8VoidOperationHandler v = ^() {
            NSLog(@"success");
        };
        L8ColorOperationHandler c = ^(UIColor *result) {
            NSLog(@"success: %@", [result stringValue]);
        };
        L8JSONOperationHandler f = ^(NSMutableDictionary *r) {
            NSLog(@"failure: %@", r);
        };
        
        
        [self.l8 setSuperLED:[UIColor yellowColor] withSuccess:v failure:f];        
        
        [self.l8 setLED:CGPointMake(0, 0) color:[UIColor cyanColor] withSuccess:v failure:f];
        [self.l8 setLED:CGPointMake(2, 3) color:[UIColor cyanColor] withSuccess:v failure:f];
        [self.l8 setLED:CGPointMake(5, 7) color:[UIColor redColor] withSuccess:v failure:f];
        [self.l8 setLED:CGPointMake(7, 7) color:[UIColor cyanColor] withSuccess:v failure:f];
        
        [self.l8 clearLED:CGPointMake(7, 7) withSuccess:v failure:f];
        [self.l8 clearLED:CGPointMake(0, 0) withSuccess:v failure:f];
        
        [self.l8 readLED:CGPointMake(2, 3) withSuccess:c failure:f];
        [self.l8 readLED:CGPointMake(5, 7) withSuccess:c failure:f];
        
        [self.l8 readSuperLEDWithSuccess:c failure:f];
    };
    L8JSONOperationHandler failure = ^(NSMutableDictionary *response) {
        NSLog(@"Some error happened during l8 initialization: %@", response);
    };
    self.l8 = [[RESTFulL8 alloc] initWithSuccess:success failure:failure];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
