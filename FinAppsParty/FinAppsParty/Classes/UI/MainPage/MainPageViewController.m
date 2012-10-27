//
//  MainPageViewController.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "MainPageViewController.h"
#import "MapPointInformation.h"
#import "ReadData.h"
#import "ComerceEntity.h"
#import "DetailPageViewController.h"

@interface MainPageViewController ()
- (void) loadLocation;
@end

@implementation MainPageViewController
@synthesize myMapView,llocsMapa;

-(void)dealloc{

    [myMapView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[ReadData instance] setDelegateMap:self];
        [[ReadData instance] searchNewComerces];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar.png"]  forBarMetrics:UIBarMetricsDefault];
    CLLocationCoordinate2D coord = {.latitude=41.4006, .longitude=2.1764};
    
	MKCoordinateSpan span = {.latitudeDelta= 0.0499, .longitudeDelta= 0.0137};
	MKCoordinateRegion region = {coord, span};
	[myMapView setRegion:region animated:TRUE];
	[myMapView regionThatFits:region];
    
    self.navigationController.navigationBar.topItem.title = @"Explorar";

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadLocation];

}

- (void) loadLocation {
    
    NSArray *existingpoints = self.myMapView.annotations;
	
    if ([existingpoints count] > 0)
		[self.myMapView removeAnnotations:existingpoints];
    
    //self.llocsMapa = [[ReadData instance] listMapa];
	for( ComerceEntity *poiEsc in self.llocsMapa) {
        
        MapPointInformation *app1 = [[MapPointInformation alloc] initWithCoordinate:poiEsc.comerceCoordinate];
        [app1 setComerceEnt:poiEsc];
        [app1 setTitle:poiEsc.comerceName];
        [self.myMapView addAnnotation:app1];
        [app1 release];
    }
    
    NSLog(@"------------ %@", self.llocsMapa);
}

-(void)updateMapComerces{
    
    self.llocsMapa = [[ReadData instance] arrayComerce];
    [self loadLocation];
    NSLog(@"updateMapComerces");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark mapKit

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // try to dequeue an existing pin view first
    static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)
    [mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
    if (!pinView)
    {
        // if an existing pin view was not available, create one
        MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                               initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
        customPinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        

        ComerceEntity *c = [(MapPointInformation*)annotation comerceEnt];
        NSLog(@"%@",c.comerceName);
        if(c.isCompleted){
            customPinView.pinColor = MKPinAnnotationColorPurple;
        }else if(c.isUnlocked){
            customPinView.pinColor = MKPinAnnotationColorGreen;
        }else{
            customPinView.pinColor = MKPinAnnotationColorRed;
        }

        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        return customPinView;
    }
    else
    {
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.canShowCallout =YES;
        pinView.annotation = annotation;
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    DetailPageViewController *vc = [[DetailPageViewController alloc] initWithNibName:@"DetailPageViewController" bundle:nil andPoint:[(MapPointInformation*)view.annotation comerceEnt]];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
//    [self goToRoute:[(MapPointInformation*)view.annotation escenari]];
}


@end
