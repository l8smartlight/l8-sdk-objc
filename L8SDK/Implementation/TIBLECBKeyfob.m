//
//  TIBLECBKeyfob.m
//  TI-BLE-Demo
//
//  Created by Ole Andreas Torvmark on 10/31/11.
//  Copyright (c) 2011 ST alliance AS. All rights reserved.
//

#import "TIBLECBKeyfob.h"

@implementation TIBLECBKeyfob

@synthesize delegate;
@synthesize CM;
@synthesize peripherals;
@synthesize activePeripheral;
@synthesize batteryLevel;
@synthesize key1;
@synthesize key2;
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize TXPwrLevel;

@synthesize Config1;
@synthesize Not1;
@synthesize BatLevel;

//JPS L8SL ---------------------- INI


//Habilitar notificaciones TX ... REVISAR!!! ¿Sumar +1 a UUIDs??
-(void) L8SL_EnableTXNotif:(CBPeripheral *)p
{
    //logmethod();
    [self notification:L8SL_SPPLE_SERVICE_UUID_BYTES characteristicUUID:L8SL_SPPLE_TX_CHARACTERISTIC_UUID_BYTES p:p on:YES];
}
-(void) L8SL_DisableTXNotif:(CBPeripheral *)p
{
    //logmethod();
    [self notification:L8SL_SPPLE_SERVICE_UUID_BYTES characteristicUUID:L8SL_SPPLE_TX_CHARACTERISTIC_UUID_BYTES p:p on:NO];
}

-(void) L8SL_RequestTXCredits:(NSUInteger)credits toL8SL:(CBPeripheral *)p
{
    //logmethod();
    //Convertir int to NSData (2 bytes) 
    char Credits[2] = {0xff, 0xff};    //65536 creditos. De momento, pasamos de los credits que nos piden
    NSData *CreditsData = [[NSData alloc] initWithBytes:Credits length:2];
    [self writeValue:L8SL_SPPLE_SERVICE_UUID_BYTES characteristicUUID:L8SL_SPPLE_TX_CREDITS_CHARACTERISTIC_UUID_BYTES p:p data:CreditsData];
}

-(void) L8SL_RequestRXCredits:(NSUInteger)credits toL8SL:(CBPeripheral *)p
{
    //logmethod();
    //Convertir int to NSData (2 bytes)
    char Credits[2] = {0xff, 0xff};    //256 creditos. De momento, pasamos de los credits que nos piden
    NSData *CreditsData = [[NSData alloc] initWithBytes:Credits length:2];
    [self writeValue:L8SL_SPPLE_SERVICE_UUID_BYTES characteristicUUID:L8SL_SPPLE_RX_CREDITS_CHARACTERISTIC_UUID_BYTES p:p data:CreditsData];
}


//PUBLICAS
//Pide creditos de caracteristica RX y escribe los datos
-(void) L8SL_SendData:(NSData*)data toL8SL:(CBPeripheral*)p
{
    //logmethod();
    [self L8SL_RequestRXCredits:data.length toL8SL:p]; //Quiza aquí si habria que pedir confirmación de envío...
    [self writeValue:L8SL_SPPLE_SERVICE_UUID_BYTES characteristicUUID:L8SL_SPPLE_RX_CHARACTERISTIC_UUID_BYTES p:p data:data];
}

-(void) L8SL_SendData:(NSData*)data toL8SL:(CBPeripheral*)p withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    //logmethod();
    [self L8SL_RequestRXCredits:data.length toL8SL:p]; //Quiza aquí si habria que pedir confirmación de envío...
    [self writeValue:L8SL_SPPLE_SERVICE_UUID_BYTES
  characteristicUUID:L8SL_SPPLE_RX_CHARACTERISTIC_UUID_BYTES
                   p:p
                data:data
         withSuccess:(L8VoidOperationHandler)success
             failure:(L8JSONOperationHandler)failure];
}


//Pide creditos de sobra de caracteristica TX y habilita notificación TX
-(void) L8SL_PrepareForReceiveDataFromL8SL:(CBPeripheral *)p
{
    //logmethod();
    NSUInteger DataLen = 0xffff; //Ojo! Si recibimos del L8 mas de ffff bytes se nos acaban los creditos!! volver a pedir creditos TX!
    [self L8SL_RequestTXCredits:DataLen toL8SL:p]; //Quiza aquí si habria que pedir confirmación de envío...
    [self L8SL_EnableTXNotif:p];
}

/*!
 *  @method soundBuzzer:
 *
 *  @param buzVal The data to write
 *  @param p CBPeripheral to write to
 *
 *  @discussion Sound the buzzer on a TI keyfob. This method writes a value to the proximity alert service
 *
 */

-(void) soundBuzzer:(Byte)buzVal p:(CBPeripheral *)p 
{
    //logmethod();
    //char Data[2] = {0x20, 0x20};
    //NSData *d = [[NSData alloc] initWithBytes:Data length:2];
    //[self writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID p:p data:d];
}
-(void) soundBuzzer:(Byte*)buzVal l:(int)buzValLen p:(CBPeripheral *)p 
{
    //logmethod();
    //char Data[2] = {0x20, 0x20};
    //NSData *d = [[NSData alloc] initWithBytes:buzVal length:buzValLen];
    //[self writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID p:p data:d];
}

