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
#import "L8Sensor.h"

#define DEVELOPMENT
//#define PREPRODUCTION
//#define PRODUCTION

#ifdef DEVELOPMENT
#define SIMUL8TOR_BASE_URL @"http://192.168.1.33:8888"
#define SIMUL8TOR_BASE_PATH @"/l8-server-simulator"
#endif
#ifdef PREPRODUCTION
#define SIMUL8TOR_BASE_URL @"http://54.228.218.122"
#define SIMUL8TOR_BASE_PATH @"/l8-server-simulator"
#endif

@interface RESTFulL8()

@property (strong, nonatomic) AFHTTPClient *client;
@property (strong, nonatomic) NSString *simul8torToken;

@end

@implementation RESTFulL8

- (id)init
{
    self = [super init];
    if (self) {
        self.client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:SIMUL8TOR_BASE_URL]];
        [self.client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.client setDefaultHeader:@"Accept" value:@"application/json"];
        [self.client setParameterEncoding:AFJSONParameterEncoding];
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

- (void)readSensorStatus:(L8Sensor *)sensor withSuccess:(L8SensorStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/sensor/%@", [self l8Id], sensor.name]]
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     L8SensorStatus *result = nil;
                     if ([sensor.name isEqualToString:[L8Sensor temperatureSensor].name]) {
                         L8TemperatureStatus *status = [[L8TemperatureStatus alloc] init];
                         status.enabled = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_enabled", sensor.name]] boolValue];
                         status.celsiusValue = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data_celsius", sensor.name]] floatValue];
                         status.fahrenheitValue = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data_fahrenheit", sensor.name]] floatValue];
                         result = status;
                     }
                     if ([sensor.name isEqualToString:[L8Sensor accelerationSensor].name]) {
                         L8AccelerationStatus *status = [[L8AccelerationStatus alloc] init];
                         status.enabled = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_enabled", sensor.name]] boolValue];
                         status.rawX = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data_rawX", sensor.name]] floatValue];
                         status.rawY = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data_rawY", sensor.name]] floatValue];
                         status.rawZ = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data_rawZ", sensor.name]] floatValue];
                         status.shake = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data_shake", sensor.name]] integerValue];
                         status.orientation = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data_orientation", sensor.name]] integerValue];
                         result = status;
                     }
                     if ([sensor.name isEqualToString:[L8Sensor ambientLightSensor].name]) {
                         L8AmbientLightStatus *status = [[L8AmbientLightStatus alloc] init];
                         status.enabled = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_enabled", sensor.name]] boolValue];
                         status.value = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data", sensor.name]] integerValue];
                         result = status;
                     }
                     if ([sensor.name isEqualToString:[L8Sensor proximitySensor].name]) {
                         L8ProximityStatus *status = [[L8ProximityStatus alloc] init];
                         status.enabled = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_enabled", sensor.name]] boolValue];                         
                         status.value = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data", sensor.name]] integerValue];
                         result = status;
                     }
                     if ([sensor.name isEqualToString:[L8Sensor noiseSensor].name]) {
                         L8NoiseStatus *status = [[L8NoiseStatus alloc] init];
                         status.enabled = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_enabled", sensor.name]] boolValue];                         
                         status.value = [[json objectForKey:[NSString stringWithFormat:@"%@_sensor_data", sensor.name]] integerValue];
                         result = status;                         
                     }
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

- (void)readSensorsStatusWithSuccess:(L8SensorsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/sensor", [self l8Id]]]
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     
                     NSMutableArray *result = [NSMutableArray arrayWithCapacity:5];
                     
                     L8TemperatureStatus *temperatureStatus = [[L8TemperatureStatus alloc] init];
                     temperatureStatus.enabled = [[json objectForKey:@"temperature_sensor_enabled"] integerValue] == 1;
                     temperatureStatus.celsiusValue = [[json objectForKey:@"temperature_sensor_data_celsius"] floatValue];
                     temperatureStatus.fahrenheitValue = [[json objectForKey:@"temperature_sensor_data_fahrenheit"] floatValue];
                     [result addObject:temperatureStatus];
                     
                     L8AccelerationStatus *accelerationStatus = [[L8AccelerationStatus alloc] init];
                     accelerationStatus.enabled = [[json objectForKey:@"acceleration_sensor_enabled"] boolValue];
                     accelerationStatus.rawX = [[json objectForKey:@"acceleration_sensor_data_rawX"] floatValue];
                     accelerationStatus.rawY = [[json objectForKey:@"acceleration_sensor_data_rawY"] floatValue];
                     accelerationStatus.rawZ = [[json objectForKey:@"acceleration_sensor_data_rawZ"] floatValue];
                     accelerationStatus.shake = [[json objectForKey:@"acceleration_sensor_data_shake"] integerValue];
                     accelerationStatus.orientation = [[json objectForKey:@"acceleration_sensor_data_orientation"] integerValue];
                     [result addObject:accelerationStatus];
                     
                     L8AmbientLightStatus *ambientlightStatus = [[L8AmbientLightStatus alloc] init];
                     ambientlightStatus.enabled = [[json objectForKey:@"ambientlight_sensor_enabled"] boolValue];
                     ambientlightStatus.value = [[json objectForKey:@"ambientlight_sensor_data"] integerValue];
                     [result addObject:ambientlightStatus];

                     L8ProximityStatus *proximityStatus = [[L8ProximityStatus alloc] init];
                     proximityStatus.enabled = [[json objectForKey:@"proximity_sensor_enabled"] boolValue];
                     proximityStatus.value = [[json objectForKey:@"proximity_sensor_data"] integerValue];
                     [result addObject:proximityStatus];
                     
                     L8NoiseStatus *noiseStatus = [[L8NoiseStatus alloc] init];
                     noiseStatus.enabled = [[json objectForKey:@"noise_sensor_enabled"] boolValue];
                     noiseStatus.value = [[json objectForKey:@"noise_sensor_data"] integerValue];
                     [result addObject:noiseStatus];
                     
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

- (void)setMatrix:(NSArray *)colorMatrix withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:64];
    for (int i = 0; i < colorMatrix.count; i++) {
        NSArray *columns = [colorMatrix objectAtIndex:i];
        for (int j = 0; j < columns.count; j++) {
            NSString *ledKey = [NSString stringWithFormat:@"led%d%d", i, j];
            UIColor *color = [columns objectAtIndex:j];
            NSString *colorValue = [self printColor:color];
            [params setObject:colorValue forKey:ledKey];
        }
    }
    for (int i = 0; i < 8; i++) {
        [params setObject:@"" forKey:[NSString stringWithFormat:@"frame%d", i]];
        [params setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"frame%d_duration", i]];
    }    
    [self putPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@", [self l8Id]]]
           params:params
          success:success
          failure:failure
     ];
}

