//
//  MSNetworkingSession.h
//  MedicalSample
//
//  Created by Harmon, Eric on 6/28/14.
//  Copyright (c) 2014 Sample. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSNetworkingSession : NSObject

+ (NSURLSession *)sharedSession;

@end
