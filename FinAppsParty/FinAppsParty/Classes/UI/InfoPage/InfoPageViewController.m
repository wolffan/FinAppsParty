//
//  InfoPageViewController.m
//  FinAppsParty
//
//  Created by Valenti on 27/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "InfoPageViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface InfoPageViewController ()

@end

@implementation InfoPageViewController

@synthesize stringText,textViewDesc;

-(void)dealloc{
    [stringText release];
    [textViewDesc release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andText:(NSString*)text_
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.stringText = text_;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer *l6 = [self.view layer];
    [l6 setMasksToBounds:YES];
    [l6 setCornerRadius:20.0];
    
    // You can even add a border
    [l6 setBorderWidth:1.25];
    [l6 setBorderColor:[[UIColor colorWithRed:132.0f/255 green:81.0f/255 blue:161.0f/255 alpha:1] CGColor]];
    [self.textViewDesc setText:self.stringText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
