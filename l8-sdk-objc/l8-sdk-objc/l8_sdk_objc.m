//
//  l8_sdk_objc.m
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import "l8_sdk_objc.h"
#import "RESTFulL8.h"

@implementation l8_sdk_objc

NSInteger const kL8ErrorCodeColorNotInRGBSpace = 1020;

- (void)discoverL8sWithSuccess:(L8DiscoverOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self createEmulatedL8WithSuccess:^(NSArray *result) {
        if (success != nil) {
            success(result);
        }
    } failure:^(NSMutableDictionary *result) {
        if (failure != nil) {
            failure(result);
        }
    }];
}

- (void)createEmulatedL8WithSuccess:(L8DiscoverOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    RESTFulL8 *l8 = [[RESTFulL8 alloc] init];
    [l8 createSimulatorWithSuccess:^{
        if (success != nil) {
            success([NSArray arrayWithObject:l8]);
        }
    } failure:^(NSMutableDictionary *result) {
        if (failure != nil) {
            failure(result);
        }
    }];
}

- (void)reconnectEmulatedL8:(NSString *)emulatedL8Id withSuccess:(L8DiscoverOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    RESTFulL8 *l8 = [[RESTFulL8 alloc] init];
    [l8 reconnectSimulator:emulatedL8Id withSuccess:^{
        if (success != nil) {
            success([NSArray arrayWithObject:l8]);
        }
    } failure:^(NSMutableDictionary *result) {
        if (failure != nil) {
            failure(result);
        }
    }];
}

/*
public L8 reconnectDevice(String deviceId) throws L8Exception
{
    RESTfulL8 l8 = new RESTfulL8();
    return l8.reconnectSimulator(deviceId);
}
*/
@end
