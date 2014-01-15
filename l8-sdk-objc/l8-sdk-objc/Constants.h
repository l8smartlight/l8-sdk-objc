//
//  Constants.h
//  bootstrap-ios
//
//  Created by Marcos Pinazo on 2/1/13.
//  Copyright (c) 2013 [WE ARE] DEVELAPPERS. All rights reserved.
//

#ifndef bootstrap_Constants_h
#define bootstrap_Constants_h

#import "CommonUtil.h"

#define APP_NAME @"l8-client-ios"

/*** ENTORNO DE EJECUCIÓN ***/
//#define DEVELOPMENT
#define PREPRODUCTION
//#define PRODUCTION
/****************************/

// URL de la API:
// TODO: Definir la URL de la API de esta aplicación (si procede, si no eliminar todo el código relativo a API).
#define API_VERSION @""

#ifdef DEVELOPMENT
#define API_BASE_URL @"http://l8.develappers.es/"//@"http://l8pre.develappers.es/"
#define URL_THUMBNAILS @"http://l8.develappers.es/l8-server-api/frames/"
#define API_CLIENT_ID @"dev"
#define API_CLIENT_SECRET @"UNSECURE"
#define DEVELOPMENT_SIM
#endif

#ifdef PREPRODUCTION
#define API_BASE_URL @"http://l8pre.develappers.es/"//@"http://l8pre.develappers.es/"
#define URL_THUMBNAILS @"http://l8pre.develappers.es/l8-server-api/frames/"
#define API_CLIENT_ID @"dev"
#define API_CLIENT_SECRET @"UNSECURE"
#define PREPRODUCTION_SIM
#endif

#ifdef PRODUCTION
#define API_BASE_URL @"http://l8pre.develappers.es/"
#define URL_THUMBNAILS @"http://l8pre.develappers.es/l8-server-api/frames/"
#define API_CLIENT_ID @"dev"
#define API_CLIENT_SECRET @"UNSECURE"
#define PRODUCTION_SIM
#endif

// Google Analytics ID:
#define GAID @"UA-XXXXXX-X" // TODO: Definir el Google ID para esta aplicación.

// Trazas:
//#define LOG_VERBOSE
//#define LOG_SQLITE
#define LOG_API

// TODO: Definir si esta aplicación tiene usuarios, si no borrar.
#define SETTINGS_TOKEN @"SETTINGS_TOKEN"

#define KAlertBackgroundColor [UIColor colorWithRed:0.992 green:0.961 blue:0.989 alpha:1.000]

#endif
