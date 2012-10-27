//
//  ReadData.h
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadData : NSObject
{
    int             score;
    NSMutableArray  *arrayComerce;
    id              delegateMap;
    
    NSMutableArray  *arrayComerceUnlocked;
}

@property (nonatomic,assign) int            score;
@property (nonatomic,retain) NSMutableArray *arrayComerce;
@property (nonatomic,retain) NSMutableArray *arrayComerceUnlocked;

@property (nonatomic,assign) id             delegateMap;

+ (ReadData *) instance;
- (void)searchNewComerces;
- (void)add20;

- (int) getNumberNotCompleted;
- (int) getNumberCompleted;

@end
