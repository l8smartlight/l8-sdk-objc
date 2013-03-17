//
//  l8_sdk_objc.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^L8VoidOperationHandler)();
typedef void(^L8ColorOperationHandler)(UIColor *result);
typedef void(^L8BooleanOperationHandler)(BOOL result);
typedef void(^L8IntegerOperationHandler)(int result);
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

/*
public void setMatrix(Color[][] colorMatrix) throws L8Exception;

public void clearMatrix() throws L8Exception;

public Color[][] readMatrix() throws L8Exception;
*/

- (void)setLED:(CGPoint)point color:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)clearLED:(CGPoint)point withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readLED:(CGPoint)point withSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)setSuperLED:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)clearSuperLEDWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)readSuperLEDWithSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure;

/*
public void enableSensor(Sensor sensor) throws L8Exception;

public Sensor.Status readSensor(Sensor sensor) throws L8Exception;

public void disableSensor(Sensor sensor) throws L8Exception;

public boolean isSensorEnabled(Sensor sensor) throws L8Exception;

public boolean isBluetoothEnabled() throws L8Exception;

public int getBatteryStatus() throws L8Exception;

public int getButton() throws L8Exception;

public int getMemorySize() throws L8Exception;

public int getFreeMemory() throws L8Exception;
*/

- (NSString *)l8Id;


/*
public L8.Version getVersion() throws L8Exception;

public void setAnimation(Animation animation) throws L8Exception;
*/

- (NSString *)connectionURL;


@end

@interface l8_sdk_objc : NSObject

- (NSArray *)discoverL8sWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (id<L8>)createEmulatedL8WithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

@end