//...
-(void) enableLEDs:(Byte)val p:(CBPeripheral *)p
{
    //logmethod();
    //NSData *d = [[NSData alloc] initWithBytes:&val length:1];
    //[self writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:CUSTOM_LED_PROPERTY_UUID p:p data:d];
}

//Parametros ya listos para enviar (si hay que dividir/mult por 10 ya deben estarlo)
/*
-(void) setConfigOnPeripheral:(CBPeripheral *)p
                   withDayVib:(Byte)dayVib 
                   withDayInt:(Byte)dayInt
                   withDayTmS:(Byte)dayTmS
                   withNightVib:(Byte)nightVib 
                   withNightInt:(Byte)nightInt
                   withNightTmS:(Byte)nightTmS
                   withNightDlM:(Byte)nightDlM
                   withMaskMode:(Byte)maskMode
{
    Byte ConfigData[] = {dayVib,dayInt,dayTmS,nightVib,nightInt,nightTmS,nightDlM,maskMode};
    NSData *d = [[NSData alloc] initWithBytes:&ConfigData length:CUSTOM_CONFG_PROPERTY_LEN];
    [self writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:CUSTOM_CONFG_PROPERTY_UUID p:p data:d];
}
*/
-(void) setConfigOnPeripheral:(CBPeripheral *)p
                   withDayVib:(Byte)dayVib
                   withDayInt:(Byte)dayInt
                   withDayTmS:(Byte)dayTmS
                   withDayCyc:(Byte)dayCyc
                withDayCycInt:(Byte)dayCycInt
                 withNightVib:(Byte)nightVib
                 withNightInt:(Byte)nightInt
                 withNightTmS:(Byte)nightTmS
                 withNightCyc:(Byte)nightCyc
              withNightCycInt:(Byte)nightCycInt
                 withNightDlM:(Byte)nightDlM
                 withMaskMode:(Byte)maskMode
{
    //logmethod();
    ////Byte ConfigData[] = {dayVib,dayInt,dayTmS,dayCyc,dayCycInt,nightVib,nightInt,nightTmS,nightCyc,nightCycInt,nightDlM,maskMode};
    //Byte ConfigData[] = {dayVib,dayTmS,dayInt,dayCyc,dayCycInt,nightVib,nightTmS,nightInt,nightCyc,nightCycInt,nightDlM,maskMode};

    //NSData *d = [[NSData alloc] initWithBytes:&ConfigData length:CUSTOM_CONFG_PROPERTY_LEN_2];
    //[self writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:CUSTOM_CONFG_PROPERTY_UUID p:p data:d];
}

-(void) setConfigOnPeripheral:(CBPeripheral *)p
                   withDayVib:(Byte)dayVib
                   withDayInt:(Byte)dayInt
                   withDayTmS:(Byte)dayTmS
                 withNightVib:(Byte)nightVib
                 withNightInt:(Byte)nightInt
                 withNightTmS:(Byte)nightTmS
                 withNightDlM:(Byte)nightDlM
                 withMaskMode:(Byte)maskMode
{
    
}




//JPS esto lanza la orden de leer
-(void) readConfig:(CBPeripheral *)p 
{
    //logmethod();
    [self readValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:CUSTOM_CONFG_PROPERTY_UUID p:p];
}

-(void) enableNotif:(CBPeripheral *)p
{
    //logmethod();
    [self notification:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:CUSTOM_NOTIFY_PROPERTY_UUID p:p on:YES];
}

-(void) readBatteryLevel:(CBPeripheral *)p
{
    //logmethod();
    [self readValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:CUSTOM_BAT_LVL_PROPERTY_UUID p:p];
}


/* ORIGINAL
 -(void) soundBuzzer:(Byte)buzVal p:(CBPeripheral *)p {
 NSData *d = [[NSData alloc] initWithBytes:&buzVal length:TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN];
 [self writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID p:p data:d];
 }
 */

/*!
 *  @method readBattery:
 *
 *  @param p CBPeripheral to read from
 *
 *  @discussion Start a battery level read cycle from the battery level service 
 *
 */
-(void) readBattery:(CBPeripheral *)p
{
    //logmethod();
    [self readValue:TI_KEYFOB_BATT_SERVICE_UUID characteristicUUID:TI_KEYFOB_LEVEL_SERVICE_UUID p:p];
}


// 

/*!
 *  @method enableAccelerometer:
 *
 *  @param p CBPeripheral to write to
 *
 *  @discussion Enables the accelerometer and enables notifications on X,Y and Z axis
 *
 */
-(void) enableAccelerometer:(CBPeripheral *)p
{
    //logmethod();
    //char data = 0x01;
    //NSData *d = [[NSData alloc] initWithBytes:&data length:1];
    //[self writeValue:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_ENABLER_UUID p:p data:d];
    [self notification:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_X_UUID p:p on:YES];
    [self notification:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_Y_UUID p:p on:YES];
    [self notification:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_Z_UUID p:p on:YES];
    printf("Enabling accelerometer\r\n");
}

/*!
 *  @method disableAccelerometer:
 *
 *  @param p CBPeripheral to write to
 *
 *  @discussion Disables the accelerometer and disables notifications on X,Y and Z axis
 *
 */
