//
//  ComerceEntity.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "ComerceEntity.h"
#import "AFNetworking.h"
#import "SBJSON.h"
#import "MainPageViewController.h"
#import "Utils.h"

@interface ComerceEntity()
- (NSString *)setValue:(NSString*)value forKey:(NSString*)key;
- (void)copyPointEntity:(ComerceEntity *)comercePoint;
- (void)parsePointByID:(NSString*)stringId;
- (void)parseAddress:(NSDictionary *)feed;
@end

@implementation ComerceEntity
@synthesize comerceId,comerceName,comerceCoordinate;

@synthesize comerceStreet,comerceNumber,comerceCity,comercePostalCode,comerceCountry;
@synthesize delegateMap;

@synthesize  doneTwitter,doneFb;
@synthesize  doneInstagram,doneFoursquare;
@synthesize  isUnlocked,isCompleted;

-(void)dealloc{
    [comerceId release];
    [comerceName release];
    [comerceStreet release];
    [comerceNumber release];
    [comerceCity release];
    [comercePostalCode release];
    [comerceCountry release];
    [super dealloc];
}

- (id)initWithID:(NSString *)stringId andDel:(id)del_{

    if ((self = [super init])) {
        self.delegateMap = del_;
        self.comerceId=stringId;

        if(![Utils existComerce:self]){
            [self parsePointByID:stringId];
        }
        
        
        
        //[self parsePoint:stringId];
    }
    
    return self;
}


-(void)parsePointByID:(NSString*)stringId{
    NSLog(@"parsePointByID %@",stringId);
    
    NSString *urlString = [NSString stringWithFormat:@"http://finappsapi.bdigital.org/api/2012/8036f6f067/fd0-9e2e-902df22cc4f2/operations/commerce/%@",stringId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:request
                                                                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                
                                                                                SBJSON *parser = [[SBJSON alloc] init];
                                                                                NSString *json= [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                                                NSDictionary *responseJSON = [parser objectWithString:json error:nil];
                                                                                [json release];
                                                                                [parser release];
                                                                                //
                                                                                if([@"OK" isEqualToString:[responseJSON objectForKey:@"status"]]){
                                                                                    self.comerceName = [[responseJSON objectForKey:@"data"] objectForKey:@"publicName"];
                                                                                    
//                                                                                    if([[responseJSON objectForKey:@"data"] objectForKey:@"address"]==nil){
//                                                                                        NSLog(@"niiiiiiiiiiil");
//                                                                                    }else{
//                                                                                        [self parseAddress:[[responseJSON objectForKey:@"data"] objectForKey:@"address"]];
//                                                                                    }         
                                                                                    comerceCoordinate.longitude = [[[[responseJSON objectForKey:@"data"] objectForKey:@"location"] objectAtIndex:1] doubleValue];
                                                                                    
                                                                                    comerceCoordinate.latitude = [[[[responseJSON objectForKey:@"data"] objectForKey:@"location"] objectAtIndex:0] doubleValue];
                                                                                }
                                                                                
                                                                                if (delegateMap && [delegateMap respondsToSelector:@selector(updateMapComerces)]) {
                                                                                    [(MainPageViewController *)delegateMap updateMapComerces];
                                                                                }
                                                                            }
                                                                            failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                                                                NSLog(@"Error server finAppsParty: %@", error);
                                                                                
                                                                            }];
    [httpClient enqueueHTTPRequestOperation:operation];
    [httpClient release];
    [request release];

    
}

-(void)parseAddress:(NSDictionary *)feed {
    if([[feed allKeys] count] == 0) return;
	NSEnumerator *enumerator = [feed keyEnumerator];
	id aKey = nil;
	NSLog(@"--->>>> %@",self.comerceId);
    NSLog(@"feed es: %@",feed);
	while ( (aKey = [enumerator nextObject]) != nil) {
		NSString *value = (NSString *)[feed objectForKey:aKey];
        if ([aKey isEqualToString:@"street"])
        {
            self.comerceStreet = [self setValue:value forKey:aKey];
        }
        else if ([aKey isEqualToString:@"number"])
        {
            self.comerceNumber = [self setValue:value forKey:aKey];
        }
        else if ([aKey isEqualToString:@"city"])
        {
            self.comerceCity = [self setValue:value forKey:aKey];
        }
        else if ([aKey isEqualToString:@"postalCode"])
        {
            self.comercePostalCode = [self setValue:value forKey:aKey];
        }
        else if ([aKey isEqualToString:@"country"])
        {
            self.comerceCountry = [self setValue:value forKey:aKey];
        }
    }
}



