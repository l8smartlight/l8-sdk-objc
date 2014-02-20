//
//  BluetoothL8.m
//  l8-sdk-objc
//
//  Created by Marcos Pinazo on 3/16/13.
//  Copyright (c) 2013 L8 SmartLight. All rights reserved.
//

#define L8SL_COLOR_CLEAR                (NSUInteger)0
#define L8SL_COLOR_RED                  (NSUInteger)1
#define L8SL_COLOR_GREEN                (NSUInteger)2
#define L8SL_COLOR_BLUE                 (NSUInteger)3
#define L8SL_COLOR_RANDOM               (NSUInteger)5000

#define L8SL_LED_MATRIX_L               8
#define L8SL_LED_MATRIX_A               (L8SL_LED_MATRIX_L * L8SL_LED_MATRIX_L)

//Set LED Matrix color CMD
#define L8SL_CMD_SET_LED_MATRIX_COLOR_HDR_LEN                   4
static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_HDR[]        = {0xAA, 0x55, 0x81, 0x44};
//static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_RED_VAL[2]   = {0x00, 0x0f};
//static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_RED_CRC      = 0x81;
//static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_GREEN_VAL[2] = {0x00, 0xf0};
//static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_GREEN_CRC    = 0xd7;
//static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_BLUE_VAL[2]  = {0x0f, 0x00};
//static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_BLUE_CRC     = 0xac;

//Clear LED Matrix color CMD
#define L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR_LEN              4
static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR[]   = {0xAA, 0x55, 0x01, 0x45};
static unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_CRC     = 0xDC;

//Set BACK LED color CMD
#define L8SL_CMD_SET_BACK_LED_COLOR_HDR_LEN                     6
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_HDR[]          = {0xAA, 0x55, 0x06, 0x43, 0x0A, 0x0D};
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_RED_VAL[3]     = {0x00, 0x00, 0x0F};
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_RED_CRC        = 0x03;
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_GREEN_VAL[3]   = {0x00, 0x0F, 0x00};
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_GREEN_CRC      = 0xed;
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_BLUE_VAL[3]    = {0x0F, 0x00, 0x00};
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_BLUE_CRC       = 0x69;
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_NONE_VAL[3]    = {0x00, 0x00, 0x00};
//static unsigned char L8SL_CMD_SET_BACK_LED_COLOR_NONE_CRC       = 0x2e;

//-------------------
#define L8SL_PKT_START_LEN                                                  2
static unsigned char L8SL_PKT_START[L8SL_PKT_START_LEN]                     = {0xAA, 0x55};
#define L8SL_PKT_LENGHT_LEN                                                 1
#define L8SL_CMD_CRC_LEN                                                    1

#define L8SL_L8_STORE_FRAME_LEN                                             1
static unsigned char L8SL_L8_STORE_FRAME[L8SL_L8_STORE_FRAME_LEN]           = {0x70};
#define L8SL_L8_STORE_ANIM_LEN                                              1
//static unsigned char L8SL_L8_STORE_ANIM[L8SL_L8_STORE_ANIM_LEN]             = {0x77};
#define L8SL_CMD_SETLEDMTRX_LEN                                             1
static unsigned char L8SL_CMD_SETLEDMTRX[L8SL_CMD_SETLEDMTRX_LEN]           = {0x44};
#define L8SL_CMD_APP_STOP_LEN                                               1
//static unsigned char L8SL_CMD_APP_STOP[L8SL_CMD_APP_STOP_LEN]               = {0x45};
#define L8SL_CMD_SETBACKLED_LEN                                             1
static unsigned char L8SL_CMD_SETBACKLED[L8SL_CMD_SETBACKLED_LEN]           = {0x4B};
#define L8SL_CMD_APP_START_LEN                                              1
//static unsigned char L8SL_CMD_APP_START[L8SL_CMD_APP_START_LEN]             = {0x81};
#define L8SL_CMD_CLEARLEDMTRX_LEN                                           1
//static unsigned char L8SL_CMD_CLEARLEDMTRX[L8SL_CMD_CLEARLEDMTRX_LEN]       = {0x82};
#define L8SL_CMD_SETTEXT_LEN                                                1
//static unsigned char L8SL_CMD_SETTEXT[L8SL_CMD_SETTEXT_LEN]                 = {0x83};

//-------------------

