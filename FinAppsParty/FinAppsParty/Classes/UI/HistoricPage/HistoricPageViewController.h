//
//  HistoricPageViewController.h
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADLivelyTableView.h"

#import "JDFlipNumberView.h"
#import "JDGroupedFlipNumberView.h"
#import "JDDateCountdownFlipView.h"

@interface HistoricPageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray          *list;
    ADLivelyTableView       *myTableView;
    
    UILabel                 *labelScore;
    
    JDGroupedFlipNumberView *flipView;
}

@property (nonatomic,retain) JDGroupedFlipNumberView    *flipView;

@property (nonatomic,retain) NSMutableArray                 *list;
@property (nonatomic,retain) IBOutlet ADLivelyTableView     *myTableView;
@property (nonatomic,retain) IBOutlet UILabel               *labelScore;

@end
