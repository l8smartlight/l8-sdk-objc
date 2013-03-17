//
//  BluetoothL8.m
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import "BluetoothL8.h"

@implementation BluetoothL8

- (L8ConnectionType)getConnectionType
{
    return L8ConnectionTypeBluetooth;
}

- (id)initWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
    return nil;
}

- (void)setMatrix:(NSArray *)colorMatrix withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)clearMatrixWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readMatrixWithSuccess:(L8ColorMatrixOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)setLED:(CGPoint)point color:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)clearLED:(CGPoint)point withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readLED:(CGPoint)point withSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)setSuperLED:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)clearSuperLEDWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readSuperLEDWithSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readSensorStatus:(L8Sensor *)sensor withSuccess:(L8SensorStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)enableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)disableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readSensorEnabled:(L8Sensor *)sensor withSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readBluetoothEnabledWithSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readBatteryStatusWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readButtonWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readMemorySizeWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readFreeMemoryWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (NSString *)l8Id
{
    NSLog(@"Not implemented!");
    return nil;
}

- (void)readVersionWithSuccess:(L8VersionOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)setAnimation:(L8Animation *)animation withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (NSString *)connectionURL
{
    NSLog(@"Not implemented!");
    return nil;
}

@end
