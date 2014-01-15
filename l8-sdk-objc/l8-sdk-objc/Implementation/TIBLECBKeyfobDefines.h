//
//  TIBLECBKeyfobDefines.h
//  TI-BLE-Demo
//
//  Created by Ole Andreas Torvmark on 10/31/11.
//  Copyright (c) 2011 ST alliance AS. All rights reserved.
//

#ifndef TI_BLE_Demo_TIBLECBKeyfobDefines_h__
#define TI_BLE_Demo_TIBLECBKeyfobDefines_h__

//JPS L8SM ---------------------- INI

    #define L8SL_SPPLE_SERVICE_UUID                         0x3923CF407316429A5c417E7DC49A8314
    #define L8SL_SPPLE_RX_CHARACTERISTIC_UUID               0xA3E1260AEE9AE9BBb0490BEBE7AC008B
    #define L8SL_SPPLE_TX_CHARACTERISTIC_UUID               0x579A054352CDB1A61a4bE7A84A593407
    #define L8SL_SPPLE_RX_CREDITS_CHARACTERISTIC_UUID       0xD44AA1E51A37B19Ec0454A4FFB5E6DE0
    #define L8SL_SPPLE_TX_CREDITS_CHARACTERISTIC_UUID       0x925319F2135D9CB6be432B89B2C404BA

//Service UUID
extern UInt8 L8SL_SPPLE_SERVICE_UUID_BYTES[16]; /*=
{ 0x39, 0x23, 0xCF, 0x40, 0x73, 0x16, 0x42, 0x9A, 0x5c, 0x41, 0x7E, 0x7D, 0xC4, 0x9A, 0x83, 0x14 };*/
//Attributes UUID
extern UInt8 L8SL_SPPLE_RX_CHARACTERISTIC_UUID_BYTES[16];/*=
{ 0xA3, 0xE1, 0x26, 0x0A, 0xEE, 0x9A, 0xE9, 0xBB, 0xb0, 0x49, 0x0B, 0xEB, 0xE7, 0xAC, 0x00, 0x8B };*/
extern UInt8 L8SL_SPPLE_TX_CHARACTERISTIC_UUID_BYTES[16];/*=
{ 0x57, 0x9A, 0x05, 0x43, 0x52, 0xCD, 0xB1, 0xA6, 0x1a, 0x4b, 0xE7, 0xA8, 0x4A, 0x59, 0x34, 0x07 };*/
extern UInt8 L8SL_SPPLE_RX_CREDITS_CHARACTERISTIC_UUID_BYTES[16];/*=
{ 0xD4, 0x4A, 0xA1, 0xE5, 0x1A, 0x37, 0xB1, 0x9E, 0xc0, 0x45, 0x4A, 0x4F, 0xFB, 0x5E, 0x6D, 0xE0 };*/
extern UInt8 L8SL_SPPLE_TX_CREDITS_CHARACTERISTIC_UUID_BYTES[16];/*=
{ 0x92, 0x53, 0x19, 0xF2, 0x13, 0x5D, 0x9C, 0xB6, 0xbe, 0x43, 0x2B, 0x89, 0xB2, 0xC4, 0x04, 0xBA };*/




//JPS L8SM ---------------------- FINI




// Defines for the TI CC2540 keyfob peripheral

extern UInt8 TI_KEYFOB_PROXIMITY_ALERT_UUID [2];
//#define TI_KEYFOB_PROXIMITY_ALERT_UUID                      0xfff0 //0x1802 //0xfff1

#define TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID             0xfff1 //16 bits            vibración (como hasta ahora) Read   //0x2a06

extern UInt8 CUSTOM_BAT_LVL_PROPERTY_UUID [2];
//#define CUSTOM_BAT_LVL_PROPERTY_UUID                        0xfff2 //8 bits             batería (0-100) Read

#define CUSTOM_BAT_LVL_PROPERTY_LEN                         1
#define CUSTOM_LED_PROPERTY_UUID                            0xfff3 //8 bits             leds (como hasta ahora)                       Write

extern UInt8 CUSTOM_NOTIFY_PROPERTY_UUID [2];
//#define CUSTOM_NOTIFY_PROPERTY_UUID                         0xfff4 //8 bits             NOTIFICACIÓN  (activar previamente las notificaciones, como hace el código del iPhone con las teclas)

#define CUSTOM_NOTIFY_PROPERTY_LEN                          1

extern UInt8 CUSTOM_CONFG_PROPERTY_UUID [2];
//#define CUSTOM_CONFG_PROPERTY_UUID                          0xfff5 //8 bytes            configuración Read/Write


#define CUSTOM_CONFG_PROPERTY_LEN                           8
#define CUSTOM_CONFG_PROPERTY_LEN_2                         12


#define TI_KEYFOB_PROXIMITY_ALERT_ON_VAL                    0x01
#define TI_KEYFOB_PROXIMITY_ALERT_OFF_VAL                   0x00
#define TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN                 1

extern UInt8 TI_KEYFOB_PROXIMITY_TX_PWR_SERVICE_UUID [2];
//#define TI_KEYFOB_PROXIMITY_TX_PWR_SERVICE_UUID             0x1804

extern UInt8 TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_UUID [2];
//#define TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_UUID        0x2A07

#define TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_READ_LEN    1

extern UInt8 TI_KEYFOB_BATT_SERVICE_UUID [2];
//#define TI_KEYFOB_BATT_SERVICE_UUID                         0xFFB0

extern UInt8 TI_KEYFOB_LEVEL_SERVICE_UUID [2];
//#define TI_KEYFOB_LEVEL_SERVICE_UUID                        0xFFB1

#define TI_KEYFOB_POWER_STATE_UUID                          0xFFB2
#define TI_KEYFOB_LEVEL_SERVICE_READ_LEN                    1

extern UInt8 TI_KEYFOB_ACCEL_SERVICE_UUID [2];
//#define TI_KEYFOB_ACCEL_SERVICE_UUID                        0xFFA0
#define TI_KEYFOB_ACCEL_ENABLER_UUID                        0xFFA1
#define TI_KEYFOB_ACCEL_RANGE_UUID                          0xFFA2
#define TI_KEYFOB_ACCEL_READ_LEN                            1

extern UInt8 TI_KEYFOB_ACCEL_X_UUID [2];
//#define TI_KEYFOB_ACCEL_X_UUID                              0xFFA3

extern UInt8 TI_KEYFOB_ACCEL_Y_UUID [2];
//#define TI_KEYFOB_ACCEL_Y_UUID                              0xFFA4

extern UInt8 TI_KEYFOB_ACCEL_Z_UUID [2];
//#define TI_KEYFOB_ACCEL_Z_UUID                              0xFFA5

extern UInt8 TI_KEYFOB_KEYS_SERVICE_UUID [2];
//#define TI_KEYFOB_KEYS_SERVICE_UUID                         0xFFE0

extern UInt8 TI_KEYFOB_KEYS_NOTIFICATION_UUID [2];
//#define TI_KEYFOB_KEYS_NOTIFICATION_UUID                    0xFFE1

#define TI_KEYFOB_KEYS_NOTIFICATION_READ_LEN                1

//...
#define CUSTOM_LED_ON                                       1
#define CUSTOM_LED_OFF                                      0

#define CUSTOM_LED_SELECT_R                                 0x01
#define CUSTOM_LED_SELECT_G                                 0x02
#define CUSTOM_LED_SELECT_B                                 0x04

#endif