//L8SL commands
unsigned char crc8(unsigned char *buffer,unsigned int size);
const unsigned char crc8table[]=
{   0x00,0x07,0x0E,0x09,0x1C,0x1B,0x12,0x15,
    0x38,0x3F,0x36,0x31,0x24,0x23,0x2A,0x2D,
    0x70,0x77,0x7E,0x79,0x6C,0x6B,0x62,0x65,
    0x48,0x4F,0x46,0x41,0x54,0x53,0x5A,0x5D,
    0xE0,0xE7,0xEE,0xE9,0xFC,0xFB,0xF2,0xF5,
    0xD8,0xDF,0xD6,0xD1,0xC4,0xC3,0xCA,0xCD,
    0x90,0x97,0x9E,0x99,0x8C,0x8B,0x82,0x85,
    0xA8,0xAF,0xA6,0xA1,0xB4,0xB3,0xBA,0xBD,
    0xC7,0xC0,0xC9,0xCE,0xDB,0xDC,0xD5,0xD2,
    0xFF,0xF8,0xF1,0xF6,0xE3,0xE4,0xED,0xEA,
    0xB7,0xB0,0xB9,0xBE,0xAB,0xAC,0xA5,0xA2,
    0x8F,0x88,0x81,0x86,0x93,0x94,0x9D,0x9A,
    0x27,0x20,0x29,0x2E,0x3B,0x3C,0x35,0x32,
    0x1F,0x18,0x11,0x16,0x03,0x04,0x0D,0x0A,
    0x57,0x50,0x59,0x5E,0x4B,0x4C,0x45,0x42,
    0x6F,0x68,0x61,0x66,0x73,0x74,0x7D,0x7A,
    0x89,0x8E,0x87,0x80,0x95,0x92,0x9B,0x9C,
    0xB1,0xB6,0xBF,0xB8,0xAD,0xAA,0xA3,0xA4,
    0xF9,0xFE,0xF7,0xF0,0xE5,0xE2,0xEB,0xEC,
    0xC1,0xC6,0xCF,0xC8,0xDD,0xDA,0xD3,0xD4,
    0x69,0x6E,0x67,0x60,0x75,0x72,0x7B,0x7C,
    0x51,0x56,0x5F,0x58,0x4D,0x4A,0x43,0x44,
    0x19,0x1E,0x17,0x10,0x05,0x02,0x0B,0x0C,
    0x21,0x26,0x2F,0x28,0x3D,0x3A,0x33,0x34,
    0x4E,0x49,0x40,0x47,0x52,0x55,0x5C,0x5B,
    0x76,0x71,0x78,0x7F,0x6A,0x6D,0x64,0x63,
    0x3E,0x39,0x30,0x37,0x22,0x25,0x2C,0x2B,
    0x06,0x01,0x08,0x0F,0x1A,0x1D,0x14,0x13,
    0xAE,0xA9,0xA0,0xA7,0xB2,0xB5,0xBC,0xBB,
    0x96,0x91,0x98,0x9F,0x8A,0x8D,0x84,0x83,
    0xDE,0xD9,0xD0,0xD7,0xC2,0xC5,0xCC,0xCB,
    0xE6,0xE1,0xE8,0xEF,0xFA,0xFD,0xF4,0xF3
};

unsigned char crc8(unsigned char *buffer,unsigned int size)
{
    unsigned int i;
    unsigned char c=0;
    
    for(i=0;i<size;i++)
        c = crc8table[c ^ buffer[i]];
    
    return c;
}
//------

#import "BluetoothL8.h"
#import "HexEncoding.h"

@implementation BluetoothL8

//In order to stop animations




- (L8ConnectionType)getConnectionType
{
    return L8ConnectionTypeBluetooth;
}

- (id)initWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
    return nil;
}


- (void)stopAnimation{
    

    if (cancelledPtr)
    {
        NSLog(@"stopping");
        
        *cancelledPtr = YES;
    }

}

- (void)setMatrix:(NSArray *)colorMatrix withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self clearMatrixWithSuccess:^{
        NSLog(@"Matrix cleared");
    } failure:^(NSMutableDictionary *result) {
        NSLog(@"Error!! Matrix is not cleared");
    }];
    success();
    
    NSString *matrixString=[[colorMatrix valueForKey:@"description"] componentsJoinedByString:@"-"];
    NSData* MtxData = [self getL8yMatrixCompressed_ByString:matrixString];
    
    int DataBytes_Len = L8SL_PKT_START_LEN +
    L8SL_PKT_LENGHT_LEN +
    L8SL_CMD_SETLEDMTRX_LEN +
    L8SL_LED_MATRIX_A * 2 +
    L8SL_CMD_CRC_LEN;
    
    unsigned char DataBytes[DataBytes_Len];
    int j = 0;
    for (int i = 0; i < L8SL_PKT_START_LEN; i++,j++)
    {//Pkt start
        DataBytes[j]    = L8SL_PKT_START[i];
    }
    for (int i = 0; i < L8SL_CMD_SETLEDMTRX_LEN; i++,j++)
    {//DataLen reset
        DataBytes[j]    = 0;
    }
    for (int i = 0; i < L8SL_PKT_LENGHT_LEN; i++,j++)
    {//Cmd field
        DataBytes[j]    = L8SL_CMD_SETLEDMTRX[i];
    }
    unsigned char MtxDataBytes[5000];
    [MtxData getBytes:MtxDataBytes];
    
    for (int i = 0; i < L8SL_LED_MATRIX_A*2; i+=2,j+=2)
    {//Data
        DataBytes[j]    = MtxDataBytes[i+1];
        DataBytes[j+1]  = MtxDataBytes[i];
        
        DataBytes[2]    += 2; //Packet payload length
    }
    {//CRC
        DataBytes[j]    = crc8(&DataBytes[3],DataBytes_Len-4);
        
        DataBytes[2]    += 1; //Packet payload length
    }
    
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)DataBytes length:DataBytes_Len];
    
    
    NSString* CmdStr = HexEncoding_BytesToString(Cmd);
    printf("%s\n",[[CmdStr substringToIndex:2*(L8SL_PKT_START_LEN + L8SL_PKT_LENGHT_LEN + L8SL_CMD_SETLEDMTRX_LEN) ] UTF8String]);
    CmdStr=[CmdStr substringFromIndex:2*(L8SL_PKT_START_LEN + L8SL_PKT_LENGHT_LEN + L8SL_CMD_SETLEDMTRX_LEN) ];
    for (int i = 0; i < CmdStr.length / (16*2)+1; i++)
    {
        int len = CmdStr.length - (i*16*2);
        if (len > 32)
            len = 32;
        
        NSRange rng = NSMakeRange(i*16*2, len);
        printf("%s\n", [[CmdStr substringWithRange:rng ] UTF8String]);
    }
    
    //---------- BACK LED
    
    NSData* BckData = [self getL8yBackLED_ByString:matrixString];
    int DataBytes_Len2 =    L8SL_PKT_START_LEN +
    L8SL_PKT_LENGHT_LEN +
    L8SL_CMD_SETLEDMTRX_LEN +
    BckData.length +
    L8SL_CMD_CRC_LEN;
    
    unsigned char DataBytes2[DataBytes_Len2];
    j= 0;
    for (int i = 0; i < L8SL_PKT_START_LEN; i++,j++)
    {//Pkt start
        DataBytes2[j]    = L8SL_PKT_START[i];
    }
    for (int i = 0; i < L8SL_PKT_LENGHT_LEN; i++,j++)
    {//DataLen reset
        DataBytes2[j]    = 0;
    }
    for (int i = 0; i < L8SL_CMD_SETBACKLED_LEN; i++,j++)
    {//Cmd field
        DataBytes2[j]    = L8SL_CMD_SETBACKLED[i];
    }
    unsigned char BckDataBytes[3];
    [BckData getBytes:BckDataBytes];
    for (int i = 0; i < BckData.length; i++,j++)
    {//Data
        DataBytes2[j]    = BckDataBytes[i];
        
        DataBytes2[2]    += 1; //Packet payload length
    }
    {//CRC
        DataBytes2[j]    = crc8(&DataBytes2[3],DataBytes_Len2-4);
        
        DataBytes2[2]    += 1; //Packet payload length
    }
    
    NSData* Cmd2 = [[NSData alloc] initWithBytes:(void*)DataBytes2 length:DataBytes_Len2];
    
    CmdStr = HexEncoding_BytesToString(Cmd2);
    for (int i = 0; i < CmdStr.length / (16*2)+1; i++)
    {
        int len = CmdStr.length - (i*16*2);
        if (len > 32)
            len = 32;
        
        NSRange rng = NSMakeRange(i*16*2, len);
        printf("%s\n", [[CmdStr substringWithRange:rng ] UTF8String]);
    }
    
    
    //
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral] withSuccess:success failure:failure];
    [self.t L8SL_SendData:Cmd2 toL8SL:[self.t activePeripheral] withSuccess:success failure:failure];
}

