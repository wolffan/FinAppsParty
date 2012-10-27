//
//  DestepatsCell.h
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestepatsCell : UITableViewCell
{
    UILabel         *labelText;
    UILabel         *labelParcent;
    UIImageView     *imageFb;
    UIImageView     *imageTw;
    UIImageView     *imageFq;
    UIImageView     *imageIns;

    UIImageView     *imageMedalla;
}

@property (nonatomic,retain) IBOutlet UILabel           *labelText;
@property (nonatomic,retain) IBOutlet UIImageView       *imageFb;
@property (nonatomic,retain) IBOutlet UIImageView       *imageTw;
@property (nonatomic,retain) IBOutlet UIImageView       *imageFq;
@property (nonatomic,retain) IBOutlet UIImageView       *imageIns;
@property (nonatomic,retain) IBOutlet UIImageView       *imageMedalla;

@property (nonatomic,retain) IBOutlet UILabel           *labelParcent;


@end
