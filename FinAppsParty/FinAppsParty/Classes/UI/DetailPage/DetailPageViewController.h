//
//  DetailPageViewController.h
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComerceEntity.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "Social/Social.h"
#import "GameKit/GameKit.h"

#import "JDFlipNumberView.h"
#import "JDGroupedFlipNumberView.h"
#import "JDDateCountdownFlipView.h"

@interface DetailPageViewController : UIViewController
{
    ComerceEntity   *comDet;
    
    UIImageView     *imagePointPos;
    
    UIButton        *buttonFb;
    UIButton        *buttonTw;
    UIButton        *buttonInst;
    UIButton        *buttonFq;
    
    UILabel         *labelCompleted;
    
    UILabel         *labelScore;
    
    UIImageView     *medalla;
    
    JDGroupedFlipNumberView *flipView;
}

@property (nonatomic,retain) JDGroupedFlipNumberView    *flipView;

@property (nonatomic,retain) ComerceEntity              *comDet;

@property (nonatomic,retain) IBOutlet UIImageView       *imagePointPos;
@property (nonatomic,retain) IBOutlet UIButton          *buttonFb;
@property (nonatomic,retain) IBOutlet UIButton          *buttonTw;
@property (nonatomic,retain) IBOutlet UIButton          *buttonInst;
@property (nonatomic,retain) IBOutlet UIButton          *buttonFq;
@property (nonatomic,retain) IBOutlet UILabel           *labelCompleted;
@property (nonatomic,retain) IBOutlet UILabel           *labelScore;

@property (nonatomic,retain) IBOutlet UIImageView       *medalla;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPoint:(ComerceEntity *)comPoint;

-(IBAction)pushFacebook:(id)sender;
-(IBAction)pushTwitter:(id)sender;
-(IBAction)pushFoursquare:(id)sender;
-(IBAction)pushInstagram:(id)sender;


@end
