//
//  ComerceEntity.h
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ComerceEntity : NSObject <NSCopying>
{
    NSString                *comerceId;
    NSString                *comerceName;
    
    NSString                *comerceStreet;
    NSString                *comerceNumber;
    NSString                *comerceCity;
    NSString                *comercePostalCode;
    NSString                *comerceCountry;
    
    CLLocationCoordinate2D  comerceCoordinate;
    id                      delegateMap;
    
    BOOL                    isUnlocked;
    BOOL                    doneTwitter;
    BOOL                    doneFb;
    BOOL                    doneInstagram;
    BOOL                    doneFoursquare;
    BOOL                    isCompleted;
}

@property (nonatomic, retain) NSString                *comerceId;
@property (nonatomic, retain) NSString                *comerceName;

@property (nonatomic, retain) NSString                *comerceStreet;
@property (nonatomic, retain) NSString                *comerceNumber;
@property (nonatomic, retain) NSString                *comerceCity;
@property (nonatomic, retain) NSString                *comercePostalCode;
@property (nonatomic, retain) NSString                *comerceCountry;
@property (nonatomic, assign) id                       delegateMap;

@property (nonatomic, assign) BOOL                    isUnlocked;
@property (nonatomic, assign) BOOL                    doneTwitter;
@property (nonatomic, assign) BOOL                    doneFb;
@property (nonatomic, assign) BOOL                    doneInstagram;
@property (nonatomic, assign) BOOL                    doneFoursquare;
@property (nonatomic, assign) BOOL                    isCompleted;

@property (nonatomic, assign) CLLocationCoordinate2D    comerceCoordinate;

- (id)initWithID:(NSString *)stringId andDel:(id)del_;
- (void)parsePoint:(NSDictionary *)feed;

- (BOOL)isComerceCompleted;
- (int)getPercent;
@end
