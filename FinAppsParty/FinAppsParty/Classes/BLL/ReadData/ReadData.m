//
//  ReadData.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "ReadData.h"
#import "AFNetworking.h"
#import "SBJSON.h"
#import "ComerceEntity.h"
#import "MainPageViewController.h"

@implementation ReadData
@synthesize arrayComerce,arrayComerceUnlocked;
@synthesize delegateMap;
@synthesize score;

#pragma mark -
#pragma mark Singleton methods

static ReadData *myInstance = nil;

+(ReadData*)instance
{
	if( myInstance == nil ) {
        myInstance = [[super allocWithZone:NULL] init];
        myInstance.arrayComerce = [[[NSMutableArray alloc] init] autorelease];
        myInstance.arrayComerceUnlocked = [[[NSMutableArray alloc] init] autorelease];
        myInstance.score = 0;
    }
    return myInstance;
}

- (void)dealloc {
    // [super dealloc];
}

+ (id)allocWithZone:(NSZone *)zone {
	return [[self instance] retain];
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

- (id)retain {
	return self;
}

- (NSUInteger)retainCount {
	return NSUIntegerMax;
}

- (void)relase {
	// do nothing
}

- (id)autorelease {
	return self;
}
- (void)add20{
    self.score = self.score+20;
}

- (int) getNumberNotCompleted{
    int i =0;
    for(ComerceEntity *c in self.arrayComerceUnlocked){
        if(c.isUnlocked && !c.isCompleted){
            i = i+1;
        }
    }
    return i;
}

- (int) getNumberCompleted{
    int i =0;
    for(ComerceEntity *c in self.arrayComerceUnlocked){
        if(c.isCompleted){
            i = i+1;
        }
    }
    return i;

}


#pragma mark - SearchComerces
-(void)searchNewComerces{
    //http://finappsapi.bdigital.org/api/2012/
    // 424f179474
    //  /commerce/search/near?lat=<DOUBLE>&lng=<DOUBLE>&radius=<INT>
    //http://finappsapi.bdigital.org/api/2012/424f179474/commerce/search/near?lat=<DOUBLE>&lng=<DOUBLE>&radius=<INT>
    
    NSURL *url = [NSURL URLWithString:@"http://finappsapi.bdigital.org/api/2012/8036f6f067/fd0-9e2e-902df22cc4f2/operations/commerce/search/near?lat=41.40749&lng=2.197302&radius=0.5"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:request
                                                                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                
                                                                                SBJSON *parser = [[SBJSON alloc] init];
                                                                                NSString *json= [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                                                NSDictionary *responseJSON = [parser objectWithString:json error:nil];
                                                                                [json release];
                                                                                [parser release];
                                                                                NSLog(@"%@",responseJSON);
                                                                                //
                                                                                if([@"OK" isEqualToString:[responseJSON objectForKey:@"status"]]){
                                                                                    
                                                                                    for (NSString *ident in [responseJSON objectForKey:@"data"]) {
                                                                                        NSLog(@"id es:%@",ident);
                                                                                        
                                                                                        ComerceEntity *c= [[ComerceEntity alloc] initWithID:ident andDel:delegateMap];
                                                                                        [self.arrayComerce addObject:c];
                                                                                        NSLog(@"Fi de parse!!!!!!!!!!!");
                                                                                        [c release];
                                                                                    }
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

@end