- (void)clearMatrixWithSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    int DataBytes_Len = L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR_LEN + 1;
    unsigned char DataBytes[DataBytes_Len];
    int j = 0;
    for (int i = 0; i < L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR_LEN; i++,j++)
    {//Header
        DataBytes[j] = L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR[i];
    }
    {//CRC
        DataBytes[j] = L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_CRC;
    }
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)DataBytes length:DataBytes_Len];
    
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isAnimating"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"stopAnimation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)readMatrixWithSuccess:(L8ColorMatrixOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)setLED:(CGPoint)point color:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
        int DataBytes_Len = L8SL_CMD_SET_LED_MATRIX_COLOR_HDR_LEN + L8SL_LED_MATRIX_A*2 + 1;
        unsigned char DataBytes[DataBytes_Len];
        int j = 0;
        for (int i = 0; i < L8SL_CMD_SET_LED_MATRIX_COLOR_HDR_LEN; i++,j++)
        {//Header
            DataBytes[j]    = L8SL_CMD_SET_LED_MATRIX_COLOR_HDR[i];
        }
        unsigned char L8SL_CMD_SET_LED_MATRIX_COLOR_RANDOM_VAL[2];
        for (int i = 0; i < L8SL_LED_MATRIX_A; i++,j+=2)
        {//Data
            arc4random_buf(L8SL_CMD_SET_LED_MATRIX_COLOR_RANDOM_VAL,2);
            DataBytes[j]    = L8SL_CMD_SET_LED_MATRIX_COLOR_RANDOM_VAL[0];
            DataBytes[j+1]  = L8SL_CMD_SET_LED_MATRIX_COLOR_RANDOM_VAL[1];
        }
        {//CRC
            DataBytes[j]    = crc8(&DataBytes[3],DataBytes_Len-4);
        }
        
        
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)DataBytes length:DataBytes_Len];
        
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];

}

- (void)clearLED:(CGPoint)point withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readLED:(CGPoint)point withSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)setSuperLED:(UIColor *)color withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)clearSuperLEDWithSuccess:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{

    
    //NSLog(@"Not implemented!");
    unsigned char CmdRaw[8] =
    {
        0xAA, 0x55, 0x04,0x4B, 0x00,0x00,0x00,
    };
    CmdRaw[7]    = crc8(&CmdRaw[3],4);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:8];
    NSLog(@"----Clear SuperLed----> %@",Cmd);
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];

}

- (void)readSuperLEDWithSuccess:(L8ColorOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readSensorStatus:(L8Sensor *)sensor withSuccess:(L8SensorStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readSensorsStatusWithSuccess:(L8SensorsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{

     NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
     
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
    [self microQuery];
    [self proximityQuery];
    [self ambientQuery];
    [self accelerationQuery];
    [self temperatureQuery];
    if (success != nil) {
     success(result);
    }
    
}


#pragma mark - Firmware calls
- (void)readFirmValues:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x60,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    NSLog(@"---- VERSIONS_QUERY ----> %@",Cmd);
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

#pragma mark - notifications methods


- (void)newClearMatrix:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    int DataBytes_Len = L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR_LEN + 1;
    unsigned char DataBytes[DataBytes_Len];
    int j = 0;
    for (int i = 0; i < L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR_LEN; i++,j++)
    {//Header
        DataBytes[j] = L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_HDR[i];
    }
    {//CRC
        DataBytes[j] = L8SL_CMD_SET_LED_MATRIX_COLOR_NONE_CRC;
    }
        


    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)DataBytes length:DataBytes_Len];

    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];

}
- (void)readNotificationsStatusWithSuccess:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    //NSLog(@"Not implemented!");
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x95,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    NSLog(@"--------> %@",Cmd);
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

