//
//  InfoPageViewController.h
//  FinAppsParty
//
//  Created by Valenti on 27/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoPageViewController : UIViewController{
    NSString    *stringText;
    UITextView  *textViewDesc;
}

@property (nonatomic,retain) NSString               *stringText;
@property (nonatomic,retain) IBOutlet UITextView    *textViewDesc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andText:(NSString*)text_;
@end
