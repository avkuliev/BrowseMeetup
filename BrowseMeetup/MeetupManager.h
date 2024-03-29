//
//  MeetupManager.h
//  BrowseMeetup
//
//  Created by Alexander Kuliev on 10/31/14.
//  Copyright (c) 2014 Alexander Kuliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "MeetupManagerDelegate.h"
#import "MeetupCommunicatorDelegate.h"

@class MeetupCommunicator;

@interface MeetupManager : NSObject<MeetupCommunicatorDelegate>

@property (strong, nonatomic) MeetupCommunicator *communicator;
@property (weak, nonatomic) id<MeetupManagerDelegate> delegate;

-(void)fetchGroupsAtCoordinate:(CLLocationCoordinate2D)coordinate;

@end