// New feature >1.08.36. 

-(void) notificationsStatusQuery:(NSNumber *)n isImage:(BOOL)isImage{
    int myInt =[n integerValue];


    unsigned char * c = (unsigned char*)(&myInt); //In C++ should be intermediate cst to void*

    if(!isImage){

        unsigned char CmdRaw[7] =
        {
            0xAA, 0x55, 0x03, 0x93, *c, 0x00
        };
        CmdRaw[6]    = crc8(&CmdRaw[3],3);
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:7];
        NSLog(@"-------- %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
        
    }else{
        unsigned char CmdRaw[7] =
        {
            0xAA, 0x55, 0x03, 0x93, *c, 0x01
        };
        CmdRaw[6]    = crc8(&CmdRaw[3],3);
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:7];
        NSLog(@"-------- %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }


    
  
}


-(void)setModeDice:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    if([prefs valueForKey:@"diceR"]){
        //NSLog(@"Not implemented!");
        
        UIColor* tColor = [UIColor colorWithRed:[prefs floatForKey:@"diceR"] green:[prefs floatForKey:@"diceG"] blue:[prefs floatForKey:@"diceB"] alpha:0.0f];
        
        CGFloat components[3];
        [self getRGBComponents:components forColor:tColor];
        NSLog(@"%f %f %f", components[0], components[1], components[2]);
        
        const CGFloat  *componentts = CGColorGetComponents(tColor.CGColor);
        float rr = 255*componentts[0];
        float gg = 255*componentts[1];
        float bb = 255*componentts[2];
        unsigned char r = (unsigned char)rr;
        unsigned char g = (unsigned char)gg;
        unsigned char b = (unsigned char)bb;

        
        unsigned char CmdRaw[2+1+1+0+1+1+1+1+1] =
        {
            0xAA, 0x55, 0x05, 0x81, 0x00, r, g, b,
        };
        CmdRaw[8]    = crc8(&CmdRaw[3],5);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1+1+1+1+1];
        NSLog(@"----Mode Dice----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }else{
    
        //NSLog(@"Not implemented!");
        unsigned char CmdRaw[2+1+1+0+1+1+1+1+1] =
        {
            0xAA, 0x55, 0x05, 0x81, 0x00, 0x00, 0x0F, 0x00,
        };
        CmdRaw[8]    = crc8(&CmdRaw[3],5);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1+1+1+1+1];
        NSLog(@"----Mode Dice----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }
}

-(void)setModeParty:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{
    
    
    //NSLog(@"Not implemented!");
    unsigned char CmdRaw[2+1+1+0+1+1] =
    {
        0xAA, 0x55, 0x02, 0x81, 0x01,
    };
    CmdRaw[5]    = crc8(&CmdRaw[3],2);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1+1];
    NSLog(@"----Party Mode----> %@",Cmd);
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

- (void)setModeProximity:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs valueForKey:@"proxFrontR"]){
        //NSLog(@"Not implemented!");
        
        UIColor* fColor = [UIColor colorWithRed:[prefs floatForKey:@"proxFrontR"] green:[prefs floatForKey:@"proxFrontG"] blue:[prefs floatForKey:@"proxFrontB"] alpha:0.0f];
        
        UIColor* bColor = [UIColor blackColor];
        
        if([prefs valueForKey:@"proxBackR"]){
                bColor = [UIColor colorWithRed:[prefs floatForKey:@"proxBackR"] green:[prefs floatForKey:@"proxBackG"] blue:[prefs floatForKey:@"proxBackB"] alpha:0.0f];
        }
        
        CGFloat components[3];
        [self getRGBComponents:components forColor:fColor];
        const CGFloat  *componentts = CGColorGetComponents(fColor.CGColor);
        float rr = 255*componentts[0];
        float gg = 255*componentts[1];
        float bb = 255*componentts[2];
        unsigned char r = (unsigned char)rr;
        unsigned char g = (unsigned char)gg;
        unsigned char b = (unsigned char)bb;
        
        CGFloat componentsb[3];
        [self getRGBComponents:componentsb forColor:bColor];
        const CGFloat  *componenttsb = CGColorGetComponents(bColor.CGColor);
        float rrb = 255*componenttsb[0];
        float ggb = 255*componenttsb[1];
        float bbb = 255*componenttsb[2];
        unsigned char rback = (unsigned char)rrb;
        unsigned char gback = (unsigned char)ggb;
        unsigned char bback = (unsigned char)bbb;
        

        float myInt =[prefs floatForKey:@"proxiThre"];
//        redondeo a la baja el valor de 0 a 100 
//        int result = floor(myInt*255/100);

        
        
        NSString *s = [[NSString alloc] initWithFormat: @"%02x", (int) myInt];
        
        NSScanner *scanner = [NSScanner scannerWithString:s];
        uint32_t hex;
        [scanner scanHexInt:&hex];
        unsigned char CmdRaw[14] =
        {
            
            0xAA, 0x55, 0x0A, 0x81, 0x03, rback, gback, bback,r, g, b, hex, 0x00,
        };
        CmdRaw[13]    = crc8(&CmdRaw[3],10);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:14];
        NSLog(@"----Proximity Mode----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];

    }else{
        float myInt =[prefs floatForKey:@"proxiThre"];
        NSString *s = [[NSString alloc] initWithFormat: @"%02x", (int) myInt];
        
        NSScanner *scanner = [NSScanner scannerWithString:s];
        uint32_t hex;
        [scanner scanHexInt:&hex];

        
        unsigned char CmdRaw[14] =
        {

            0xAA, 0x55, 0x0A, 0x81, 0x03, 0xFF, 0xFF, 0xFF,0x0F, 0x0F, 0x0F, hex, 0x00,
        };
        CmdRaw[13]    = crc8(&CmdRaw[3],10);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:14];
        NSLog(@"----Proximity Mode----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }
}

