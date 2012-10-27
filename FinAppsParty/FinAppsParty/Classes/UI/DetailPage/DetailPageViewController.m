//
//  DetailPageViewController.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "DetailPageViewController.h"
#import "ComerceEntity.h"
#import "ReadData.h"
#import <GameKit/GameKit.h>
#import "GKAchievementHandler.h"

#import "JDFlipNumberView.h"
#import "JDGroupedFlipNumberView.h"
#import "JDDateCountdownFlipView.h"

@interface DetailPageViewController ()
- (void)slideViewArrow:(UIView *)viewArrow withDistance:(CGFloat)distance andDelay:(float)delay;
- (void)makeUnlockedAnim:(UIView *)viewArrow;

- (void)makeMedallaAnim:(UIView *)viewArrow;
@end

@implementation DetailPageViewController
@synthesize comDet;

@synthesize imagePointPos,buttonFb,buttonTw,buttonInst,buttonFq;
@synthesize labelCompleted,labelScore;
@synthesize medalla,flipView;

- (void)showMultipleDigits;
{
    self.flipView = [[JDGroupedFlipNumberView alloc] initWithFlipNumberViewCount:7];
    flipView.intValue = [[ReadData instance] score];
    flipView.tag = 99;
    [self.view addSubview: flipView];

}

- (void)dealloc{
    [medalla release];
    [labelScore release];
    [labelCompleted release];
    [imagePointPos release];
    [buttonFb release];
    [buttonTw release];
    [buttonInst release];
    [buttonFq release];
    [comDet release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPoint:(ComerceEntity *)comPoint;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.comDet = comPoint;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.comDet.comerceName;
    [self.medalla setHidden:YES];
    
    if(!self.comDet.isUnlocked){
        [self.comDet setIsUnlocked:YES];
        [[ReadData instance] add20];
        [flipView animateToValue:[[ReadData instance] score] withDuration:3];
        [self reportScore:[ReadData instance].score forCategory:@"RankingFinApps"];

        [[ReadData instance].arrayComerceUnlocked addObject:self.comDet];
    }
    
    [self showMultipleDigits];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self makeUnlockedAnim:self.imagePointPos];
    
    int dist =0;
    if(self.comDet.doneTwitter){
        dist = dist+65;
    }
    if(self.comDet.doneFb){
        dist = dist+65;
    }
    if(self.comDet.doneFoursquare){
        dist = dist+65;
    }
    if(self.comDet.doneInstagram){
        dist = dist+65;
    }
    
    [self slideViewArrow:self.imagePointPos withDistance:dist andDelay:0];
}

- (void)viewWillAppear:(BOOL)animated{
    int completed = 20;
    
    if(self.comDet.doneTwitter){
       [self.buttonTw setHidden:YES];
        completed = completed+20;
    }
    if(self.comDet.doneFb){
        [self.buttonFb setHidden:YES];
        completed = completed+20;
    }
    if(self.comDet.doneFoursquare){
        [self.buttonFq setHidden:YES];
        completed = completed+20;
    }
    if(self.comDet.doneInstagram){
        [self.buttonInst setHidden:YES];
        completed = completed+20;
    }
    
    NSString *prc = @"%";
    [self.labelCompleted setText:[NSString stringWithFormat:@"%i%@",completed,prc]];
    [self.labelScore setText:[NSString stringWithFormat:@"%i",[[ReadData instance] score]]];
    
    if([self.comDet isComerceCompleted]){
        [self makeMedallaAnim:self.medalla];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pushFacebook:(id)sender{
    NSLog(@"Facebook");
    NSString *text= [NSString stringWithFormat:@"%@ Desbloquejat!",self.comDet.comerceName];

    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            }else{
                [self.comDet setDoneFb:YES];
                [[ReadData instance] add20];
                [self reportScore:[ReadData instance].score forCategory:@"RankingFinApps"];
                [flipView animateToValue:[[ReadData instance] score] withDuration:3];
                [self slideViewArrow:self.imagePointPos withDistance:65 andDelay:0];
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"FinAppsParty"  message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }

            [self viewWillAppear:NO];
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        
        [controller setInitialText:text];
        //            [controller addURL:[NSURL URLWithString:@"http://www.biapum.com"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

-(IBAction)pushTwitter:(id)sender{
    NSLog(@"Twitter");
    NSString *text= [NSString stringWithFormat:@"%@ Desbloquejat!",self.comDet.comerceName];
    
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    [tweetViewController setInitialText:text];
    
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        NSString *output;
        
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                // The cancel button was tapped.
                output = @"Tweet canceled";
                break;
            case TWTweetComposeViewControllerResultDone:
                // The tweet was sent.
                output = @"Tweet fet!";
                [self.comDet setDoneTwitter:YES];
                [[ReadData instance] add20];
                [self reportScore:[ReadData instance].score forCategory:@"RankingFinApps"];
                [flipView animateToValue:[[ReadData instance] score] withDuration:3];
                break;
            default:
                break;
        }
        
        [self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
        
        // Dismiss the tweet composition view controller.
        [self dismissModalViewControllerAnimated:YES];
    }];
    
    // Present the tweet composition view controller modally.
    [self presentModalViewController:tweetViewController animated:YES];
    [tweetViewController release];
}

