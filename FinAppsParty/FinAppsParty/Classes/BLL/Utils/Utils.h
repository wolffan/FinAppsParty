//
//  Utils.h
//  iCollina
//
//  Created by Valenti on 08/10/11.
//  Copyright 2011 Biapum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComerceEntity.h"

@interface Utils : NSObject {
    
}

+ (BOOL) isIPad;
+ (BOOL) isIPhone5;
+ (BOOL) isiOS6;
+ (BOOL) deviceCanUseAR;
+ (BOOL) gotInternetConnection;

+ (int) getDeviceOrientation;
+ (void) setDeviceOrientation:(int)orientation;
+ (BOOL) isDeviceLandscape;
+ (BOOL) isDevicePortrait;
//+ (BOOL) isFavorite:(SantoEntity*)santo;

+ (BOOL) existComerce:(ComerceEntity *)com;
@end
