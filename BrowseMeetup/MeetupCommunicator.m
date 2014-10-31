//
//  MeetupCommunicator.m
//  BrowseMeetup
//
//  Created by Alexander Kuliev on 10/31/14.
//  Copyright (c) 2014 Alexander Kuliev. All rights reserved.
//

#import "MeetupCommunicator.h"
#import "MeetupCommunicatorDelegate.h"

#define API_KEY @"28373a1266b4a452483e642f2d6e64"
#define PAGE_COUNT 20


@implementation MeetupCommunicator

-(void)searchGroupsAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.meetup.com/2/groups?lat=%f&lon=%f&page=%d&key=%@",coordinate.latitude, coordinate.longitude, PAGE_COUNT, API_KEY];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingGroupsFailedWithError:error];
        } else {
            [self.delegate receivedGroupsJSON:data];
        }
    }];
}

@end
