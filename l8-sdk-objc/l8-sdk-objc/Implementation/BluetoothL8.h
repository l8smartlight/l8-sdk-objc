//
//  BluetoothL8.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "l8_sdk_objc.h"
#import "TIBLECBKeyfob.h"
@interface BluetoothL8 : NSObject <L8>
@property (nonatomic,strong) TIBLECBKeyfob *t;
@end