- (void)displayText:(NSString *)text {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"FinAppsPartu" message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    [self slideViewArrow:self.imagePointPos withDistance:65 andDelay:0];
    [self viewWillAppear:NO];
}

-(IBAction)pushFoursquare:(id)sender{
    NSLog(@"Foursquare");
    NSString *text= [NSString stringWithFormat:@"%@ Desbloquejat via Foursquare!",self.comDet.comerceName];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"FinAppsParty" message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self.comDet setDoneFoursquare:YES];
    [[ReadData instance] add20];
    [self reportScore:[ReadData instance].score forCategory:@"RankingFinApps"];
    [flipView animateToValue:[[ReadData instance] score] withDuration:3];
    [self slideViewArrow:self.imagePointPos withDistance:65 andDelay:0];
    [self viewWillAppear:NO];
}

-(IBAction)pushInstagram:(id)sender{
    NSLog(@"Instagram");
    NSString *text= [NSString stringWithFormat:@"%@ Desbloquejat via Instagram!",self.comDet.comerceName];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"FinAppsParty" message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self.comDet setDoneInstagram:YES];
    [[ReadData instance] add20];
    [self reportScore:[ReadData instance].score forCategory:@"RankingFinApps"];
    [flipView animateToValue:[[ReadData instance] score] withDuration:3];
    [self slideViewArrow:self.imagePointPos withDistance:65 andDelay:0];
    [self viewWillAppear:NO];

}

#pragma mark - animations

- (void)slideViewArrow:(UIView *)viewArrow withDistance:(CGFloat)distance andDelay:(float)delay
{
    //CGRect posInicial= viewArrow.frame;
    
    CGRect posFinal= viewArrow.frame;
    
    posFinal.origin.x=posFinal.origin.x+distance;
    
    
    [UIView animateWithDuration:3 delay:delay options:0 animations:^{
        [viewArrow setFrame:posFinal];
    }
                     completion:^ (BOOL finished)
     {
         if (finished) {

             [UIView animateWithDuration:.3 delay:0 options:0 animations:^{
                 viewArrow.transform = CGAffineTransformMakeScale(1.1,1.1);
                 
             }
                              completion:^ (BOOL finished)
              {
                  if (finished) {
                      [UIView animateWithDuration:.3 delay:0 options:0 animations:^{
                          viewArrow.transform = CGAffineTransformMakeScale(1,1);
                          
                      }
                                       completion:^ (BOOL finished)
                       {
                           if (finished) {
                               
                               
                           }
                       }];
                      
                  }
              }];
         }
     }];
}

- (void)makeUnlockedAnim:(UIView *)viewArrow{
    
    [UIView animateWithDuration:.3 delay:0 options:0 animations:^{
        viewArrow.transform = CGAffineTransformMakeScale(1.1,1.1);
        
    }
                     completion:^ (BOOL finished)
     {
         if (finished) {
             [UIView animateWithDuration:.3 delay:0 options:0 animations:^{
                 viewArrow.transform = CGAffineTransformMakeScale(1,1);
                 
             }
                              completion:^ (BOOL finished)
              {
                  if (finished) {
                      
                      
                  }
              }];
             
         }
     }];
}

#pragma mark-
#pragma mark GameCenter

- (void) reportScore: (int64_t) score forCategory: (NSString*) category
{
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
    scoreReporter.value = score;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil)
        {
            // handle the reporting error
        }
    }];
    
    // grab an achievement description from where ever you saved them
    GKAchievementDescription *achievement = [[GKAchievementDescription alloc] init];
    
 
    [[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Més punts" andMessage:@"Has guanyat punts!"];
 
    
    [achievement release];
}

- (void)makeMedallaAnim:(UIView *)viewArrow{
    [self.medalla setHidden:NO];
    [self.medalla setAlpha:0.0f];
    [UIView animateWithDuration:.3 delay:3 options:0 animations:^{
        
        [self.medalla setAlpha:1.0f];
        viewArrow.transform = CGAffineTransformMakeScale(1.1,1.1);
        
    }
                     completion:^ (BOOL finished)
     {
         if (finished) {
             [UIView animateWithDuration:.3 delay:0 options:0 animations:^{
                 viewArrow.transform = CGAffineTransformMakeScale(1,1);
                 
             }
                              completion:^ (BOOL finished)
              {
                  if (finished) {
                      
                      
                  }
              }];
             
         }
     }];
}


@end
