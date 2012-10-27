//
//  HistoricPageViewController.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "HistoricPageViewController.h"
#import "DestepatsCell.h"
#import "ReadData.h"
#import "ComerceEntity.h"
#import "DetailPageViewController.h"

@interface HistoricPageViewController ()

@end

@implementation HistoricPageViewController
@synthesize list,myTableView;
@synthesize labelScore,flipView;

- (void)showMultipleDigits;
{
    self.flipView = [[JDGroupedFlipNumberView alloc] initWithFlipNumberViewCount:7];
    flipView.intValue = [[ReadData instance] score];
    flipView.tag = 99;
    [self.view addSubview: flipView];
    
}

-(void)dealloc{
    [flipView release];
    [labelScore release];
    [myTableView release];
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
    
    self.myTableView.initialCellTransformBlock = ADLivelyTransformTilt;
    self.list = [[ReadData instance] arrayComerceUnlocked];
    
    //[self showMultipleDigits];
    self.navigationController.navigationBar.topItem.title = @"Descoberts";

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.list = [[ReadData instance] arrayComerceUnlocked];
    [self.myTableView reloadData];
    [self.labelScore setText:[NSString stringWithFormat:@"%i",[[ReadData instance] score]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return [self.arrayResult count];
    // Return the number of rows in the section.
    return [self.list count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DestepatsCell";
	
    DestepatsCell *cell = (DestepatsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DestepatsCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (DestepatsCell *) currentObject;
				break;
			}
		}
	}
	
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    ComerceEntity *sec = [self.list objectAtIndex:indexPath.row];
	[cell.labelText setText:sec.comerceName];
    
    NSString *perc = @"%";
    
    int percent = [sec getPercent];
    [cell.labelParcent setText:[NSString stringWithFormat:@"%i%@ completed",percent,perc]];
    
    if(sec.doneFb)
       [cell.imageFb setHidden:NO];
    if(sec.doneTwitter)
        [cell.imageTw setHidden:NO];
    if(sec.doneFoursquare)
        [cell.imageFq setHidden:NO];
    if(sec.doneInstagram)
        [cell.imageIns setHidden:NO];
    if(sec.isCompleted)
        [cell.imageMedalla setHidden:NO];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    GroupSection *sec = [self.listArtistsVC objectAtIndex:indexPath.section];
//    Concert *off = [sec.arrayGroups objectAtIndex:indexPath.row];
//    
//    DetallViewController *detallVC = [[DetallViewController alloc] initWithNibName:@"DetallViewController" bundle:nil andCon:off];
//    [self.navigationController pushViewController:detallVC animated:YES];
//    [detallVC release];
    
    ComerceEntity *com = [self.list objectAtIndex:indexPath.row];
    
    DetailPageViewController *vc = [[DetailPageViewController alloc] initWithNibName:@"DetailPageViewController" bundle:nil andPoint:com];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	[self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


@end
