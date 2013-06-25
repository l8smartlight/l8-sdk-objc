//
//  L8Sensor.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/17/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface L8SensorStatus : NSObject

@property (nonatomic) bool enabled;

@end

@interface L8FloatStatus : L8SensorStatus

@property (nonatomic) CGFloat value;

@end

@interface L8IntegerStatus : L8SensorStatus

@property (nonatomic) NSInteger value;

@end

@interface L8TemperatureStatus : L8SensorStatus

@property (nonatomic) CGFloat celsiusValue;
@property (nonatomic) CGFloat fahrenheitValue;

@end

@interface L8AmbientLightStatus : L8IntegerStatus

@end

@interface L8ProximityStatus : L8IntegerStatus

@end

@interface L8NoiseStatus : L8IntegerStatus

@end

@interface L8AccelerationStatus : L8SensorStatus

@property (nonatomic) CGFloat rawX;
@property (nonatomic) CGFloat rawY;
@property (nonatomic) CGFloat rawZ;
@property (nonatomic) NSInteger shake;
@property (nonatomic) NSInteger orientation;

@end

@interface L8Sensor : NSObject

extern NSString *const kL8ProximitySensorName;
extern NSString *const kL8TemperatureSensorName;
extern NSString *const kL8NoiseSensorName;
extern NSString *const kL8AmbientLightSensorName;
extern NSString *const kL8AccelerationSensorName;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) L8SensorStatus *status;

+ (L8Sensor *)proximitySensor;

+ (L8Sensor *)temperatureSensor;

+ (L8Sensor *)noiseSensor;

+ (L8Sensor *)ambientLightSensor;

+ (L8Sensor *)accelerationSensor;

@end