-(void) disableAccelerometer:(CBPeripheral *)p
{
    //logmethod();
    //char data = 0x00;
    //NSData *d = [[NSData alloc] initWithBytes:&data length:1];
    //[self writeValue:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_ENABLER_UUID p:p data:d];
    [self notification:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_X_UUID p:p on:NO];
    [self notification:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_Y_UUID p:p on:NO];
    [self notification:TI_KEYFOB_ACCEL_SERVICE_UUID characteristicUUID:TI_KEYFOB_ACCEL_Z_UUID p:p on:NO];
    printf("Disabling accelerometer\r\n");
}


/*!
 *  @method enableButtons:
 *
 *  @param p CBPeripheral to write to
 *
 *  @discussion Enables notifications on the simple keypress service
 *
 */
-(void) enableButtons:(CBPeripheral *)p
{
    //logmethod();
    [self notification:TI_KEYFOB_KEYS_SERVICE_UUID characteristicUUID:TI_KEYFOB_KEYS_NOTIFICATION_UUID p:p on:YES];
}

/*!
 *  @method disableButtons:
 *
 *  @param p CBPeripheral to write to
 *
 *  @discussion Disables notifications on the simple keypress service
 *
 */
-(void) disableButtons:(CBPeripheral *)p
{
    //logmethod();
    [self notification:TI_KEYFOB_KEYS_SERVICE_UUID characteristicUUID:TI_KEYFOB_KEYS_NOTIFICATION_UUID p:p on:NO];
}

/*!
 *  @method enableTXPower:
 *
 *  @param p CBPeripheral to write to
 *
 *  @discussion Enables notifications on the TX Power level service
 *
 */
-(void) enableTXPower:(CBPeripheral *)p
{
    //logmethod();
    [self notification:TI_KEYFOB_PROXIMITY_TX_PWR_SERVICE_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_UUID p:p on:YES];
}

/*!
 *  @method disableTXPower:
 *
 *  @param p CBPeripheral to write to
 *
 *  @discussion Disables notifications on the TX Power level service
 *
 */
-(void) disableTXPower:(CBPeripheral *)p
{
    //logmethod();
    [self notification:TI_KEYFOB_PROXIMITY_TX_PWR_SERVICE_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_UUID p:p on:NO];
}




/*!
 *  @method writeValue:
 *
 *  @param serviceUUID Service UUID to write to (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to write to (e.g. 0x2401)
 *  @param data Data to write to peripheral
 *  @param p CBPeripheral to write to
 *
 *  @discussion Main routine for writeValue request, writes without feedback. It converts integer into
 *  CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service. 
 *  If this is found, value is written. If not nothing is done.
 *
 */
#define L8SL_MTU_MAX    23
-(void) writeValue:(UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data
{
    //logmethod();
    UInt8 s[16];
    UInt8 c[16];
    [self swap2:serviceUUID length:16 toBuffer:(UInt8*)s];
    [self swap2:characteristicUUID length:16 toBuffer:(UInt8*)c];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)s length:16];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)c length:16];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    //[p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
    
    if (data.length > L8SL_MTU_MAX)
    {
        double rounds = ceil((double)((double)data.length/L8SL_MTU_MAX));
       
        for (int r = 0; r < rounds; r++)
        {
            int rl = L8SL_MTU_MAX;
            if ((data.length - (r*L8SL_MTU_MAX)) < L8SL_MTU_MAX)
                rl = (data.length - (r*L8SL_MTU_MAX));
            
            NSUInteger Loc = r*L8SL_MTU_MAX;
            
            NSRange rank = {Loc,rl}; //NSMakeRange(Loc, rl);
            unsigned char bytes[L8SL_MTU_MAX];
            [data getBytes:bytes range:rank];
            NSData* data2 = [[NSData alloc]initWithBytes:bytes length:(NSUInteger)rl];
            [p writeValue:data2 forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
        }
    }
    else
    {
        [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

-(void) writeValue:(UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure
{
    //logmethod();
    UInt8 s[16];
    UInt8 c[16];
    [self swap2:serviceUUID length:16 toBuffer:(UInt8*)s];
    [self swap2:characteristicUUID length:16 toBuffer:(UInt8*)c];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)s length:16];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)c length:16];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        failure(nil);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        failure(nil);
        return;
    }
    //[p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
    
    if (data.length > L8SL_MTU_MAX)
    {
        double rounds = ceil((double)((double)data.length/L8SL_MTU_MAX));
        
        for (int r = 0; r < rounds; r++)
        {
            int rl = L8SL_MTU_MAX;
            if ((data.length - (r*L8SL_MTU_MAX)) < L8SL_MTU_MAX)
                rl = (data.length - (r*L8SL_MTU_MAX));
            
            NSUInteger Loc = r*L8SL_MTU_MAX;
            
            NSRange rank = {Loc,rl}; //NSMakeRange(Loc, rl);
            unsigned char bytes[L8SL_MTU_MAX];
            [data getBytes:bytes range:rank];
            NSData* data2 = [[NSData alloc]initWithBytes:bytes length:(NSUInteger)rl];
            [p writeValue:data2 forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
        }
    }
    else
    {
        [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
    }
    success();
}
/*
-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data
{
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:16];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:16];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
}
*/


/*!
 *  @method readValue:
 *
 *  @param serviceUUID Service UUID to read from (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to read from (e.g. 0x2401)
 *  @param p CBPeripheral to read from
 *
 *  @discussion Main routine for read value request. It converts integers into
 *  CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service. 
 *  If this is found, the read value is started. When value is read the didUpdateValueForCharacteristic 
 *  routine is called.
 *
 *  @see didUpdateValueForCharacteristic
 */

-(void) readValue: (UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID p:(CBPeripheral *)p
{
    //logmethod();
    UInt8 s[16];
    UInt8 c[16];
    [self swap2:serviceUUID length:16 toBuffer:(UInt8*)s];
    [self swap2:characteristicUUID length:16 toBuffer:(UInt8*)c];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)s length:16];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)c length:16];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        printf("*Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p readValueForCharacteristic:characteristic];
}
/*
-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p {
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:16];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:16];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }  
    [p readValueForCharacteristic:characteristic];
}
*/