- (void)setModeLuminity:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs valueForKey:@"lumFrontR"]){
        //NSLog(@"Not implemented!");
        
        UIColor* fColor = [UIColor colorWithRed:[prefs floatForKey:@"lumFrontR"] green:[prefs floatForKey:@"lumFrontG"] blue:[prefs floatForKey:@"lumFrontB"] alpha:0.0f];
        
        UIColor* bColor = [UIColor blackColor];
        
        if([prefs valueForKey:@"lumBackR"]){
            bColor = [UIColor colorWithRed:[prefs floatForKey:@"lumBackR"] green:[prefs floatForKey:@"lumBackG"] blue:[prefs floatForKey:@"lumBackB"] alpha:0.0f];
        }
        
        CGFloat components[3];
        [self getRGBComponents:components forColor:fColor];
        const CGFloat  *componentts = CGColorGetComponents(fColor.CGColor);
        float rr = 255*componentts[0];
        float gg = 255*componentts[1];
        float bb = 255*componentts[2];
        unsigned char r = (unsigned char)rr;
        unsigned char g = (unsigned char)gg;
        unsigned char b = (unsigned char)bb;
        
        CGFloat componentsb[3];
        [self getRGBComponents:componentsb forColor:bColor];
        const CGFloat  *componenttsb = CGColorGetComponents(bColor.CGColor);
        float rrb = 255*componenttsb[0];
        float ggb = 255*componenttsb[1];
        float bbb = 255*componenttsb[2];
        unsigned char rback = (unsigned char)rrb;
        unsigned char gback = (unsigned char)ggb;
        unsigned char bback = (unsigned char)bbb;
        
        
        float myInt =[prefs floatForKey:@"lumThre"];
        //        redondeo a la baja el valor de 0 a 100
        NSString *s = [[NSString alloc] initWithFormat: @"%02x", (int) myInt];
        
        NSScanner *scanner = [NSScanner scannerWithString:s];
        uint32_t hex;
        [scanner scanHexInt:&hex];
        
        unsigned char CmdRaw[14] =
        {
            
            0xAA, 0x55, 0x0A, 0x81, 0x03, r, g, b,rback, gback, bback, hex, 0x01,
        };
        CmdRaw[13]    = crc8(&CmdRaw[3],10);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:14];
        NSLog(@"----Luminity Mode----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
        
    }else{
        float myInt =[prefs floatForKey:@"lumThre"];
        //        redondeo a la baja el valor de 0 a 100
        NSString *s = [[NSString alloc] initWithFormat: @"%02x", (int) myInt];
        
        NSScanner *scanner = [NSScanner scannerWithString:s];
        uint32_t hex;
        [scanner scanHexInt:&hex];

        //NSLog(@"Not implemented!");
        unsigned char CmdRaw[14] =
        {
            
            0xAA, 0x55, 0x0A, 0x81, 0x03, 0x0F, 0x0F, 0x0F,0x0F, 0x0F, 0x0F, hex, 0x01,
        };
        CmdRaw[13]    = crc8(&CmdRaw[3],10);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:14];
        NSLog(@"----Luminity Mode----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
        
    }
}
- (void)setModeMulticolor:(NSNumber *)num success:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];


    int modeNum =[num integerValue];
    unsigned char * mn = (unsigned char*)(&modeNum);
    if([prefs valueForKey:@"multicolorSpeed"]){

\
        BOOL myBool = [prefs boolForKey:@"multicolorSwitch"];
        int val = (myBool ? 1 : 0);
        
        float myInt =[prefs floatForKey:@"multicolorSpeed"];
        unsigned char c = (unsigned char)myInt; //In C++ should be intermediate cst to void*
        
        unsigned char invert = (unsigned char)val; //In C++ should be intermediate cst to void*
        unsigned char CmdRaw[9] =
        {
            
            0xAA, 0x55, 0x05, 0x81, 0x02, *mn, c, invert,
        };
        CmdRaw[8]    = crc8(&CmdRaw[3],5);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:9];
        NSLog(@"----Multicolor Mode----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
        
    }else{
    //NSLog(@"Not implemented!");
        unsigned char CmdRaw[9] =
        {

            0xAA, 0x55, 0x05, 0x81, 0x02, 0x01, 0x30, 0x00,
        };
        CmdRaw[8]    = crc8(&CmdRaw[3],5);
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:9];
        NSLog(@"----Multicolor Mode----> %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
        
    }
}

- (void)switchOffL8:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{

    //NSLog(@"Not implemented!");
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x9D,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    NSLog(@"----Switch OFF----> %@",Cmd);
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}
-(void)stopAppMode:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{
    
    //NSLog(@"Not implemented!");  
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x82,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    NSLog(@"----Stop Mode----> %@",Cmd);
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}


