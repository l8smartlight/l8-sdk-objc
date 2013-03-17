//
//  L8Sensor.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/17/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L8Sensor : NSObject

extern NSString *const kL8ProximitySensorName;
extern NSString *const kL8TemperatureSensorName;
extern NSString *const kL8NoiseSensorName;
extern NSString *const kL8AmbientLightSensorName;
extern NSString *const kL8AccelerationSensorName;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableDictionary *status;

+ (L8Sensor *)proximitySensor;

+ (L8Sensor *)temperatureSensor;

+ (L8Sensor *)noiseSensor;

+ (L8Sensor *)ambientLightSensor;

+ (L8Sensor *)accelerationSensor;

@end
