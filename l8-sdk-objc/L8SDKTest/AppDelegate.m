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
        L8IntegerOperationHandler i = ^(NSInteger result) {
            NSLog(@"success: %d", result);
        };
        L8BooleanOperationHandler b = ^(BOOL result) {
            NSLog(@"success: %@", result? @"Y": @"N");
        };
        L8VersionOperationHandler r = ^(L8Version *result) {
            NSLog(@"success: %d %d", result.hardware, result.software);
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
        
        [self.l8 readBatteryStatusWithSuccess:i failure:f];
        [self.l8 readButtonWithSuccess:i failure:f];
        [self.l8 readMemorySizeWithSuccess:i failure:f];
        [self.l8 readFreeMemoryWithSuccess:i failure:f];
    
        [self.l8 readBluetoothEnabledWithSuccess:b failure:f];
        
        [self.l8 readVersionWithSuccess:r failure:f];
        
        [self.l8 readSensorEnabled:[L8Sensor proximitySensor] withSuccess:b failure:f];
        [self.l8 readSensorEnabled:[L8Sensor temperatureSensor] withSuccess:b failure:f];
        
        [self.l8 disableSensor:[L8Sensor proximitySensor] withSuccess:v failure:f];
        [self.l8 enableSensor:[L8Sensor proximitySensor] withSuccess:v failure:f];
        
    };
    L8JSONOperationHandler failure = ^(NSMutableDictionary *response) {
        NSLog(@"Some error happened during l8 initialization: %@", response);
    };
    self.l8 = [[RESTFulL8 alloc] initWithSuccess:success failure:failure];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
