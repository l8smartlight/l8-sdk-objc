//
//  L8Sensor.m
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/17/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import "L8Sensor.h"

@implementation L8SensorStatus

@end

@implementation L8FloatStatus 

@end

@implementation L8IntegerStatus

@end

@implementation L8TemperatureStatus

@end

@implementation L8AmbientLightStatus

@end

@implementation L8ProximityStatus

@end

@implementation L8NoiseStatus

@end

@implementation L8AccelerationStatus

@end

@implementation L8Sensor

NSString *const kL8ProximitySensorName = @"proximity";
NSString *const kL8TemperatureSensorName = @"temperature";
NSString *const kL8NoiseSensorName = @"noise";
NSString *const kL8AmbientLightSensorName = @"ambientlight";
NSString *const kL8AccelerationSensorName = @"acceleration";

+ (L8Sensor *)proximitySensor
{
    L8Sensor *sensor = [[L8Sensor alloc] init];
    sensor.name = kL8ProximitySensorName;
    return sensor;
}

+ (L8Sensor *)temperatureSensor
{
    L8Sensor *sensor = [[L8Sensor alloc] init];
    sensor.name = kL8TemperatureSensorName;
    return sensor;
}

+ (L8Sensor *)noiseSensor
{
    L8Sensor *sensor = [[L8Sensor alloc] init];
    sensor.name = kL8NoiseSensorName;
    return sensor;
}

+ (L8Sensor *)ambientLightSensor
{
    L8Sensor *sensor = [[L8Sensor alloc] init];
    sensor.name = kL8AmbientLightSensorName;
    return sensor;
}

+ (L8Sensor *)accelerationSensor
{
    L8Sensor *sensor = [[L8Sensor alloc] init];
    sensor.name = kL8AccelerationSensorName;
    return sensor;    
}

@end
