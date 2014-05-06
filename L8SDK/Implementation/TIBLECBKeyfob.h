//
//  TIBLECBKeyfob.h
//  TI-BLE-Demo
//
//  Created by Ole Andreas Torvmark on 10/31/11.
//  Copyright (c) 2011 ST alliance AS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "TIBLECBKeyfobDefines.h"
#import "l8_sdk_objc.h"

@protocol TIBLECBKeyfobDelegate 
@optional
-(void) keyfobReady;
-(void) connectToL8;
@required
-(void) accelerometerValuesUpdated:(char)x y:(char)y z:(char)z;
-(void) keyValuesUpdated:(char)sw;
-(void) TXPwrLevelUpdated:(char)TXPwr;
//JPS para leer configuracion
-(void) configUpdated:(NSData*)config;
-(void) notificationRcvd:(Byte)not1;
-(void) batteryLevelRcvd:(Byte)batLvl;

//JPS L8SL
- (void)processDataFromPeripheral:(NSData*)data;

@end

@interface TIBLECBKeyfob : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate> {
}


@property (nonatomic)   float batteryLevel;
@property (nonatomic)   BOOL key1;
@property (nonatomic)   BOOL key2;
@property (nonatomic)   BOOL connected;
@property (nonatomic)   char x;
@property (nonatomic)   char y;
@property (nonatomic)   char z;
@property (nonatomic)   char TXPwrLevel;

@property (nonatomic)   NSData* Config1;
@property (nonatomic)   Byte Not1;
@property (nonatomic)   Byte BatLevel;


@property (nonatomic,assign) id <TIBLECBKeyfobDelegate> delegate;
@property (strong, nonatomic)  NSMutableArray *peripherals;
@property (strong, nonatomic)  NSMutableArray *userPeripherals;
@property (strong, nonatomic) CBCentralManager *CM; 
@property (strong, nonatomic) CBPeripheral *activePeripheral;
@property (strong, nonatomic) CBPeripheralManager *peripheralManger;

//JPS L8SL ---------------------- INI

-(void) L8SL_SendData:(NSData*)data toL8SL:(CBPeripheral*)p;    //Pide creditos de caracteristica RX y escribe los datos
-(void) L8SL_SendData:(NSData*)data toL8SL:(CBPeripheral*)p withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;
-(void) L8SL_PrepareForReceiveDataFromL8SL:(CBPeripheral *)p;   //Pide creditos de sobra de caracteristica TX y habilita notificación TX

//JPS L8SL ---------------------- FINI

-(void) soundBuzzer:(Byte)buzVal p:(CBPeripheral *)p;
-(void) readBattery:(CBPeripheral *)p;
-(void) enableAccelerometer:(CBPeripheral *)p;
-(void) disableAccelerometer:(CBPeripheral *)p;
-(void) enableButtons:(CBPeripheral *)p;
-(void) disableButtons:(CBPeripheral *)p;
-(void) enableTXPower:(CBPeripheral *)p;
-(void) disableTXPower:(CBPeripheral *)p;
//...
-(void) soundBuzzer:(Byte*)buzVal l:(int)buzValLen p:(CBPeripheral *)p;
-(void) enableLEDs:(Byte)val p:(CBPeripheral *)p;

//Parametros ya listos para enviar (si hay que dividir/mult por 10 ya deben estarlo)
-(void) setConfigOnPeripheral:(CBPeripheral *)p
                   withDayVib:(Byte)dayVib 
                   withDayInt:(Byte)dayInt
                   withDayTmS:(Byte)dayTmS
                 withNightVib:(Byte)nightVib 
                 withNightInt:(Byte)nightInt
                 withNightTmS:(Byte)nightTmS
                 withNightDlM:(Byte)nightDlM
                 withMaskMode:(Byte)maskMode;
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
                 withMaskMode:(Byte)maskMode;
-(void) readConfig:(CBPeripheral *)p;
-(void) enableNotif:(CBPeripheral *)p;
-(void) readBatteryLevel:(CBPeripheral *)p;


-(void) writeValue:(UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID  p:(CBPeripheral *)p data:(NSData *)data;
-(void) writeValue:(UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data withSuccess:(L8VoidOperationHandler)success failure:(L8JSONOperationHandler)failure;
-(void) readValue: (UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID  p:(CBPeripheral *)p;
-(void) notification:(UInt8*)serviceUUID characteristicUUID:(UInt8*)characteristicUUID  p:(CBPeripheral *)p on:(BOOL)on;
//-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p data:(NSData *)data;
//-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p;
//-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p on:(BOOL)on;


-(UInt16) swap:(UInt16) s;
-(int) controlSetup:(int) s;
-(int) findBLEPeripherals:(int) timeout;
-(const char *) centralManagerStateToString:(int)state;
-(void) scanTimer:(NSTimer *)timer;
-(void) printKnownPeripherals;
-(void) printPeripheralInfo:(CBPeripheral*)peripheral;
-(void) connectPeripheral:(CBPeripheral *)peripheral;

-(void) getAllServicesFromKeyfob:(CBPeripheral *)p;
-(void) getAllCharacteristicsFromKeyfob:(CBPeripheral *)p;
-(CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p;
-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service;
-(const char *) UUIDToString:(CFUUIDRef) UUID;
-(const char *) CBUUIDToString:(CBUUID *) UUID;
-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2;
-(int) compareCBUUIDToInt:(CBUUID *) UUID1 UUID2:(UInt16)UUID2;
-(UInt16) CBUUIDToInt:(CBUUID *) UUID;
-(int) UUIDSAreEqual:(CFUUIDRef)u1 u2:(CFUUIDRef)u2;



@end