- (void)clearMatrixWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSMutableArray *colorMatrix = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 8; i++) {
        [colorMatrix addObject:[NSMutableArray arrayWithCapacity:8]];
        for (int j = 0; j < 8; j++) {
            [[colorMatrix objectAtIndex:i] addObject:[UIColor blackColor]];
        }
    }
    [self setMatrix:colorMatrix withSuccess:success failure:failure];
}

- (void)readMatrixWithSuccess:(L8ColorMatrixOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/led", [self l8Id]]]
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     NSMutableArray *colorMatrix = [NSMutableArray arrayWithCapacity:8];
                     for (int i = 0; i < 8; i++) {
                         [colorMatrix addObject:[NSMutableArray arrayWithCapacity:8]];
                         for (int j = 0; j < 8; j++) {
                             
                             NSString *ledKey = [NSString stringWithFormat:@"led%d%d", i, j];
                             NSString *ledValue = [json objectForKey:ledKey];
                             UIColor *ledColor = [UIColor colorWithString:ledValue];
                             
                             [[colorMatrix objectAtIndex:i] addObject:ledColor];
                         }
                     }
                     if (success != nil) {
                         success(colorMatrix);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     if (failure != nil) {
                         failure([self createError:error]);
                     }
                 }
     ];
    
}

- (NSString *)printColorMatrix:(NSArray *)colorMatrix
{
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:64];
    for (int i = 0; i < colorMatrix.count; i++) {
        NSArray *row = [colorMatrix objectAtIndex:i];
        for (int j = 0; j < row.count; j++) {
            UIColor *color = [row objectAtIndex:j];
            [colors addObject:[self printColor:color]];
        }
    }
    return [colors componentsJoinedByString:@"-"];
}

- (void)setAnimation:(L8Animation *)animation withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:64];
    for (int i = 0; i < 8; i++) {
        if (i < animation.frames.count) {
            L8Frame *frame = [animation.frames objectAtIndex:i];
            [params setObject:[self printColorMatrix:frame.colorMatrix] forKey:[NSString stringWithFormat:@"frame%d", i]];
            [params setObject:[NSNumber numberWithInt:frame.duration] forKey:[NSString stringWithFormat:@"frame%d_duration", i]];
        } else {
            [params setObject:@"" forKey:[NSString stringWithFormat:@"frame%d", i]];
            [params setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"frame%d_duration", i]];
        }
    }
    [self putPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@", [self l8Id]]]
           params:params
          success:success
          failure:failure
     ];
}

- (void)reconnectSimulator:(NSString *)simulatorId withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    self.simul8torToken = simulatorId;
    [self.client getPath:[self buildPath:[NSString stringWithFormat:@"/l8s/%@/ping", [self l8Id]]]
              parameters:nil
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

@end
