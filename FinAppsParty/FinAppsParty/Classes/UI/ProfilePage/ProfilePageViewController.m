//
//  ProfilePageViewController.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "ProfilePageViewController.h"
#import <GameKit/GameKit.h>
#import "ReadData.h"
#import "InfoPageViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface ProfilePageViewController ()

@end

@implementation ProfilePageViewController
@synthesize labelScore;
@synthesize flipView;
@synthesize labelCompleted,labelInProgress;

- (void)showMultipleDigits;
{
    self.flipView = [[JDGroupedFlipNumberView alloc] initWithFlipNumberViewCount:7];
    flipView.intValue = [[ReadData instance] score];
    flipView.tag = 99;
    [self.view addSubview: flipView];
    
}

-(void)dealloc{
    [labelCompleted release];
    [labelInProgress release];
    [flipView release];
    [labelScore release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar.png"]  forBarMetrics:UIBarMetricsDefault];
    //[self showMultipleDigits];
    
        self.navigationController.navigationBar.topItem.title = @"Perfil";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.labelScore setText:[NSString stringWithFormat:@"%i",[[ReadData instance] score]]];
    [self.labelInProgress setText:[NSString stringWithFormat:@"%i",[[ReadData instance] getNumberNotCompleted]]];
    [self.labelCompleted setText:[NSString stringWithFormat:@"%i",[[ReadData instance] getNumberCompleted]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)GoHighScoreNormal:(id)sender{
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.category = @"RankingFinApps";
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)pushInfo:(id)sender{
    InfoPageViewController *vc = [[InfoPageViewController alloc] initWithNibName:@"InfoPageViewController" bundle:nil andText:@"Aquests punts són descanviables per punts estrella de 'La Caixa'.\n\nEls punts estrella et permeten obtenir regals de tot tipus.\n\nMés informació a www.lacaixa.es"];
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideRightLeft];
    [vc release];

}

@end