-(void)enableAllNotis:(BOOL)state success:(L8NotificationsStatusOperationHandler)success failure:(L8JSONOperationHandler)failure{
     if(state){
         unsigned char CmdRaw[6] =
         {
             0xAA, 0x55, 0x02, 0x99,0x01,
         };
         CmdRaw[5]    = crc8(&CmdRaw[3],2);
         
         
         NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:6];
         NSLog(@"-------- %@",Cmd);
         [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
     }else{
         unsigned char CmdRaw[6] =
         {
             0xAA, 0x55, 0x02, 0x99, 0x01,
         };
         CmdRaw[5]    = crc8(&CmdRaw[3],2);
         
         
         NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:6];
         NSLog(@"-------- %@",Cmd);
         [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
     }
}

// Firmware >1.08.36
// Enable / Disable all notifications

- (void)setAllNotificationStatus:(BOOL)state{
    
    if(state){
        unsigned char CmdRaw[6] =
        {
            0xAA, 0x55,0x02, 0xA4, 0x01,
        };
        CmdRaw[5]    = crc8(&CmdRaw[3],2);
        
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:6];
        NSLog(@"-------- %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }else{
        unsigned char CmdRaw[6] =
        {
            0xAA, 0x55,0x02, 0xA4, 0x00,
        };
        CmdRaw[5]    = crc8(&CmdRaw[3],2);
        
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:6];
        NSLog(@"-------- %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }
}

- (void)setNotificationStatus:(NSNumber *)n state:(BOOL)state{
    int myInt =[n integerValue];
    unsigned char * c = (unsigned char*)(&myInt); //In C++ should be intermediate cst to void*

    if(state){
        unsigned char CmdRaw[7] =
        {
            0xAA, 0x55,0x03, 0x97, *c, 0x01,
        };
        CmdRaw[6]    = crc8(&CmdRaw[3],3);
        
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:7];
        NSLog(@"-------- %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }else{
        unsigned char CmdRaw[7] =
        {
            0xAA, 0x55,0x03, 0x97, *c, 0x00,
        };
        CmdRaw[6]    = crc8(&CmdRaw[3],3);
        
        
        NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:7];
        NSLog(@"-------- %@",Cmd);
        [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    }
    
}
#pragma mark - sensors methods

-(void) microQuery{
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x64,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

-(void) proximityQuery{
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x52,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

-(void) ambientQuery{
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x50,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}


-(void) accelerationQuery{
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x4C,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

-(void) temperatureQuery{
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x48,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

- (void)enableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)disableSensor:(L8Sensor *)sensor withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readSensorEnabled:(L8Sensor *)sensor withSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readBluetoothEnabledWithSuccess:(L8BooleanOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readBatteryStatusWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    //NSLog(@"Not implemented!");
    unsigned char CmdRaw[2+1+1+0+1] =
    {
        0xAA, 0x55, 0x01, 0x46,
    };
    CmdRaw[4]    = crc8(&CmdRaw[3],1);
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)CmdRaw length:2+1+1+0+1];
    
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
}

- (void)readButtonWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readMemorySizeWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)readFreeMemoryWithSuccess:(L8IntegerOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (NSString *)l8Id
{
    NSLog(@"Not implemented!");
    return nil;
}

- (void)readVersionWithSuccess:(L8VersionOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSLog(@"Not implemented!");
}

- (void)setAnimation:(L8Animation *)animation withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    [self clearMatrixWithSuccess:^{
        NSLog(@"Matrix cleared");
    } failure:^(NSMutableDictionary *result) {
        NSLog(@"Error!! Matrix is not cleared");
    }];
    success();
    
   
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (int p=0; p<2;p++){
            for (int k=0 ;k<animation.frameStrings.count; k++) {
                NSString *matrixString=[[[animation.frameStrings objectAtIndex:k] valueForKey:@"description"] componentsJoinedByString:@"-"];
                NSData* MtxData = [self getL8yMatrixCompressed_ByString:matrixString];
                
                int DataBytes_Len = L8SL_PKT_START_LEN +
                L8SL_PKT_LENGHT_LEN +
                L8SL_CMD_SETLEDMTRX_LEN +
                L8SL_LED_MATRIX_A * 2 +
                L8SL_CMD_CRC_LEN;
                
                unsigned char DataBytes[DataBytes_Len];
                int j = 0;
                for (int i = 0; i < L8SL_PKT_START_LEN; i++,j++)
                {//Pkt start
                    DataBytes[j]    = L8SL_PKT_START[i];
                }
                for (int i = 0; i < L8SL_CMD_SETLEDMTRX_LEN; i++,j++)
                {//DataLen reset
                    DataBytes[j]    = 0;
                }
                for (int i = 0; i < L8SL_PKT_LENGHT_LEN; i++,j++)
                {//Cmd field
                    DataBytes[j]    = L8SL_CMD_SETLEDMTRX[i];
                }
                unsigned char MtxDataBytes[5000];
                [MtxData getBytes:MtxDataBytes];
                
                for (int i = 0; i < L8SL_LED_MATRIX_A*2; i+=2,j+=2)
                {//Data
                    DataBytes[j]    = MtxDataBytes[i+1];
                    DataBytes[j+1]  = MtxDataBytes[i];
                    
                    DataBytes[2]    += 2; //Packet payload length
                }
                {//CRC
                    DataBytes[j]    = crc8(&DataBytes[3],DataBytes_Len-4);
                    
                    DataBytes[2]    += 1; //Packet payload length
                }
                
                
                NSData* Cmd = [[NSData alloc] initWithBytes:(void*)DataBytes length:DataBytes_Len];
                
                
                NSString* CmdStr = HexEncoding_BytesToString(Cmd);
                printf("%s\n",[[CmdStr substringToIndex:2*(L8SL_PKT_START_LEN + L8SL_PKT_LENGHT_LEN + L8SL_CMD_SETLEDMTRX_LEN) ] UTF8String]);
                CmdStr=[CmdStr substringFromIndex:2*(L8SL_PKT_START_LEN + L8SL_PKT_LENGHT_LEN + L8SL_CMD_SETLEDMTRX_LEN) ];
                for (int i = 0; i < CmdStr.length / (16*2)+1; i++)
                {
                    int len = CmdStr.length - (i*16*2);
                    if (len > 32)
                        len = 32;
                    
                    NSRange rng = NSMakeRange(i*16*2, len);
                    printf("%s\n", [[CmdStr substringWithRange:rng ] UTF8String]);
                }
                
                //---------- BACK LED
                
                NSData* BckData = [self getL8yBackLED_ByString:matrixString];
                int DataBytes_Len2 =    L8SL_PKT_START_LEN +
                L8SL_PKT_LENGHT_LEN +
                L8SL_CMD_SETLEDMTRX_LEN +
                BckData.length +
                L8SL_CMD_CRC_LEN;
                
                unsigned char DataBytes2[DataBytes_Len2];
                j= 0;
                for (int i = 0; i < L8SL_PKT_START_LEN; i++,j++)
                {//Pkt start
                    DataBytes2[j]    = L8SL_PKT_START[i];
                }
                for (int i = 0; i < L8SL_PKT_LENGHT_LEN; i++,j++)
                {//DataLen reset
                    DataBytes2[j]    = 0;
                }
                for (int i = 0; i < L8SL_CMD_SETBACKLED_LEN; i++,j++)
                {//Cmd field
                    DataBytes2[j]    = L8SL_CMD_SETBACKLED[i];
                }
                unsigned char BckDataBytes[3];
                [BckData getBytes:BckDataBytes];
                for (int i = 0; i < BckData.length; i++,j++)
                {//Data
                    DataBytes2[j]    = BckDataBytes[i];
                    
                    DataBytes2[2]    += 1; //Packet payload length
                }
                {//CRC
                    DataBytes2[j]    = crc8(&DataBytes2[3],DataBytes_Len2-4);
                    
                    DataBytes2[2]    += 1; //Packet payload length
                }
                
                NSData* Cmd2 = [[NSData alloc] initWithBytes:(void*)DataBytes2 length:DataBytes_Len2];
                
                CmdStr = HexEncoding_BytesToString(Cmd2);
                for (int i = 0; i < CmdStr.length / (16*2)+1; i++)
                {
                    int len = CmdStr.length - (i*16*2);
                    if (len > 32)
                        len = 32;
                    
                    NSRange rng = NSMakeRange(i*16*2, len);
                    printf("%s\n", [[CmdStr substringWithRange:rng ] UTF8String]);
                }
                
                BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"stopAnimation"];
                
                if (!state ) {
                
                    //
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAnimating"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral] ];
                    [self.t L8SL_SendData:Cmd2 toL8SL:[self.t activePeripheral] ];
                    usleep(([(L8Frame*)[animation.frames objectAtIndex:k] duration]*800));
                }else{
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isAnimating"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"stopAnimation"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    return;
                }
    //            sleep(([(L8Frame*)[animation.frames objectAtIndex:k] duration]/250.0));
            }
        }
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isAnimating"];
    });
    
}

