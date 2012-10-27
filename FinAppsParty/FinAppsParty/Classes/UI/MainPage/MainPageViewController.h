//
//  MainPageViewController.h
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainPageViewController : UIViewController
{
    MKMapView           *myMapView;
    NSMutableArray      *llocsMapa;
}

@property (nonatomic, retain) IBOutlet MKMapView        *myMapView;
@property (nonatomic, retain) NSMutableArray            *llocsMapa;

-(void)updateMapComerces;
@end
