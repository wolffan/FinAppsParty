//
//  LocService.m
//  VIC
//
//  Created by Valentí on 01/04/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import "LocService.h"


@implementation LocService
@synthesize location;
@synthesize currentOfficeList;
@synthesize delegate;
@synthesize locationManager;

#pragma mark - 
#pragma mark - Singleton

static LocService* singletonLocService = nil;

+ (LocService*)myLocService
{
	if(singletonLocService==nil)
	{
		LocService *LS = [[self alloc] init]; //TODO : MM Test : I did not tested the changes of this unit on the device.
		
		//CLLocation *loc = [[CLLocation alloc] initWithLatitude:41.420474 longitude:2.176988];
		CLLocation *loc = [[CLLocation alloc] initWithLatitude:0.0 longitude:0.0];
		[LS.locationManager setDelegate:LS];
		[LS setCurrentLocation:loc];
		[loc release];
		[LS setCurrentOfficeList:nil];
		
		LS.locationManager = [[CLLocationManager alloc] init];
		//[LS.locationManager release];
		[LS.locationManager startUpdatingLocation];
		return  LS; //CHG: from my understanding, this line is not necessary.
	}	
    
	return singletonLocService;
}

+ (id)allocWithZone:(NSZone *)zona
{
	@synchronized(self)
	{
		if(singletonLocService==nil)
			return singletonLocService = [super allocWithZone:zona];
	}
	return nil;
}

- (id)copyWithZone:(NSZone *)zona
{
	return self;
}

- (id)retain
{
	return self;
}

- (id)autorelease
{
	return self;
}

- (void)release
{
	// res
}


#pragma mark - 
#pragma mark - LocService

- (void)setCurrentLocation:(CLLocation *)coordinates
{
	@synchronized(self)
	{
        //		printf("latitude %+.6f, longitude %+.6f\n",
        //			   coordinates.coordinate.latitude,
        //			   coordinates.coordinate.longitude);
		
		self.location = [[CLLocation alloc] initWithLatitude:coordinates.coordinate.latitude longitude:coordinates.coordinate.longitude];
		[self.location release];
		
		
		self.locationManager = [[CLLocationManager alloc] init];
		//[LS.locationManager release];
		[self.locationManager startUpdatingLocation];
		
		enforce = YES;
	}
}

