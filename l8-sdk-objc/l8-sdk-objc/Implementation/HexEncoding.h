//
//  HexEncoding.h
//  SpeakHere
//
//  Created by ims indra on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef __HEXENCODING_H__
#define __HEXENCODING_H__

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif
    
NSData*     HexEncoding_StringToBytes(NSString *hexString, int* discarded);
NSString*   HexEncoding_BytesToString(NSData *bytes);
int         HexEncoding_GetByteCount(NSString *hexString);
bool        HexEncoding_InHexFormat(NSString *hexString);
    
#if defined __cplusplus
}
#endif
#endif