/*!
 *  @method notification:
 *
 *  @param serviceUUID Service UUID to read from (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to read from (e.g. 0x2401)
 *  @param p CBPeripheral to read from
 *
 *  @discussion Main routine for enabling and disabling notification services. It converts integers 
 *  into CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service. 
 *  If this is found, the notfication is set. 
 *
 */
-(void) notification:(UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on
{
    //logmethod();
    UInt8 s[16];
    UInt8 c[16];
    [self swap2:serviceUUID length:16 toBuffer:(UInt8*)s];
    [self swap2:characteristicUUID length:16 toBuffer:(UInt8*)c];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)s length:16];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)c length:16];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        printf("**Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}
/*
-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on {
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:16];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:16];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}
*/

/*!
 *  @method swap:
 *
 *  @param s Uint16 value to byteswap
 *
 *  @discussion swap byteswaps a UInt16 
 *
 *  @return Byteswapped UInt16
 */

-(UInt16) swap:(UInt16)s {
    //logmethod();
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

-(void) swap2:(UInt8*)s length:(int)len toBuffer:(UInt8*)b
{
    //logmethod();
    for(int i = 0; i < len; i++)
        b[len - i -1] = s[i];
}


/*!
 *  @method controlSetup:
 *
 *  @param s Not used
 *
 *  @return Allways 0 (Success)
 *  
 *  @discussion controlSetup enables CoreBluetooths Central Manager and sets delegate to TIBLECBKeyfob class 
 *
 */
- (int) controlSetup: (int) s{
    //logmethod();
    self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    return 0;
}

/*!
 *  @method findBLEPeripherals:
 *
 *  @param timeout timeout in seconds to search for BLE peripherals
 *
 *  @return 0 (Success), -1 (Fault)
 *  
 *  @discussion findBLEPeripherals searches for BLE peripherals and sets a timeout when scanning is stopped
 *
 */
- (int) findBLEPeripherals:(int) timeout
{
    int countRetries = [[NSUserDefaults standardUserDefaults] integerForKey:@"retriesCount"];
    //logmethod();
    if (self->CM.state  != CBCentralManagerStatePoweredOn) {
        printf("CoreBluetooth not correctly initialized !\r\n");
        printf("State = %d (%s)\r\n",self->CM.state,[self centralManagerStateToString:self.CM.state]);
        return -1;
    }
    
    if(countRetries>=2){
        
        UIAlertView *newAlert = [[UIAlertView alloc] initWithTitle:@"Can not connect" message:@"To start using your L8 device ensure is not previously paired with System. Please check it, go to device Settings->Bluetooth->Your L8 Device and must show NOT CONNECTED, if not press 'Forget this Device'. Came back to the app and enjoy your L8 ;)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [newAlert show];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"retriesCount"];
        return -1;
    }
    
    countRetries++;
    [[NSUserDefaults standardUserDefaults] setInteger:countRetries forKey:@"retriesCount"];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)timeout target:self selector:@selector(scanTimer:) userInfo:nil repeats:NO];
    
    //JPS BLE: se podria pasar a la funcion un array de CBUUIDs con el ID del servicio del L8 para acortar busqueda de peripherals...   
    //NSArray* L8SL_Service = [[NSArray alloc] initWithObjects:L8SL_SPPLE_SERVICE_UUID, nil];
    
    printf("Scanning...\r\n");
    
    //    Si tenemos dispositivos que hemos pareado los buscamos y conectamos
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"Last_L8_Device_Id"]){
        _connected = NO;


        [self.CM scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:L8SL_SPPLE_SERVICE_UUID]]  options:0];
       
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            
            NSString *lastId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Last_L8_Device_Id"]];
            NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:lastId];//where savedUUID is the string version of the NSUUID you've saved somewhere
            if(!_connected && ![lastId isEqualToString:@"null"]){
                NSArray *peripheralsNew = [self.CM retrievePeripheralsWithIdentifiers:@[uuid]];
                if(peripheralsNew.count>0){
                    
                    for(CBPeripheral *periph in peripheralsNew)
                    {
                        [self connectPeripheral:periph];
                        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"retriesCount"];
                        //        [self.CM scanForPeripheralsWithServices:periph.services  options:0];
                    }
                }
            }else{
                [self.CM scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:L8SL_SPPLE_SERVICE_UUID]]  options:0]; // Start scanning
            }

        });
       
        
        
   }else{
//       [self CBUUIDToString:s.UUID]

        [self.CM scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:L8SL_SPPLE_SERVICE_UUID]] options:nil];
