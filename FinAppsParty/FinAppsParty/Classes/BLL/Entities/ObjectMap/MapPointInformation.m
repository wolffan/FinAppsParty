//
//  MapPointInformation.m
//  vic
//
//  Created by Valenti on 13/12/10.
//  Copyright 2011 Biapum. All rights reserved.
//

#import "MapPointInformation.h"


@implementation MapPointInformation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize imgNumber;
@synthesize type;
@synthesize comerceEnt;

-init
{
	return self;
}

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
	coordinate = inCoord;
	return self;
}

-(NSString *)getMapPointInformationType{
    return self.type;
}


@end