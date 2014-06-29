//
//  MSCommentsViewController.m
//  MedicalSample
//
//  Created by Harmon, Eric on 6/29/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import "MSResponseViewController.h"
#import "MSPostTableViewCell.h"
#import "MSResponseTableViewCell.h"
#import "MSPost.h"
#import "MSResponse.h"


@interface MSResponseViewController ()

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end

@implementation MSResponseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Methods

//Create invisible footer to disable blank cells
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
        //Ensure the post gets the full size
        return 340.0;
    else if (indexPath.row < [self.post.responses count] + 1)
        return 60;
    else
        //Make last cell bigger due to the asset
        return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.post.responses count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return [self createPostCell];
    else
        return [self createResponseCellAtIndexPath:indexPath];
}

- (UITableViewCell *)createPostCell
{
    MSPost *post = self.post;
    NSString *reuseIdentifier = @"postCell";
    MSPostTableViewCell *tableCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!tableCell) {
        tableCell = [[MSPostTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    tableCell.postDescriptionLabel.text = post.description;
    [tableCell.postDescriptionLabel setTextColor:[UIColor colorWithRed:255.0/255.0f green:102.0/255.0f blue:0.0f alpha:1]];
    tableCell.postImageView.image = post.postImage;
    [tableCell.postDescriptionLabel sizeToFit];
    return tableCell;

}

- (UITableViewCell *)createResponseCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if (indexPath.row < [self.tableView numberOfRowsInSection:indexPath.section] -1)
        reuseIdentifier = @"responseCell";
    else
        reuseIdentifier = @"responseCellEnd";
    
    MSResponseTableViewCell *tableCell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!tableCell) {
        tableCell = [[MSResponseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }

    if ([self.post.responses count] > 0)
    {
        MSResponse *response = [self.post.responses objectAtIndex:indexPath.row -1];
        tableCell.responseLabel.text = response.response;
        [tableCell.responseLabel sizeToFit];
    }

    return tableCell;
}

@end
