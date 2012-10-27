//
//  MapPointInformation.h
//  vic
//
//  Created by Valenti on 13/12/10.
//  Copyright 2011 Biapum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ComerceEntity.h"


@interface MapPointInformation : NSObject <MKAnnotation>{
	CLLocationCoordinate2D  coordinate;
	NSString                *title;
	NSString                *subtitle;
	NSNumber                *imgNumber;
    NSString                *type;
    ComerceEntity           *comerceEnt;
}

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString                *title;
@property (nonatomic, copy) NSString                *subtitle;
@property (nonatomic, copy) NSNumber                *imgNumber;
@property (nonatomic, copy) NSString                *type;
@property (nonatomic, retain) ComerceEntity         *comerceEnt;

-(NSString *)getMapPointInformationType;
-initWithCoordinate:(CLLocationCoordinate2D)inCoord;
@end
