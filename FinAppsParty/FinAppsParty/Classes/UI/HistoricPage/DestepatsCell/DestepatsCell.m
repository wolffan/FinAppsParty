//
//  DestepatsCell.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "DestepatsCell.h"

@implementation DestepatsCell
@synthesize labelText,labelParcent;

@synthesize imageFb,imageTw,imageFq,imageIns,imageMedalla;

-(void)dealloc{
    [imageMedalla release];
    [labelParcent release];
    [labelText release];
    [imageFb release];
    [imageTw release];
    [imageFq release];
    [imageIns release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
