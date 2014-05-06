//
//  HexEncoding.cpp
//  SpeakHere
//
//  Created by ims indra on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "HexEncoding.h"

#include "stdlib.h"
#include "string.h"

static bool             IsHexDigit(char c);
static unsigned char    HexToByte(NSString* hexStr);
static unsigned char    strToChar (char a, char b);

/**
 * @abstract Gets number of bytes length of hexadecimal coded hexString
 *
 * @param hexString Hexadecimal coded string
 *
 * @return number of bytes
 *
 * @remarks if an odd number of hex characters is detected, the last character
 * is discarded
 */
int HexEncoding_GetByteCount(NSString *hexString)
{
    int numHexChars = 0;
    char c;
    // remove all none A-F, 0-9, characters
    for (int i = 0; i < [hexString length]; i++)
    {
        c = [hexString characterAtIndex:i]; //hexString[i];
        if (IsHexDigit(c))
            numHexChars++;
    }
    // if odd number of characters, discard last character
    if (numHexChars % 2 != 0)
    {
        numHexChars--;
    }
    return numHexChars / 2; // 2 characters per byte
 }


/** 
 * @abstract Creates a byte array from the hexadecimal string. Each two characters are combined
 *      to create one byte. First two hexadecimal characters become first byte in returned array.
 *      Non-hexadecimal characters are ignored. 
 * 
 * @param hexString
 *      string to convert to byte array
 * @param discarded
 *      number of characters in string ignored
 * @return byte array, in the same left-to-right order as the hexString
 */
NSData* HexEncoding_StringToBytes(NSString *hexString, int* discarded)
{
    (*discarded) = 0;
    NSString *newString = @"";
    char c;
    // remove all none A-F, 0-9, characters
    for (int i = 0; i < [hexString length]; i++)
    {
        c = [hexString characterAtIndex:i];
        if (IsHexDigit(c))
            newString = [newString stringByAppendingString: [NSString stringWithFormat:@"%c",c]]; //+= c;
        else
            (*discarded)++;
    }
    // if odd number of characters, discard last character
    if ([newString length] % 2 != 0)
    {
        (*discarded)++;
        newString = [newString substringToIndex:[newString length] - 1];
    }
    
    int byteLength = [newString length] / 2;
    unsigned char bytes[byteLength];
    NSString *hex;
    for (int i = 0, j = 0; i < byteLength; i++, j += 2)
    {
        hex = [NSString stringWithFormat:@"%c",[newString characterAtIndex:j]];
        hex = [hex stringByAppendingString:[NSString stringWithFormat:@"%c",[newString characterAtIndex:j+1]]];
        bytes[i] = HexToByte(hex);
    }
    NSData* Data = [[NSData alloc] initWithBytes:bytes length:byteLength];
    return Data;
}


NSString* HexEncoding_BytesToString(NSData *bytes)
{
    NSString *RetStr = [[bytes description] uppercaseString];
    RetStr = [RetStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //Remove first (<) and last(>) characters 
    NSRange R = NSMakeRange(1,[RetStr length] - 2);
    
    return [RetStr substringWithRange:R];
}


/*
 * @abstract Determines if given string is in proper hexadecimal string format
 *
 * @param hexString
 *
 * @return true if correct hexadecimal format
 */
bool HexEncoding_InHexFormat(NSString *hexString)
{
    bool hexFormat = true;
    
    for (int i = 0; i < [hexString length]; i++)
    {
        if (!IsHexDigit([hexString characterAtIndex:i]))
        {
            hexFormat = false;
            break;
        }
    }
    return hexFormat;
}


/** 
 * @abstract Returns true is c is a hexadecimal digit (A-F, a-f, 0-9)
 * 
 * @param  Character to test
 *
 * @return true if hex digit, false if not
 */
bool IsHexDigit(char c)
{
    if ((c >= 'A') && (c <= 'F'))
        return true;
    if ((c >= 'a') && (c <= 'f'))
        return true;
    if ((c >= '0') && (c <= '9'))
        return true;
    return false;
}


/**
 * @abstract Converts 1 or 2 character string into equivalant byte value
 *
 * @param hex
 *      1 or 2 character string
 *
 * @return byte
 */
unsigned char HexToByte(NSString* hexStr)
{
    if (([hexStr length] > 2) || ([hexStr length] <= 0))
    {
        NSException *exception = [NSException exceptionWithName: @"HexEncodingEx"
                                                         reason: @"Bad hex byte"
                                                       userInfo: nil];
        @throw exception;
    }
    unsigned char newByte = 0;
    if ([hexStr length] == 1)
        newByte = strToChar([hexStr characterAtIndex:0],'0');
    else
        newByte = strToChar([hexStr characterAtIndex:0],[hexStr characterAtIndex:1]);
    return newByte;
}

unsigned char strToChar (char a, char b)
{
    char encoder[3] = {'\0','\0','\0'};
    encoder[0] = a;
    encoder[1] = b;
    return (char) strtol(encoder,NULL,16);
}