//        [self.CM scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:L8SL_SPPLE_SERVICE_UUID]]  options:0];
       
        
    }
    // Start scanning
    return 0; // Started scanning OK !

}


/*!
 *  @method connectPeripheral:
 *
 *  @param p Peripheral to connect to
 *
 *  @discussion connectPeripheral connects to a given peripheral and sets the activePeripheral property of TIBLECBKeyfob.
 *
 */
- (void) connectPeripheral:(CBPeripheral *)peripheral
{
    //logmethod();
    NSString *valueID = [NSString stringWithFormat:@"%s",[self UUIDToString:peripheral.UUID]];
    printf("Connecting to peripheral with UUID : %@\r\n",valueID);
    
    [[NSUserDefaults standardUserDefaults] setValue:valueID forKey:@"Last_L8_Device_Id"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstTimePaired"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    activePeripheral = peripheral;
    activePeripheral.delegate = self;
    if (!self.peripherals) {
        self.peripherals=[[NSMutableArray alloc] init];
    }


    if (!self.userPeripherals) {
        self.userPeripherals=[[NSMutableArray alloc] init];
    }
    
    NSMutableDictionary *finalDictionary = [NSMutableDictionary dictionary];
    [finalDictionary setObject:[NSString stringWithFormat:@"%@",peripheral.name] forKey:@"name"];
    [finalDictionary setObject:valueID forKey:@"identifier"];
    [finalDictionary setObject:@"YES" forKey:@"isConnected"];
    [finalDictionary setObject:@"YES" forKey:@"isUserChecked"];
    [finalDictionary setObject:peripheral forKey:@"peripheral"];
    
    BOOL exists=NO;
    for(int i=0;i<self.peripherals.count;i++){
        NSString *oldvalueID = [NSString stringWithFormat:@"%s",[self UUIDToString:[[self.peripherals objectAtIndex:i] UUID]]];
        if([oldvalueID isEqualToString:valueID]){
            exists=YES;
        }
        
    }
    
    if(!exists){
        [self.userPeripherals addObject:finalDictionary];
        [self.peripherals addObject:peripheral];
        [CM connectPeripheral:activePeripheral options:nil];
        _connected = YES;
    //    Broadcast new device ON
        [[NSNotificationCenter defaultCenter] postNotificationName:@"L8Connected" object:peripheral];
    }
}

/*!
 *  @method centralManagerStateToString:
 *
 *  @param state State to print info of
 *
 *  @discussion centralManagerStateToString prints information text about a given CBCentralManager state
 *
 */
- (const char *) centralManagerStateToString: (int)state
{
    //logmethod();
    switch(state) {
        case CBCentralManagerStateUnknown: 
            return "State unknown (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateResetting:
            return "State resetting (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateUnsupported:
            return "State BLE unsupported (CBCentralManagerStateResetting)";
        case CBCentralManagerStateUnauthorized:
            return "State unauthorized (CBCentralManagerStateUnauthorized)";
        case CBCentralManagerStatePoweredOff:
            return "State BLE powered off (CBCentralManagerStatePoweredOff)";
        case CBCentralManagerStatePoweredOn:
            return "State powered up and ready (CBCentralManagerStatePoweredOn)";
        default:
            return "State unknown";
    }
    return "Unknown state";
}

/*!
 *  @method scanTimer:
 *
 *  @param timer Backpointer to timer
 *
 *  @discussion scanTimer is called when findBLEPeripherals has timed out, it stops the CentralManager from scanning further and prints out information about known peripherals
 *
 */
- (void) scanTimer:(NSTimer *)timer
{
    //logmethod();
    [self.CM stopScan];
    printf("Stopped Scanning\r\n");
    printf("Known peripherals : %d\r\n",[self->peripherals count]);
    [self printKnownPeripherals];
    if ([peripherals count]==0) {
        [self.delegate connectToL8];
    }
}

/*!
 *  @method printKnownPeripherals:
 *
 *  @discussion printKnownPeripherals prints all curenntly known peripherals stored in the peripherals array of TIBLECBKeyfob class 
 *
 */
- (void) printKnownPeripherals
{
    //logmethod();
    int i;
    printf("List of currently known peripherals : \r\n");
    for (i=0; i < self.peripherals.count; i++)
    {
        CBPeripheral *p = [self->peripherals objectAtIndex:i];
        CFStringRef s = CFUUIDCreateString(NULL, p.UUID);
        printf("%d  |  %s\r\n",i,CFStringGetCStringPtr(s, 0));
        [self printPeripheralInfo:p];
    }
    
//    Check if first time and device could be paired previously
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTimePaired"]){
        if(self.peripherals.count==0){
        UIAlertView *showInfo = [[UIAlertView alloc] initWithTitle:@"Can not connect" message:@"Looks like is your first time, Bravo!. To start using your L8 device ensure is not previously paired with System. Please check it, go to device Settings->Bluetooth->Your L8 Device and must show NOT CONNECTED, if not press 'Forget this Device'. Came back to the app and enjoy your L8 ;)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [showInfo show];

        }
    
    }
    
}

/*
 *  @method printPeripheralInfo:
 *
 *  @param peripheral Peripheral to print info of 
 *
 *  @discussion printPeripheralInfo prints detailed info about peripheral 
 *
 */
- (void) printPeripheralInfo:(CBPeripheral*)peripheral
{
    //logmethod();
    CFStringRef s = CFUUIDCreateString(NULL, peripheral.UUID);
    printf("------------------------------------\r\n");
    printf("Peripheral Info :\r\n");
    printf("UUID : %s\r\n",CFStringGetCStringPtr(s, 0));
    printf("RSSI : %d\r\n",[peripheral.RSSI intValue]);
    printf("Name : %s\r\n",[peripheral.name cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    printf("isConnected : %d\r\n",peripheral.isConnected);
     NSLog(@"ID :%@\r\n",peripheral.identifier);
    printf("-------------------------------------\r\n");
    
}

/*
 *  @method UUIDSAreEqual:
 *
 *  @param u1 CFUUIDRef 1 to compare
 *  @param u2 CFUUIDRef 2 to compare
 *
 *  @returns 1 (equal) 0 (not equal)
 *
 *  @discussion compares two CFUUIDRef's
 *
 */

- (int) UUIDSAreEqual:(CFUUIDRef)u1 u2:(CFUUIDRef)u2
{
    //logmethod();
    CFUUIDBytes b1 = CFUUIDGetUUIDBytes(u1);
    CFUUIDBytes b2 = CFUUIDGetUUIDBytes(u2);
    if (memcmp(&b1, &b2, 16) == 0) {
        return 1;
    }
    else return 0;
}


/*
 *  @method getAllServicesFromKeyfob
 *
 *  @param p Peripheral to scan
 *
 *
 *  @discussion getAllServicesFromKeyfob starts a service discovery on a peripheral pointed to by p.
 *  When services are found the didDiscoverServices method is called
 *
 */
-(void) getAllServicesFromKeyfob:(CBPeripheral *)p
{
    //logmethod();
    [p discoverServices:nil]; // Discover all services without filter
    
}

/*
 *  @method getAllCharacteristicsFromKeyfob
 *
 *  @param p Peripheral to scan
 *
 *
 *  @discussion getAllCharacteristicsFromKeyfob starts a characteristics discovery on a peripheral
 *  pointed to by p
 *
 */
-(void) getAllCharacteristicsFromKeyfob:(CBPeripheral *)p
{
    //logmethod();
    for (int i=0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        printf("Fetching characteristics for service with UUID : %s\r\n",[self CBUUIDToString:s.UUID]);
        [p discoverCharacteristics:nil forService:s];
    }
}


/*
 *  @method CBUUIDToString
 *
 *  @param UUID UUID to convert to string
 *
 *  @returns Pointer to a character buffer containing UUID in string representation
 *
 *  @discussion CBUUIDToString converts the data of a CBUUID class to a character pointer for easy printout using printf()
 *
 */
-(const char *) CBUUIDToString:(CBUUID *) UUID
{
    //logmethod();
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}


/*
 *  @method UUIDToString
 *
 *  @param UUID UUID to convert to string
 *
 *  @returns Pointer to a character buffer containing UUID in string representation
 *
 *  @discussion UUIDToString converts the data of a CFUUIDRef class to a character pointer for easy printout using printf()
 *
 */
-(const char *) UUIDToString:(CFUUIDRef)UUID
{
    //logmethod();
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
}

/*
 *  @method compareCBUUID
 *
 *  @param UUID1 UUID 1 to compare
 *  @param UUID2 UUID 2 to compare
 *
 *  @returns 1 (equal) 0 (not equal)
 *
 *  @discussion compareCBUUID compares two CBUUID's to each other and returns 1 if they are equal and 0 if they are not
 *
 */

-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2
{
    //logmethod();
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;
}

/*
 *  @method compareCBUUIDToInt
 *
 *  @param UUID1 UUID 1 to compare
 *  @param UUID2 UInt16 UUID 2 to compare
 *
 *  @returns 1 (equal) 0 (not equal)
 *
 *  @discussion compareCBUUIDToInt compares a CBUUID to a UInt16 representation of a UUID and returns 1 
 *  if they are equal and 0 if they are not
 *
 */
-(int) compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2
{
    //logmethod();
    char b1[16];
    [UUID1.data getBytes:b1];
    UInt16 b2 = [self swap:UUID2];
    if (memcmp(b1, (char *)&b2, 2) == 0) return 1;
    else return 0;
}
/*
 *  @method CBUUIDToInt
 *
 *  @param UUID1 UUID 1 to convert
 *
 *  @returns UInt16 representation of the CBUUID
 *
 *  @discussion CBUUIDToInt converts a CBUUID to a Uint16 representation of the UUID
 *
 */
-(UInt16) CBUUIDToInt:(CBUUID *) UUID
{
    //logmethod();
    char b1[16];
    [UUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);
}

/*
 *  @method IntToCBUUID
 *
 *  @param UInt16 representation of a UUID
 *
 *  @return The converted CBUUID
 *
 *  @discussion IntToCBUUID converts a UInt16 UUID to a CBUUID
 *
 */
-(CBUUID *) IntToCBUUID:(UInt16)UUID
{
    //logmethod();
    char t[16];
    t[0] = ((UUID >> 8) & 0xff); t[1] = (UUID & 0xff);
    NSData *data = [[NSData alloc] initWithBytes:t length:16];
    return [CBUUID UUIDWithData:data];
}


/*
 *  @method findServiceFromUUID:
 *
 *  @param UUID CBUUID to find in service list
 *  @param p Peripheral to find service on
 *
 *  @return pointer to CBService if found, nil if not
 *
 *  @discussion findServiceFromUUID searches through the services list of a peripheral to find a 
 *  service with a specific UUID
 *
 */
-(CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p
{

    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil; //Service not found on this peripheral
}

/*
 *  @method findCharacteristicFromUUID:
 *
 *  @param UUID CBUUID to find in Characteristic list of service
 *  @param service Pointer to CBService to search for charateristics on
 *
 *  @return pointer to CBCharacteristic if found, nil if not
 *
 *  @discussion findCharacteristicFromUUID searches through the characteristic list of a given service 
 *  to find a characteristic with a specific UUID
 *
 */
-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service
{
    //logmethod();
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil; //Characteristic not found on this service
}

//----------------------------------------------------------------------------------------------------
//
//
//
//
//CBCentralManagerDelegate protocol methods beneeth here
// Documented in CoreBluetooth documentation
//
//
//
//
//----------------------------------------------------------------------------------------------------




- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    //logmethod();
    printf("Status of CoreBluetooth central manager changed %d (%s)\r\n",central.state,[self centralManagerStateToString:central.state]);
}
/* //JPS rev 1
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    if (!self.peripherals) self.peripherals = [[NSMutableArray alloc] initWithObjects:peripheral,nil];
    else {
        for(int i = 0; i < self.peripherals.count; i++) {
            CBPeripheral *p = [self.peripherals objectAtIndex:i];
            if ([self UUIDSAreEqual:p.UUID u2:peripheral.UUID]) {
                [self.peripherals replaceObjectAtIndex:i withObject:peripheral];
                printf("Duplicate UUID found updating ...\r\n");
                return;
            }
        }
        [self->peripherals addObject:peripheral];
        printf("New UUID, adding\r\n");
    }
     
    printf("didDiscoverPeripheral\r\n");
}
*/
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{

    
    printf("Device found %s \r\n", [peripheral.name UTF8String]);
    if ([peripheral.name rangeOfString:@"L8"/*@"Keyfob"*/].location != NSNotFound) {
        [self connectPeripheral:peripheral];
        self.activePeripheral = peripheral;
        printf("Found a keyfob, connecting..\n");
    } else {
        printf("Peripheral not a keyfob or callback was not because of a ScanResponse\n");
    }

    
    printf("didDiscoverPeripheral\r\n");
}


- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //logmethod();
    printf("Connection to peripheral with UUID : %s successfull\r\n",[self UUIDToString:peripheral.UUID]);
    self.activePeripheral = peripheral;
    
    //JPS BLE: se podria pasar a la funcion un array de CBUUIDs con el ID del servicio del L8 para acortar busqueda de peripherals...
    //NSArray* L8SL_Service = [[NSArray alloc] initWithObjects:L8SL_SPPLE_SERVICE_UUID, nil];
    
    [self.activePeripheral discoverServices:/*L8SL_Service /*/nil];
    
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    printf("Disconnect to peripheral with UUID DISCONECTED : %s successfull\r\n",[self UUIDToString:peripheral.UUID]);
    
    printf("Name : %@ ",peripheral.name);
    

    for(int i=0;i<[self.userPeripherals count];i++){
        if([[[self.userPeripherals objectAtIndex:i] valueForKey:@"identifier"] isEqualToString:[NSString stringWithFormat:@"%s",[self UUIDToString:peripheral.UUID]]])
            [self.userPeripherals removeObjectAtIndex:i];
    }
    
    [self.peripherals removeObject:peripheral];
    [CM cancelPeripheralConnection:activePeripheral];
    
    if([self.userPeripherals count]==0){
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Last_L8_Device_Id"];
//        NSLog(@"Removed device from NSUSERDEFAULTS");
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"L8Disconnected" object:peripheral];
    
}

//----------------------------------------------------------------------------------------------------
//
//
//
//
//
//CBPeripheralDelegate protocol methods beneeth here
//
//
//
//
//
//----------------------------------------------------------------------------------------------------


/*
 *  @method didDiscoverCharacteristicsForService
 *
 *  @param peripheral Pheripheral that got updated
 *  @param service Service that characteristics where found on
 *  @error error Error message if something went wrong
 *
 *  @discussion didDiscoverCharacteristicsForService is called when CoreBluetooth has discovered 
 *  characteristics on a service, on a peripheral after the discoverCharacteristics routine has been called on the service
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    //logmethod();
    if (!error) {
        printf("Characteristics of service with UUID : %s found\r\n",[self CBUUIDToString:service.UUID]);
        for(int i=0; i < service.characteristics.count; i++)
        {
            CBCharacteristic *c = [service.characteristics objectAtIndex:i]; 
            printf("Found characteristic %s\r\n",[ self CBUUIDToString:c.UUID]);
            CBService *s = [peripheral.services objectAtIndex:(peripheral.services.count - 1)];
            if([self compareCBUUID:service.UUID UUID2:s.UUID])
            {
                if (i == (service.characteristics.count - 1))
                {
                    printf("Finished discovering characteristics");
                    [[self delegate] keyfobReady];
                }
            }
        }
    }
    else {
        printf("Characteristic discorvery unsuccessfull !\r\n");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    //logmethod();
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error
{
    //logmethod();
}

/*
 *  @method didDiscoverServices
 *
 *  @param peripheral Pheripheral that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didDiscoverServices is called when CoreBluetooth has discovered services on a 
 *  peripheral after the discoverServices routine has been called on the peripheral
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    //logmethod();
    if (!error) {
        printf("Services of peripheral with UUID : %s found\r\n",[self UUIDToString:peripheral.UUID]);
        [self getAllCharacteristicsFromKeyfob:peripheral];
    }
    else {
        printf("Service discovery was unsuccessfull !\r\n");
    }
}

/*
 *  @method didUpdateNotificationStateForCharacteristic
 *
 *  @param peripheral Pheripheral that got updated
 *  @param characteristic Characteristic that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didUpdateNotificationStateForCharacteristic is called when CoreBluetooth has updated a 
 *  notification state for a characteristic
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    //logmethod();
    if (!error) {
        printf("Updated notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:peripheral.UUID]);
    }
    else {
        printf("Error in setting notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:peripheral.UUID]);
        printf("Error code was %s\r\n",[[error description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    }

}

/*
 *  @method didUpdateValueForCharacteristic
 *
 *  @param peripheral Pheripheral that got updated
 *  @param characteristic Characteristic that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didUpdateValueForCharacteristic is called when CoreBluetooth has updated a 
 *  characteristic for a peripheral. All reads and notifications come here to be processed.
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    //logmethod();
    //UInt16 characteristicUUID = [self CBUUIDToInt:characteristic.UUID];
    //NSString* CharUUID = [[NSString alloc] initWithData:characteristic.UUID.data encoding:NSASCIIStringEncoding];
    
    if (!error) {
        /*
        switch(characteristicUUID){
            case TI_KEYFOB_LEVEL_SERVICE_UUID:
            {
                char batlevel;
                [characteristic.value getBytes:&batlevel length:TI_KEYFOB_LEVEL_SERVICE_READ_LEN];
                self.batteryLevel = (float)batlevel;
                break;
            }
            case TI_KEYFOB_KEYS_NOTIFICATION_UUID:
            {
                char keys;
                [characteristic.value getBytes:&keys length:TI_KEYFOB_KEYS_NOTIFICATION_READ_LEN];
                if (keys & 0x01) self.key1 = YES;
                else self.key1 = NO;
                if (keys & 0x02) self.key2 = YES;
                else self.key2 = NO;
                [[self delegate] keyValuesUpdated: keys];
                break;
            }
            case TI_KEYFOB_ACCEL_X_UUID:
            {
                char xval; 
                [characteristic.value getBytes:&xval length:TI_KEYFOB_ACCEL_READ_LEN];
                self.x = xval;
                [[self delegate] accelerometerValuesUpdated:self.x y:self.y z:self.z];
                break;
            }
            case TI_KEYFOB_ACCEL_Y_UUID:
            {
                char yval; 
                [characteristic.value getBytes:&yval length:TI_KEYFOB_ACCEL_READ_LEN];
                self.y = yval;
                [[self delegate] accelerometerValuesUpdated:self.x y:self.y z:self.z];
                break;
            }
            case TI_KEYFOB_ACCEL_Z_UUID:
            {
                char zval; 
                [characteristic.value getBytes:&zval length:TI_KEYFOB_ACCEL_READ_LEN];
                self.z = zval;
                [[self delegate] accelerometerValuesUpdated:self.x y:self.y z:self.z];
                break;
            }
            case TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_UUID:
            {
                char TXLevel;
                [characteristic.value getBytes:&TXLevel length:TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_READ_LEN];
                self.TXPwrLevel = TXLevel;
                [[self delegate] TXPwrLevelUpdated:TXLevel];
                break;
            }
            //JPS: invokar 
            case CUSTOM_CONFG_PROPERTY_UUID:
            {
                self.Config1 = [characteristic value];
                [[self delegate] configUpdated:self.Config1];
                break;
            }
            case CUSTOM_NOTIFY_PROPERTY_UUID:
            {
                Byte Not;
                [characteristic.value getBytes:&Not length:CUSTOM_NOTIFY_PROPERTY_LEN];
                self.Not1 = Not;
                [[self delegate] notificationRcvd:self.Not1];
                break;
            }
            case CUSTOM_BAT_LVL_PROPERTY_UUID:
            {
                Byte BatLvl;
                [characteristic.value getBytes:&BatLvl length:CUSTOM_BAT_LVL_PROPERTY_LEN];
                self.BatLevel = BatLvl;
                [[self delegate] batteryLevelRcvd:self.BatLevel];
                break;
            }
            //JPS L8SL
            case L8SL_SPPLE_TX_CHARACTERISTIC_UUID:
            {
                //Leer datos recibidos del L8SL...
                [[self delegate] processDataFromPeripheral:characteristic.value];
                break;
            }
        }
         */
//        NSString* TXNotifUUIDStr = [[NSString alloc] initWithBytes:L8SL_SPPLE_TX_CHARACTERISTIC_UUID_BYTES length:16 encoding:NSASCIIStringEncoding];
//        if ([TXNotifUUIDStr isEqualToString:CharUUID])
//        {
            //Leer datos recibidos del L8SL...
        [[self delegate] processDataFromPeripheral:characteristic.value];
       
        
//        }
    }
    else {
        printf("updateValueForCharacteristic failed !");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    //logmethod();
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    //logmethod();
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    //logmethod();
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    //logmethod();
}

@end
