//
//  RESTFulL8.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "l8_sdk_objc.h"

@interface RESTFulL8 : NSObject <L8>

- (void)createSimulatorWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)reconnectSimulator:(NSString *)simulatorId withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

@end
