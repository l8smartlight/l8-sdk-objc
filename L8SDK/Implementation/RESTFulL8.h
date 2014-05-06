//
//  RESTFulL8.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "l8_sdk_objc.h"
#import "Constants.h"

//#define DEVELOPMENT_SIM
//#define PREPRODUCTION_SIM
//#define PRODUCTION_SIM

//#ifdef DEVELOPMENT_SIM
//#define SIMUL8TOR_BASE_URL @"http://ec2-54-217-163-247.eu-west-1.compute.amazonaws.com"
//#define SIMUL8TOR_BASE_PATH @"/l8-server-simulator"
//#define SIMUL8TOR_STRING_PATH @"l8-server-simulator/l8s/"
//#endif
//#ifdef PREPRODUCTION_SIM
//#define SIMUL8TOR_BASE_URL @"http://l8.develappers.es"//@"http://l8pre.develappers.es"
//#define SIMUL8TOR_BASE_PATH @"/l8-server-simulator"
//#define SIMUL8TOR_STRING_PATH @"l8-server-simulator/l8s/"
//#endif

#ifdef DEVELOPMENT_SIM
#define SIMUL8TOR_BASE_URL @"http://l8.develappers.es"//@""
#define SIMUL8TOR_BASE_PATH @"/l8-server-simulator"
#define SIMUL8TOR_STRING_PATH @"l8-server-simulator/l8s/"
#endif
#ifdef PREPRODUCTION_SIM
#define SIMUL8TOR_BASE_URL @"http://l8pre.develappers.es"
#define SIMUL8TOR_BASE_PATH @"/l8-server-simulator"
#define SIMUL8TOR_STRING_PATH @"l8-server-simulator/l8s/"
#endif

@interface RESTFulL8 : NSObject <L8>

@property (strong, nonatomic) NSString *simul8torToken;

- (void)createSimulatorWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

- (void)reconnectSimulator:(NSString *)simulatorId withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;

@end
