//
//  MSPostTableViewCell.h
//  MedicalSample
//
//  Created by Harmon, Eric on 6/28/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPostTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *postImageView;
@property (nonatomic, retain) IBOutlet UILabel *postDescriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberOfResponsesLabel;

@end
