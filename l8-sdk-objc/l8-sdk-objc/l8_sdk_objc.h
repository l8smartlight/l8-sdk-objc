//
//  l8_sdk_objc.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "L8Version.h"
#import "L8Sensor.h"

typedef void(^L8VoidOperationHandler)();
typedef void(^L8ColorOperationHandler)(UIColor *result);
typedef void(^L8ColorMatrixOperationHandler)(NSArray *result);
typedef void(^L8BooleanOperationHandler)(BOOL result);
typedef void(^L8IntegerOperationHandler)(NSInteger result);
typedef void(^L8VersionOperationHandler)(L8Version *result);
typedef void(^L8SensorStatusOperationHandler)(L8SensorStatus *result);
typedef void(^L8JSONOperationHandler)(NSMutableDictionary *result);

typedef enum {
    L8ConnectionTypeBluetooth,
    L8ConnectionTypeUSB,
    L8ConnectionTypeRESTFul
} L8ConnectionType;

extern NSInteger const kL8ErrorCodeColorNotInRGBSpace;

@protocol L8 <NSObject>

- (id)initWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (L8ConnectionType)getConnectionType;

- (void)setMatrix:(NSArray *)colorMatrix withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)clearMatrixWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readMatrixWithSuccess:(L8ColorMatrixOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)setLED:(CGPoint)point color:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)clearLED:(CGPoint)point withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readLED:(CGPoint)point withSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)setSuperLED:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)clearSuperLEDWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readSuperLEDWithSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readSensorStatus:(L8Sensor *)sensor withSuccess:(L8SensorStatusOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)enableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)disableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readSensorEnabled:(L8Sensor *)sensor withSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readBluetoothEnabledWithSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readBatteryStatusWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readButtonWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readMemorySizeWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readFreeMemoryWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (NSString *)l8Id;

- (void)readVersionWithSuccess:(L8VersionOperationHandler)success failure:(L8JSONOperationHandler)failure;

/*
public void setAnimation(Animation animation) throws L8Exception;
*/

- (NSString *)connectionURL;


@end

@interface l8_sdk_objc : NSObject

- (NSArray *)discoverL8sWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (id<L8>)createEmulatedL8WithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

@end
