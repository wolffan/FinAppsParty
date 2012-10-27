//
//  LocService.h
//  VIC
//
//  Created by Valentí on 01/04/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <CoreLocation/CLLocationManagerDelegate.h>

@interface LocService : NSObject<CLLocationManagerDelegate> {
	CLLocation *location;
	NSMutableArray * currentOfficeList;	
	CLLocationManager *locationManager;
	id delegate;
	BOOL enforce;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSMutableArray *currentOfficeList;
@property (nonatomic, retain) id delegate;

// Singleton
+ (LocService *)myLocService;
+ (id)allocWithZone:(NSZone *)zona;
- (id)copyWithZone:(NSZone *)zona;
- (id)retain;
- (id)autorelease;
- (void)release;

// LocService
- (void)setCurrentLocation:(CLLocation *)coordinates;
//- (void)getOfficesInBackground:(id)sender;
//- (void)getOfficesInBackground:(id)sender selector:(SEL)aSelector withLocation:(CLLocation *)aLocation enforce:(BOOL)enableEnforce;
//- (void)getOffices:(id)sender selector:(SEL)selector withLocation:(CLLocation *)aLocation;
//- (void)getOffices4NewLocationInBackground:(id)sender address:(NSString *)address;
//- (void)getOffices4NewLocation:(id)sender selector:(SEL)selector address:(NSString *)address;
//- (BOOL)locationIsValid;
- (void)forceNewLocation:(id)sender;

@end
