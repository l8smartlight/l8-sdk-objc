//
//  RESTFulL8.m
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import "RESTFulL8.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "ColorUtils.h"

#define SIMUL8TOR_BASE_URL @"http://192.168.1.165:8888"
#define SIMUL8TOR_BASE_PATH @"/l8-server-simulator"

@interface RESTFulL8()

@property (strong, nonatomic) AFHTTPClient *client;
@property (strong, nonatomic) NSString *simul8torToken;

@end

@implementation RESTFulL8

- (id)initWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    self = [super init];
    if (self) {
        self.client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:SIMUL8TOR_BASE_URL]];
        [self.client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.client setDefaultHeader:@"Accept" value:@"application/json"];
        [self.client setParameterEncoding:AFJSONParameterEncoding];
        [self createSimulatorWithSuccess:success failure:failure];
    }
    return self;
}

- (NSString *)buildPath:(NSString *)path
{
    return [NSString stringWithFormat:@"%@%@", SIMUL8TOR_BASE_PATH, path];
}

- (NSMutableDictionary *)createError:(NSError *)error
{
    return [self createErrorWithCode:[NSNumber numberWithInt:error.code] description:error.description];
}

- (NSMutableDictionary *)createErrorWithCode:(NSNumber *)code description:(NSString *)description
{
    NSMutableDictionary *json = [NSMutableDictionary dictionaryWithCapacity:1];
    NSMutableDictionary *jsonError = [NSMutableDictionary dictionaryWithCapacity:2];
    [jsonError setObject:code forKey:@"code"];
    [jsonError setObject:description forKey:@"description"];
    [json setObject:jsonError forKey:@"error"];
    return json;
}

- (void)putPath:(NSString *)path params:(NSMutableDictionary *)params success:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client putPath:path
              parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     if (success != nil) {
                         success();
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     if (failure != nil) {
                         failure([self createError:error]);
                     }
                 }
     ];
}

- (void)getIntegerWithPath:(NSString *)path key:(NSString *)key success:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:path
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     NSString *value = [json objectForKey:key];
                     NSInteger result = [value integerValue];
                     if (success != nil) {
                         success(result);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     if (failure != nil) {
                         failure([self createError:error]);
                     }
                 }
     ];
}

- (void)getColorWithPath:(NSString *)path key:(NSString *)key success:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:path
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     NSString *value = [json objectForKey:key];
                     UIColor *result = [UIColor colorWithString:value];
                     if (success != nil) {
                         success(result);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     if (failure != nil) {
                         failure([self createError:error]);
                     }
                 }
     ];
}

- (void)getBooleanWithPath:(NSString *)path key:(NSString *)key success:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:path
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     NSString *value = [json objectForKey:key];
                     BOOL result = [value boolValue];
                     if (success != nil) {
                         success(result);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     if (failure != nil) {
                         failure([self createError:error]);
                     }
                 }
     ];
}

- (void)createSimulatorWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client postPath:[self buildPath:@"/l8s"]
               parameters:nil
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                      self.simul8torToken = [json objectForKey:@"id"];
                      if (success != nil) {
                          success();
                      }
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error){
                      if (failure != nil) {
                          failure([self createError:error]);
                      }
                  }
    ];
}

- (L8ConnectionType)getConnectionType
{
    return L8ConnectionTypeRESTFul;
}

- (NSString *)l8Id
{
    return self.simul8torToken;
}

- (NSString *)connectionURL
{
    return [NSString stringWithFormat:@"%@%@/l8s/%@", SIMUL8TOR_BASE_URL, SIMUL8TOR_BASE_PATH, [self l8Id]];
}

- (NSString *)printColor:(UIColor *)color
{
    return [NSString stringWithFormat:@"#%.6x", color.RGBValue];
}

- (void)setLED:(CGPoint)point color:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *ledKey = [NSString stringWithFormat:@"led%.f%.f", point.x, point.y];
    NSString *colorValue = [self printColor:color];
    [self putPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@", [self l8Id]]]
           params:[NSMutableDictionary dictionaryWithObject:colorValue forKey:ledKey]
          success:success
          failure:failure
     ];
}

- (void)clearLED:(CGPoint)point withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self setLED:point color:[UIColor blackColor] withSuccess:success failure:failure];
}

- (void)readLED:(CGPoint)point withSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *ledKey = [NSString stringWithFormat:@"led%.f%.f", point.x, point.y];
    [self getColorWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/led/%@", [self l8Id], ledKey]]
                       key:ledKey
                   success:success
                   failure:failure];
}

- (void)setSuperLED:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *colorValue = [self printColor:color];
    [self putPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/superled", [self l8Id]]]
           params:[NSMutableDictionary dictionaryWithObject:colorValue forKey:@"superled"]
          success:success
          failure:failure
     ];
}

- (void)clearSuperLEDWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self setSuperLED:[UIColor blackColor] withSuccess:success failure:failure];
}

- (void)readSuperLEDWithSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self getColorWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/superled", [self l8Id]]]
                       key:@"superled"
                   success:success
                   failure:failure];
}

- (void)readBatteryStatusWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self getIntegerWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/battery_status", [self l8Id]]]
                         key:@"battery_status"
                     success:success
                     failure:failure
     ];
}

- (void)readButtonWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self getIntegerWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/button", [self l8Id]]]
                         key:@"button"
                     success:success
                     failure:failure
     ];
}

- (void)readMemorySizeWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self getIntegerWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/memory_size", [self l8Id]]]
                         key:@"memory_size"
                     success:success
                     failure:failure
     ];
}

- (void)readFreeMemoryWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self getIntegerWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/free_memory", [self l8Id]]]
                         key:@"free_memory"
                     success:success
                     failure:failure
     ];
}

- (void)readBluetoothEnabledWithSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self getBooleanWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/bluetooth_enabled", [self l8Id]]]
                         key:@"bluetooth_enabled"
                     success:success
                     failure:failure
     ];    
}

- (void)readVersionWithSuccess:(L8VersionOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/version", [self l8Id]]]
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     NSString *hardwareValue = [json objectForKey:@"hardware_version"];
                     NSString *softwareValue = [json objectForKey:@"software_version"];
                     L8Version *version = [[L8Version alloc] init];
                     version.hardware = [hardwareValue integerValue];
                     version.software = [softwareValue integerValue];
                     if (success != nil) {
                         success(version);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     if (failure != nil) {
                         failure([self createError:error]);
                     }
                 }
     ];    
}

- (void)readSensorEnabled:(L8Sensor *)sensor withSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self getBooleanWithPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/sensor/%@/enabled", [self l8Id], sensor.name]]
                         key:[NSString stringWithFormat:@"%@_enabled", sensor.name]
                     success:success
                     failure:failure
     ];
}

- (void)enableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *sensorKey = [NSString stringWithFormat:@"%@_sensor_enabled", sensor.name];
    [self putPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@", [self l8Id]]]
           params:[NSMutableDictionary dictionaryWithObject:@"1" forKey:sensorKey]
          success:success
          failure:failure
     ];
}

- (void)disableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *sensorKey = [NSString stringWithFormat:@"%@_sensor_enabled", sensor.name];
    [self putPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@", [self l8Id]]]
           params:[NSMutableDictionary dictionaryWithObject:@"0" forKey:sensorKey]
          success:success
          failure:failure
     ];
}

@end
