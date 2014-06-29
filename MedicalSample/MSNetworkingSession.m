//
//  MSNetworkingSession.m
//  MedicalSample
//
//  Created by Harmon, Eric on 6/28/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import "MSNetworkingSession.h"

@implementation MSNetworkingSession

+ (NSURLSession *)sharedSession
{
    static NSURLSession *sharedSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedSession = [NSURLSession sessionWithConfiguration:config];
    });
    return sharedSession;
}

@end