-(void)parsePoint:(NSDictionary *)feed {
    if([[feed allKeys] count] == 0) return;
    
	NSEnumerator *enumerator = [feed keyEnumerator];
	id aKey = nil;
	
	while ( (aKey = [enumerator nextObject]) != nil) {
//		NSString *value = (NSString *)[feed objectForKey:aKey];
//        if ([aKey isEqualToString:@"id"])
//        {
//            self.comerceId = [self setValue:value forKey:aKey];
//        }
//        else if ([aKey isEqualToString:@"latitud"])
//        {
//            coordinate.latitude = [[self setValue:value forKey:aKey] doubleValue];
//        }
//        else if ([aKey isEqualToString:@"longitud"])
//        {
//            coordinate.longitude = [[self setValue:value forKey:aKey] doubleValue];
//        }
//        else if ([aKey isEqualToString:@"idEscenari"])
//        {
//            self.idEscenari = [self setValue:value forKey:aKey];
//        }
    }
}

- (NSString *)setValue:(NSString*)value forKey:(NSString*)key {
    if(![[NSString stringWithFormat:@"%@", value] isEqualToString:@"<null>"])
        return [NSString stringWithFormat:@"%@",value];
    else
        return @"";
}

#pragma mark -
#pragma mark Copy Entity

- (id)copyWithZone:(NSZone *)zone
{
    ComerceEntity *comerceCopy = [[ComerceEntity allocWithZone:zone] init];
    
    [comerceCopy copyPointEntity:self];
    return comerceCopy;
}

- (void)copyPointEntity:(ComerceEntity *)com
{
    self.comerceId = com.comerceId;
    self.comerceName = com.comerceName;
    self.comerceStreet = com.comerceStreet;
    self.comerceNumber = com.comerceNumber;
    self.comerceCity = com.comerceCity;
    self.comercePostalCode = com.comercePostalCode;
    self.comerceCountry = com.comerceCountry;
    self.comerceCoordinate = com.comerceCoordinate;
    self.isUnlocked = com.isUnlocked;
    self.doneTwitter = com.doneTwitter;
    self.doneFb = com.doneFb;
    self.doneInstagram  = com.doneInstagram;
    self.doneFoursquare = com.doneFoursquare;
    self.isCompleted = com.isCompleted;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.comerceId forKey:@"comerceId"];
    [encoder encodeObject:self.comerceName forKey:@"comerceName"];
    [encoder encodeObject:self.comerceStreet forKey:@"comerceStreet"];
    [encoder encodeObject:self.comerceNumber forKey:@"comerceNumber"];
    [encoder encodeObject:self.comerceCity forKey:@"comerceCity"];
    [encoder encodeObject:self.comercePostalCode forKey:@"comercePostalCode"];
    [encoder encodeObject:self.comerceCountry forKey:@"comerceCountry"];

    [encoder encodeDouble:self.comerceCoordinate.latitude forKey:@"latitude"];
    [encoder encodeDouble:self.comerceCoordinate.longitude forKey:@"longitude"];
    
    [encoder encodeBool:self.isUnlocked forKey:@"isUnlocked"];
    [encoder encodeBool:self.doneTwitter forKey:@"doneTwitter"];
    [encoder encodeBool:self.doneFb forKey:@"doneFb"];
    [encoder encodeBool:self.doneInstagram forKey:@"doneInstagram"];
    [encoder encodeBool:self.doneFoursquare forKey:@"doneFoursquare"];
    [encoder encodeBool:self.isCompleted forKey:@"isCompleted"];
}


- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        //decode properties, other class vars
        self.comerceId = [decoder decodeObjectForKey:@"comerceId"];
        self.comerceName = [decoder decodeObjectForKey:@"comerceName"];
        self.comerceStreet = [decoder decodeObjectForKey:@"comerceStreet"];
        self.comerceNumber = [decoder decodeObjectForKey:@"comerceNumber"];
        self.comerceCity = [decoder decodeObjectForKey:@"comerceCity"];
        self.comercePostalCode = [decoder decodeObjectForKey:@"comercePostalCode"];
        self.comerceCountry = [decoder decodeObjectForKey:@"comerceCountry"];
        
        float lat, long1;
        lat=[decoder decodeDoubleForKey:@"latitude"];
        long1=[decoder decodeDoubleForKey:@"longitude"];
        
        CLLocationCoordinate2D new_coordinate = { lat, long1 };
        self.comerceCoordinate=new_coordinate;
        
        self.isUnlocked = [decoder decodeBoolForKey:@"isUnlocked"];
        self.doneTwitter = [decoder decodeBoolForKey:@"doneTwitter"];
        self.doneFb = [decoder decodeBoolForKey:@"doneFb"];
        self.doneInstagram = [decoder decodeBoolForKey:@"doneInstagram"];
        self.doneFoursquare = [decoder decodeBoolForKey:@"doneFoursquare"];
        self.isCompleted = [decoder decodeBoolForKey:@"isCompleted"];
    }
    return self;
}

- (BOOL)isComerceCompleted{

    if(self.doneFb && self.doneTwitter && self.doneInstagram && self.doneInstagram){
        self.isCompleted = YES;
        return YES;
    }
    return NO;
}

- (int)getPercent{
    int completed = 20;
    if(self.doneTwitter){
        completed = completed+20;
    }
    if(self.doneFb){
        completed = completed+20;
    }
    if(self.doneFoursquare){
        completed = completed+20;
    }
    if(self.doneInstagram){
        completed = completed+20;
    }
    return completed;
}

@end
