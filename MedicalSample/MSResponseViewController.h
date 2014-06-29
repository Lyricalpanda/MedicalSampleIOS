//
//  MSCommentsViewController.h
//  MedicalSample
//
//  Created by Harmon, Eric on 6/29/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSPost.h"
#import "MSResponse.h"

@interface MSResponseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) MSPost *post;

@end