/*
 - (void)getOfficesInBackground:(id)sender
 {    
 [self getOfficesInBackground:sender selector:@selector(updateDataWithNewOffices:) withLocation:location enforce:enforce]; 
 }
 
 - (void)getOfficesInBackground:(id)sender selector:(SEL)aSelector withLocation:(CLLocation *)aLocation enforce:(BOOL)enableEnforce
 {
 NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
 
 enforce = enableEnforce;
 [self getOffices:sender selector:aSelector withLocation:aLocation];
 
 [pool release];    
 }
 
 - (void)getOffices:(id)sender selector:(SEL)selector withLocation:(CLLocation *)aLocation
 {
 @synchronized(self)
 {	
 if ([sender isKindOfClass:[RootVC class]]){
 self.delegate = sender;
 }
 
 if((currentOfficeList == nil) || enforce)
 {
 NSString * url = [NSString stringWithFormat:@"%@://%@:%@/%@/loc/searchOffices.jsp?nOffices=5&lat=%f&long=%f&lng=%@&bbrand=%@", [[InvSession instance] getProtocol], [[InvSession instance] getHostName], [[InvSession instance] getPort], [[InvSession instance] getPath],
 aLocation.coordinate.latitude, aLocation.coordinate.longitude,
 [InvSession instance].language, [[InvSession instance] getBrand]];
 
 DLog(@"request: %@", url);
 
 NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] init];
 [postRequest setURL:[NSURL URLWithString:url]];
 
 NSData *responseData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:nil error:nil];
 
 // convert data into string
 NSString *responseString = [[[NSString alloc] initWithBytes:[responseData bytes]
 length:[responseData length]
 encoding:NSUTF8StringEncoding] autorelease];
 
 // see if we get a welcome result
 DLog(@"response inverline: %@", responseString);
 
 self.currentOfficeList = nil;
 self.currentOfficeList = [BancSabadellXMLParser parseOfficeListForLocator:responseString];
 
 enforce = NO;
 }
 
 if([sender respondsToSelector:selector])
 {
 [sender performSelectorOnMainThread:selector withObject:currentOfficeList waitUntilDone:NO];
 }
 else if([delegate respondsToSelector:selector])
 {
 [delegate performSelectorOnMainThread:selector withObject:currentOfficeList waitUntilDone:NO];
 }
 }
 }
 
 - (void)getOffices4NewLocationInBackground:(id)sender address:(NSString *)address
 {
 NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
 
 [self getOffices4NewLocation:sender selector:@selector(updateDataWithNewOffices:) address:address];
 
 [pool release];
 }
 
 - (void)getOffices4NewLocation:(id)sender selector:(SEL)selector address:(NSString *)address
 {
 @synchronized(self)
 {	
 NSString * url = [NSString stringWithFormat:@"%@://%@:%@/%@/loc/geoLocalize.jsp?address=%@", [[InvSession instance] getProtocol], [[InvSession instance] getHostName], [[InvSession instance] getPort], [[InvSession instance] getPath], [address escapeBSParam]];
 
 DLog(@"request: %@", url);
 
 NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] init];
 [postRequest setURL:[NSURL URLWithString:url]];
 
 NSData *responseData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:nil error:nil];
 
 // convert data into string
 NSString *responseString = [[[NSString alloc] initWithBytes:[responseData bytes]
 length:[responseData length]
 encoding:NSUTF8StringEncoding] autorelease];
 
 // see if we get a welcome result
 DLog(@"response inverline: %@", responseString);
 
 NSMutableArray *newLocationsArray = [BancSabadellXMLParser parseStreetListForLocator:responseString];
 
 if([newLocationsArray count] == 0)
 {
 [sender performSelectorOnMainThread:@selector(doesNotResult) withObject:nil waitUntilDone:NO];
 }
 else if([newLocationsArray count] == 1)
 {
 NSDictionary *newLocationDict = [newLocationsArray objectAtIndex:0];
 CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)[[newLocationDict objectForKey:@"lat"] doubleValue] longitude:(CLLocationDegrees)[[newLocationDict objectForKey:@"long"] doubleValue]];
 
 [self setCurrentLocation:newLocation];
 self.currentOfficeList = nil;
 [sender locationFinded];
 [self getOffices:delegate selector:selector withLocation:location];
 }
 else
 {
 if ([sender respondsToSelector:@selector(TooManyResults:)]) {
 [sender performSelectorOnMainThread:@selector(TooManyResults:) withObject:newLocationsArray waitUntilDone:NO];
 }
 }
 }
 }
 */
- (BOOL)locationIsValid
{
	if(location.coordinate.latitude == 0 && location.coordinate.longitude == 0)
		return NO;
	return YES;
}


#pragma mark -
#pragma mark Location Manager

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	locationManager.delegate = nil;
	[locationManager stopUpdatingLocation];
	
	printf("latitude %+.6f, longitude %+.6f\n",
		   newLocation.coordinate.latitude,
		   newLocation.coordinate.longitude);
	
	LocService *myLoc = [LocService myLocService];
	[myLoc setCurrentLocation:newLocation];
	//[myLoc getOfficesInBackground:self];
	
	if (delegate) {
//		[delegate setMapCenter];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"error locatorMan");
}

- (void)forceNewLocation:(id)sender
{
	locationManager.delegate = self; // Tells the location manager to send updates to this object
	[locationManager startUpdatingLocation];
	
//	if ([sender isKindOfClass:[MapaViewController class]])
//		self.delegate = sender;
}

@end
