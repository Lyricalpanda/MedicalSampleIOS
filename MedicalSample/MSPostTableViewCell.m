//
//  MSPostTableViewCell.m
//  MedicalSample
//
//  Created by Harmon, Eric on 6/28/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import "MSPostTableViewCell.h"

@implementation MSPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
