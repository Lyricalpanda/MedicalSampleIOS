//
//  MSPost.m
//  MedicalSample
//
//  Created by Harmon, Eric on 6/28/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import "MSPost.h"

@implementation MSPost

- (id) init
{
    self = [super init]; //calls init because UIResponder has no custom init methods
    if (self){
        self.responses = [NSMutableArray array];
        self.imgurLink = @"";
        self.description = @"";
    }
    return self;
}

@end
