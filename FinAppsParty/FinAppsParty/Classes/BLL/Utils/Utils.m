//
//  Utils.m
//  iCollina
//
//  Created by Valenti on 08/10/11.
//  Copyright 2011 Biapum. All rights reserved.
//

#import "Utils.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "ReadData.h"

@implementation Utils

+ (BOOL) isIPad{
    if( (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)){
        return YES;
    }else{
        return NO;
    }
    return NO;
}

+ (BOOL) isIPhone5{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        if ([UIScreen mainScreen].scale == 2.0f) {
            
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 1136){
                return YES;
            }
        }
    }
    return NO;
}

+ (BOOL)isiOS6{
    if([[[UIDevice currentDevice] systemVersion] intValue]>=6)
        return YES;
    return NO;
    
}

+ (BOOL)deviceCanUseAR {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return YES;
    }
    else{
        return NO;
    }
    
}

#pragma mark -
#pragma mark checkInternetConnection
/*
 use : see checkInternetConnection in ContactViewController for an example
 */
+ (BOOL) gotInternetConnection{
    Reachability* internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    //BOOL connectionRequired = [internetReach connectionRequired];
    //NSString* statusString= @"";
    BOOL results = NO;
    switch (netStatus)
    {
        case NotReachable:
        {
            results = NO;
            //statusString = @"Access Not Available";
            //connectionRequired= NO;  
            break;
        }
            
        case ReachableViaWWAN:
        {
            results = YES;
            //statusString = @"Reachable WWAN";
            break;
        }
        case ReachableViaWiFi:
        {
            results = YES;
            //statusString= @"Reachable WiFi";
            break;
        }
    }
    return results;
}

#pragma mark -
#pragma mark Device orientation

// Device orientation
static int deviceOrientation = UIDeviceOrientationPortrait;

+ (int) getDeviceOrientation {
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	if ((orientation) &&
		( //filter the orientation we want.
		 // one of the reason to exist of this filter : 
		 // the condition (UIDeviceOrientationIsPortrait([Utils getDeviceOrientation])||
	     //               (UIDeviceOrientationIsLandscape([Utils getDeviceOrientation])
		 // is NOT true on start up of the application.
		 // an other reason : we do't care/want the faceup/down/unknow orientation.
		 
		 (orientation == UIDeviceOrientationPortrait) ||
		 (orientation == UIDeviceOrientationPortraitUpsideDown) ||
		 (orientation == UIDeviceOrientationLandscapeLeft) ||
		 (orientation == UIDeviceOrientationLandscapeRight)
		 )
		) {
		deviceOrientation = orientation;
	}
	return deviceOrientation;
}

+ (void) setDeviceOrientation:(int)orientation {
	deviceOrientation = orientation;
}

+ (BOOL) isDeviceLandscape {
    
    return UIDeviceOrientationIsLandscape([Utils getDeviceOrientation]);
}

+ (BOOL) isDevicePortrait {
    
    return UIDeviceOrientationIsPortrait([Utils getDeviceOrientation]);    
}

//+ (BOOL) isFavorite:(SantoEntity*)santo{
//    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    for (SantoEntity *c in delegate.arrayFavorites) {
//        if([c.idSanto isEqualToString:santo.idSanto]){
//            return YES;
//        }
//    }
//    return NO;
//}

+ (BOOL) existComerce:(ComerceEntity *)com{

    for (ComerceEntity *c in [[ReadData instance] arrayComerceUnlocked]){
        NSLog(@"c.comerceId: %@",c.comerceId);
        NSLog(@"com.comerceId: %@",com.comerceId);
        if([c.comerceId isEqualToString:com.comerceId]){
            com = c;
            return YES;
        }
    }
    return NO;
}

@end
