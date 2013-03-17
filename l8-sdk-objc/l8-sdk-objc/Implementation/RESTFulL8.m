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

- (NSString *)getPath:(NSString *)path
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

- (void)createSimulatorWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client postPath:[self getPath:@"/l8s"]
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
    [self.client putPath:[self getPath:[NSString stringWithFormat:@"/l8s/%@", [self l8Id]]]
              parameters:[NSMutableDictionary dictionaryWithObject:colorValue forKey:ledKey]
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

- (void)clearLED:(CGPoint)point withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self setLED:point color:[UIColor blackColor] withSuccess:success failure:failure];
}

- (void)readLED:(CGPoint)point withSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *ledKey = [NSString stringWithFormat:@"led%.f%.f", point.x, point.y];
    [self.client getPath:[self getPath:[NSString stringWithFormat:@"/l8s/%@/led/%@", [self l8Id], ledKey]]
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     NSString *color = [json objectForKey:ledKey];
                     UIColor *result = [UIColor colorWithString:color];
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

- (void)setSuperLED:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *colorValue = [self printColor:color];
    [self.client putPath:[self getPath:[NSString stringWithFormat:@"/l8s/%@/superled", [self l8Id]]]
              parameters:[NSMutableDictionary dictionaryWithObject:colorValue forKey:@"superled"]
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

- (void)clearSuperLEDWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self setSuperLED:[UIColor blackColor] withSuccess:success failure:failure];
}

- (void)readSuperLEDWithSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self.client getPath:[self getPath:[NSString stringWithFormat:@"/l8s/%@/superled", [self l8Id]]]
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSMutableDictionary *json = (NSMutableDictionary *)responseObject;
                     NSString *color = [json objectForKey:@"superled"];
                     UIColor *result = [UIColor colorWithString:color];
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

@end
