//
//  ProfilePageViewController.h
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#import "JDFlipNumberView.h"
#import "JDGroupedFlipNumberView.h"
#import "JDDateCountdownFlipView.h"

@interface ProfilePageViewController : UIViewController <GKLeaderboardViewControllerDelegate>//GKAchievementViewControllerDelegate
{
    UILabel                 *labelScore;
    JDGroupedFlipNumberView *flipView;
    
    UILabel                 *labelInProgress;
    UILabel                 *labelCompleted;
}

@property (nonatomic,retain) IBOutlet UILabel           *labelScore;
@property (nonatomic,retain) JDGroupedFlipNumberView    *flipView;
@property (nonatomic,retain) IBOutlet UILabel           *labelInProgress;
@property (nonatomic,retain) IBOutlet UILabel           *labelCompleted;

-(IBAction)GoHighScoreNormal:(id)sender;

-(IBAction)pushInfo:(id)sender;
@end
