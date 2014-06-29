//
//  TAViewController.m
//  MedicalSample
//
//  Created by Harmon, Eric on 6/28/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import "MSPostViewController.h"
#import "MSNetworkingSession.h"
#import "MSPost.h"
#import "MSResponse.h"
#import "MSPostTableViewCell.h"
#import "MSResponseViewController.h"

#define MEDICAL_URL @"http://localhost:3000/api/posts"

@interface MSPostViewController ()

@property (nonatomic, retain) NSURLSession *session;
@property (nonatomic, retain) NSMutableArray *posts;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIView *shadedView;
@property (nonatomic, retain) MSPost *selectedPost;

@end

@implementation MSPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.posts = [NSMutableArray array];
    self.session = [MSNetworkingSession sharedSession];
    
    [self getPostsFromAPI];
}

- (void) getPostsFromAPI
{
    NSURL *medicalURL = [NSURL URLWithString:MEDICAL_URL];
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithURL:medicalURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                
                NSError *jsonError;
                
                NSDictionary *postsJSON =
                [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                
                if (!jsonError) {
                    
                    for (NSDictionary *postDict in postsJSON)
                    {
                        MSPost *post = [MSPost new];
                        post.description = [postDict objectForKey:@"description"];
                        post.imgurLink = [postDict objectForKey:@"imgur_link"];
                        
                        NSArray *responses = [postDict objectForKey:@"responses"];
                        
                        for (NSDictionary *responsesDict in responses)
                        {
                            MSResponse *response = [MSResponse new];
                            response.response = [responsesDict objectForKey:@"response"];
                            [post.responses addObject:response];
                        }
                        
                        [self.posts addObject:post];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [self.tableView reloadData];
                    });
                }
            }
        }
    }];
    [dataTask resume];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MSResponseViewController class]])
    {
        MSResponseViewController *segueVC = (MSResponseViewController *)segue.destinationViewController;
        segueVC.post = self.selectedPost;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

//Create invisible footer to disable blank cells
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSPost *post = [self.posts objectAtIndex:indexPath.row];
    NSString *reuseIdentifier;
        
    if (indexPath.row < [tableView numberOfRowsInSection:indexPath.section] -1)
        reuseIdentifier = @"postCell";
    else
        reuseIdentifier = @"postCellEnd";
    
    MSPostTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!tableCell) {
        tableCell = [[MSPostTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }

    tableCell.postDescriptionLabel.text = post.description;
    [tableCell.postDescriptionLabel setTextColor:[UIColor colorWithRed:255.0/255.0f green:102.0/255.0f blue:0.0f alpha:1]];
    [tableCell.postDescriptionLabel sizeToFit];

    tableCell.numberOfResponsesLabel.text = [NSString stringWithFormat:@"%d",[post.responses count]];
    
    //Grab image if we haven't already cached it.
    if ([post.imgurLink length] > 0 && !post.postImage)
    {
        NSURLSessionDownloadTask *getImageTask =
        [self.session downloadTaskWithURL:[NSURL URLWithString:post.imgurLink]
     
               completionHandler:^(NSURL *location,
                                   NSURLResponse *response,
                                   NSError *error) {
                   UIImage *downloadedImage =
                   [UIImage imageWithData:
                    [NSData dataWithContentsOfURL:location]];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       //Once we've gotten the image, place it into the cell and cache it so we don't get it again.
                       post.postImage = downloadedImage;
                       tableCell.postImageView.image = downloadedImage;
                   });
               }];
        [getImageTask resume];
    }
    else
    {
        tableCell.postImageView.image = post.postImage;
    }
    
    tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return tableCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPost = [self.posts objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"postSegue" sender:self];
}

@end
