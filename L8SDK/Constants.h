//
//  Constants.h
//  bootstrap-ios
//
//  Created by Marcos Pinazo on 3/11/13.
//  Copyright (c) 2013 [WE ARE] DEVELAPPERS. All rights reserved.
//
//  Modified by Alberto Munoz Fuertes on 28/2/14.
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
#define API_BASE_URL @"http://devserver.L8smartlight.com/"//@"http://l8pre.develappers.es/"
#define URL_THUMBNAILS @"http://devserver.L8smartlight.com/l8-server-api/frames/"
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

#define leftWidth 190.0f
#define squareMovement 165.0f
#define menuFontSize 15.0f

//Define L8Apps Modes
#define SLEEP_MODE_NOTIFICATION @"SLEEP_MODE_NOTIFICATION"
#define SLEEP_MODE @"SLEEP_MODE"
#define SLEEP_MODE_ACTION @"#0b8801-#0b8801-#0b8801-#00ff00-#00ff00-#00ff00-#cccccc-#cccccc-#0b8801-#0b8801-#00ff00-#00ff00-#00ff00-#cccccc-#cccccc-#cccccc-#0b8801-#00ff00-#00ff00-#00ff00-#cccccc-#cccccc-#cccccc-#ff8800-#00ff00-#00ff00-#00ff00-#cccccc-#cccccc-#cccccc-#cccccc-#ff8200-#00ff00-#00ff00-#cccccc-#cccccc-#cccccc-#cccccc-#ff8200-#ff8200-#00ff00-#00ff00-#cccccc-#cccccc-#cccccc-#ff8200-#ff8200-#995405-#00ff00-#cccccc-#cccccc-#cccccc-#ff8200-#ff8200-#995405-#995405-#00ff00-#cccccc-#cccccc-#ff8200-#ff8200-#995405-#995405-#995405-#000000"
#define SLEEP_MODE_ACTION_2 @"#ff0000-#000000-#ff0000-#000000-#00ff00-#ff8800-#ff8800-#ff8800-#ff0000-#ff0000-#ff0000-#000000-#000000-#ff8800-#000000-#ff8800-#ff0000-#000000-#ff0000-#000000-#00ff00-#ff8800-#ff8800-#ff8800-#ff0000-#000000-#ff0000-#000000-#00ff00-#000000-#000000-#ff8800-#000000-#000000-#000000-#0000ff-#0000ff-#0000ff-#ff8800-#ff8800-#8800ff-#000000-#8800ff-#0000ff-#000000-#0000ff-#000000-#ffff00-#8800ff-#000000-#8800ff-#0000ff-#0000ff-#000000-#000000-#ffff00-#8800ff-#8800ff-#8800ff-#0000ff-#0000ff-#0000ff-#000000-#ffff00-#ffffff"

#define SLEEP_MODE_DICTIONARY @"[{id:'25288',type:'2',created:'2012-07-3000:37:14',web_id:'5015d73ad1ec8',web_thumbnail_dir:'1207',title:'IrelandFlag',author_name:'',author_facebook_id:'',views:'1570',facebook_likes:'0',frames:[{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'},{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'},{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'},{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'},{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'},{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'},{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'},{duration:'100',image:'#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#00ff00-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#00ff00-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#00ff00-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#00ff00-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ffffff-#ffffff-#ffffff-#ff8800-#ff8800-#ff8800-#ff8800-#ff8800-#00ff00'}],tags:['FLAG','COUNTRY','IRELAND','TRI','NEWRY']}]"

#endif

