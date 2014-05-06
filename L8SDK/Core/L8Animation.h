//
//  L8Animation.h
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/17/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L8Frame : NSObject

@property (strong, nonatomic) NSMutableArray *colorMatrix;
@property (nonatomic) NSInteger duration;

@end

@interface L8Animation : NSObject

@property (strong, nonatomic) NSMutableArray *frames;
@property (nonatomic,strong) NSMutableArray *frameStrings;

@end