- (NSString *)connectionURL
{
    NSLog(@"Not implemented!");
    return nil;
}

-(NSData*)getL8yMatrixCompressed_ByString:(NSString *)string;
{
    //Parsear
    NSString* DataStr = string;
    //DataStr = [DataStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    int dis = 0;
    NSData* Data = HexEncoding_StringToBytes(DataStr, &dis);
    
    return [self compressLEDMtxDataRGB:Data];
}

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
-(NSData*)compressLEDMtxDataRGB:(NSData*)rgbData
{
    int Len1 = (rgbData.length/3 - 1) * 2;
    unsigned char CompDataRaw[Len1];
    
    unsigned char RGBDataRaw[5000];
    [rgbData getBytes:RGBDataRaw];
    int j = 0;
    for (int i = 0; ((i < rgbData.length) && (j < Len1)); i+=3, j += 2)
    {
        //Blue
        CompDataRaw[j+1] = 0x00;
        CompDataRaw[j+1] = RGBDataRaw[i+2] /17; //>> 4;
        //Red
        CompDataRaw[j] = 0x00;
        CompDataRaw[j] = RGBDataRaw[i+0] /17; //>> 4;
        //Green
        CompDataRaw[j] |= ((RGBDataRaw[i+1] /17 /* >> 4*/) << 4);
        
        /*
         printf("%02X %02X ",CompDataRaw[j+1],CompDataRaw[j]);
         if ((i > 3) && (!(i % (16*3))))
         printf("\n");
         */
    }
    
    return [NSData dataWithBytes:CompDataRaw length:Len1];
}

-(NSData*)getL8yBackLED_ByString:(NSString*)string
{
    //Parsear
    NSString* DataStr = string;
    //DataStr = [DataStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    //Las siguientes lineas cogen los 6 caracteres del color exadecimal y lo dejan en un color de 16 bits
    DataStr =[DataStr substringFromIndex:(DataStr.length-6)];
    DataStr= [NSString stringWithFormat:@"0%c0%c0%c", [DataStr characterAtIndex:4],[DataStr characterAtIndex:2],[DataStr characterAtIndex:0]];
    //en la ultima linea se cambia el orden de los colores para pasarlo en formato BGR
    
    int dis = 0;
    
    //NSData* Data = HexEncoding_StringToBytes([DataStr substringFromIndex:(DataStr.length-6)], &dis);
    NSData* Data = HexEncoding_StringToBytes(DataStr, &dis);
    
    //Coger los ultimos 3 bytes (6 nibbles) y devolverlos en un NSData. Si 000000 devolver 0f0000.
    unsigned char BckLEDBytes[3];
    [Data getBytes:BckLEDBytes];
    if ((BckLEDBytes[0] == 0) && (BckLEDBytes[1] == 0) && (BckLEDBytes[2] == 0))
        BckLEDBytes[0] = 0x00;
    
    return [NSData dataWithBytes:BckLEDBytes length:3];
}

- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component]; // / 255.0f;
    }
}

- (void)storeFrameWithMatrix:(NSArray *)colorMatrix withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    NSString *matrixString=[[colorMatrix valueForKey:@"description"] componentsJoinedByString:@"-"];
    NSData* MtxData = [self getL8yMatrixCompressed_ByString:matrixString];
    
    int DataBytes_Len = L8SL_PKT_START_LEN +
    L8SL_PKT_LENGHT_LEN +
    L8SL_L8_STORE_FRAME_LEN +
    L8SL_LED_MATRIX_A * 2 +
    L8SL_CMD_CRC_LEN;
    
    unsigned char DataBytes[DataBytes_Len];
    int j = 0;
    for (int i = 0; i < L8SL_PKT_START_LEN; i++,j++)
    {//Pkt start
        DataBytes[j]    = L8SL_PKT_START[i];
    }
    for (int i = 0; i < L8SL_CMD_SETLEDMTRX_LEN; i++,j++)
    {//DataLen reset
        DataBytes[j]    = 0;
    }
    for (int i = 0; i < L8SL_PKT_LENGHT_LEN; i++,j++)
    {//Cmd field
        DataBytes[j]    = L8SL_L8_STORE_FRAME[i];
    }
    unsigned char MtxDataBytes[5000];
    [MtxData getBytes:MtxDataBytes];
    
    for (int i = 0; i < L8SL_LED_MATRIX_A*2; i+=2,j+=2)
    {//Data
        DataBytes[j]    = MtxDataBytes[i+1];
        DataBytes[j+1]  = MtxDataBytes[i];
        
        DataBytes[2]    += 2; //Packet payload length
    }
    {//CRC
        DataBytes[j]    = crc8(&DataBytes[3],DataBytes_Len-4);
        
        DataBytes[2]    += 1; //Packet payload length
    }
    
    
    NSData* Cmd = [[NSData alloc] initWithBytes:(void*)DataBytes length:DataBytes_Len];
    
    
    NSString* CmdStr = HexEncoding_BytesToString(Cmd);
    printf("%s\n",[[CmdStr substringToIndex:2*(L8SL_PKT_START_LEN + L8SL_PKT_LENGHT_LEN + L8SL_CMD_SETLEDMTRX_LEN) ] UTF8String]);
    CmdStr=[CmdStr substringFromIndex:2*(L8SL_PKT_START_LEN + L8SL_PKT_LENGHT_LEN + L8SL_CMD_SETLEDMTRX_LEN) ];
    for (int i = 0; i < CmdStr.length / (16*2)+1; i++)
    {
        int len = CmdStr.length - (i*16*2);
        if (len > 32)
            len = 32;
        
        NSRange rng = NSMakeRange(i*16*2, len);
        printf("%s\n", [[CmdStr substringWithRange:rng ] UTF8String]);
    }
    
    //---------- BACK LED
    
    NSData* BckData = [self getL8yBackLED_ByString:matrixString];
    int DataBytes_Len2 =    L8SL_PKT_START_LEN +
    L8SL_PKT_LENGHT_LEN +
    L8SL_CMD_SETLEDMTRX_LEN +
    BckData.length +
    L8SL_CMD_CRC_LEN;
    
    unsigned char DataBytes2[DataBytes_Len2];
    j= 0;
    for (int i = 0; i < L8SL_PKT_START_LEN; i++,j++)
    {//Pkt start
        DataBytes2[j]    = L8SL_PKT_START[i];
    }
    for (int i = 0; i < L8SL_PKT_LENGHT_LEN; i++,j++)
    {//DataLen reset
        DataBytes2[j]    = 0;
    }
    for (int i = 0; i < L8SL_CMD_SETBACKLED_LEN; i++,j++)
    {//Cmd field
        DataBytes2[j]    = L8SL_CMD_SETBACKLED[i];
    }
    unsigned char BckDataBytes[3];
    [BckData getBytes:BckDataBytes];
    for (int i = 0; i < BckData.length; i++,j++)
    {//Data
        DataBytes2[j]    = BckDataBytes[i];
        
        DataBytes2[2]    += 1; //Packet payload length
    }
    {//CRC
        DataBytes2[j]    = crc8(&DataBytes2[3],DataBytes_Len2-4);
        
        DataBytes2[2]    += 1; //Packet payload length
    }
    
    NSData* Cmd2 = [[NSData alloc] initWithBytes:(void*)DataBytes2 length:DataBytes_Len2];
    
    CmdStr = HexEncoding_BytesToString(Cmd2);
    for (int i = 0; i < CmdStr.length / (16*2)+1; i++)
    {
        int len = CmdStr.length - (i*16*2);
        if (len > 32)
            len = 32;
        
        NSRange rng = NSMakeRange(i*16*2, len);
        printf("%s\n", [[CmdStr substringWithRange:rng ] UTF8String]);
    }
    
    
    //
    [self.t L8SL_SendData:Cmd toL8SL:[self.t activePeripheral]];
    [self.t L8SL_SendData:Cmd2 toL8SL:[self.t activePeripheral]];
    
}

@end
