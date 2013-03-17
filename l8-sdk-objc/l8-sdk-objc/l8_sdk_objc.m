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

- (NSArray *)discoverL8sWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSMutableArray *foundL8s = [NSMutableArray arrayWithCapacity:3];
    
    // 1. Look for L8s connected via USB port
    // 2. Look for L8s connected via bluetooth
    // 3. If no L8s found, emulate a device with the RESTFul API.
    if (foundL8s.count == 0) {
        [foundL8s addObject:[self createEmulatedL8WithSuccess:success failure:failure]];
    }
    return foundL8s;
}

- (id<L8>)createEmulatedL8WithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    return [[RESTFulL8 alloc] initWithSuccess:success failure:failure];
}

@end
