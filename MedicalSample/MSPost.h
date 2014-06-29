//
//  MSPost.h
//  MedicalSample
//
//  Created by Harmon, Eric on 6/28/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSPost : NSObject

@property (nonatomic, retain) NSString *imgurLink;
@property (nonatomic, retain) NSMutableArray *responses;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) UIImage *postImage;

@end
